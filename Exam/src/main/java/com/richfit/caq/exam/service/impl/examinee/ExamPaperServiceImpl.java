package com.richfit.caq.exam.service.impl.examinee;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

import com.richfit.caq.controller.LocalThread;
import com.richfit.caq.exam.service.impl.PaperCaseServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.richfit.caq.comm.dao.BaseDao;
import com.richfit.caq.comm.db.DOL;
import com.richfit.caq.comm.entity.CrudModel;
import com.richfit.caq.comm.entity.ListModel;
import com.richfit.caq.comm.entity.OperateModel;
import com.richfit.caq.comm.entity.SelectBean;
import com.richfit.caq.comm.exception.BusinessException;
import com.richfit.caq.comm.service.DataOperater;

import javax.json.JsonArray;
import javax.json.JsonObject;

/**
 * 试卷service
 *
 * @param
 * @author sunguowei
 */
@DOL
@Service("examPaperDOL")
public class ExamPaperServiceImpl implements DataOperater {
    Logger logger = LoggerFactory.getLogger(ExamPaperServiceImpl.class);
    @Autowired
    private BaseDao baseDao;

    @Autowired
    private DataOperater paperCaseDOL;

    @Autowired
    private DataOperater answerPaperDOL;

    private String namespace = "com.richfit.caq.exam.service.impl.examinee.examPaper";


    @Override
    public CrudModel get(String id) throws BusinessException {
        CrudModel model = new CrudModel();

        CrudModel model2 = new CrudModel(baseDao.select(new SelectBean("exam_case_id", id), namespace + ".getStartTime"));
        //考试开始时间
        String starttime = model2.getRow().get("starttime").toString();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        ParsePosition pos = new ParsePosition(0);
        long start_Time = formatter.parse(starttime, pos).getTime()/1000;//考试时间秒值

        long now_Time = new Date().getTime() / 1000;//当前时间秒值
        if(start_Time > now_Time){//考试未开始
            model.setResult("no_start");
        }else {//考试已开始
            String accountId = LocalThread.getUser().getAccountId();
            //查询当前登录用户是否有报名本次考试
            ListModel listModel1 = baseDao.select(new SelectBean("exam_case_id", id, "examinee_info_id", accountId), namespace + ".getLonginExam");
            if (listModel1.getRows().size() < 1) {//未报名本次考试
                model = new CrudModel();
                model.setResult("0");
            } else {//已报名本次考试
                //根据考生id和考试实例查询是否答过卷
                ListModel listModel2 = baseDao.select(new SelectBean("exam_case_id", id, "examinee_info_id", accountId), namespace + ".getAnswerPaper");
                if (listModel2.getRows().size() > 0) {//答过卷
                    model = new CrudModel(listModel2);
                } else {//未答过卷
                    //查询考试策略和试卷策略
                    CrudModel crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), namespace + ".getExamPolicyId"));
                    String is_beforehand = crudModel.getRow().get("is_beforehand").toString();
                    String paper_id = crudModel.getRow().get("paper_id").toString();
                    if ("2".equals(is_beforehand)) {//试卷策略是现生成
                        //根据考生id和考试实例查询是否答过卷
                        ListModel listModel = baseDao.select(new SelectBean("exam_case_id", id, "examinee_info_id", accountId), namespace + ".getAnswerPaper");
                        if (listModel.getRows().size() > 0) {//答过卷，直接在答卷表中获取试卷
                            model = new CrudModel(listModel);
                        } else {//未答过卷，查询考试实例
                            //查询奖考试实例
                            CrudModel model1 = new CrudModel(baseDao.select(new SelectBean("id", id), namespace + ".getExamById"));

                            //题目是否乱序
                            String topic_is_disorder = model1.getRow().get("topic_is_disorder").toString();
                            //选项是否乱序
                            String option_is_disorder = model1.getRow().get("option_is_disorder").toString();

                            //现生成试卷,返回json格式试卷
                            ListModel list = paperCaseDOL.getList(new SelectBean("query", "101", "paper_id", paper_id));
                            String examPaperJson = list.getRows().get(0).get("realTimeMakePaperJson").toString();
                            //试卷不为空
                            if (examPaperJson != null && "".equals(examPaperJson)) {
                                //打乱试卷
                                Map<String, Object> content_Map = breakRank(examPaperJson, topic_is_disorder, option_is_disorder);

                                //保存到答卷表中
                                String uuid = UUID.randomUUID().toString().replace("-", "");
                                HashMap<String, Object> map = new HashMap<String, Object>();

                                map.put("id", uuid);
                                map.put("exam_case_id", id);
                                map.put("examinee_info_id", "1");
                                map.put("content", content_Map.toString());
                                int i = baseDao.operate(map, namespace + ".save");
                                if (i > 0) {
                                    model.setResult("success");
                                } else {
                                    throw new BusinessException("获取试卷失败！");
                                }

                                Map<String, Object> row = model1.getRow();
                                row.put("answer_paper_id", uuid);
                                row.put("paper_case_id", "");
                                row.put("paper_case_name", "");
                                row.put("content", content_Map.toString());
                                model = model1;
                            } else {
                                throw new BusinessException("暂无试卷！");
                            }
                        }
                    } else {//试卷策略是其他
                        ListModel listModel = baseDao.select(new SelectBean("exam_case_id", id), namespace + ".getByExamId");
                        model = new CrudModel(listModel);
                        Map<String, Object> row = model.getRow();

                        int count_used = Integer.parseInt(row.get("count_used").toString());//已用次数

                        //如果试卷不为空
                        if (model.getRow().get("content").toString() != null && !"".equals(model.getRow().get("content").toString())) {

                            //如果是预生成，修改已用次数
                            if ("1".equals(is_beforehand)){
                                HashMap<String, Object> hashMap = new HashMap<>();

                                hashMap.put("paper_case_id", model.getRow().get("paper_case_id").toString());
                                //hashMap.put("count_used",count_used + 1);

                                int operate = baseDao.operate(hashMap, namespace + ".editCountUsed");
                                if (operate > 0) {
                                    model.setResult("success");
                                } else {
                                    throw new BusinessException("获取试卷失败！");
                                }
                            }

                            //题目是否乱序
                            String topic_is_disorder = model.getRow().get("topic_is_disorder").toString();
                            //选项是否乱序
                            String option_is_disorder = model.getRow().get("option_is_disorder").toString();
                            //拿到试卷json
                            String content = model.getRow().get("content").toString();
                            //打乱试卷
                            Map<String, Object> content_Map = breakRank(content, topic_is_disorder, option_is_disorder);

                            model.getRow().put("content", content_Map.toString());

                            //将试卷内容保存到答卷表中
                            String uuid = UUID.randomUUID().toString().replace("-", "");
                            HashMap<String, Object> map = new HashMap<String, Object>();

                            model.getRow().put("answer_paper_id", uuid);

                            map.put("id", uuid);
                            map.put("exam_case_id", id);
                            map.put("paper_case_id", model.getRow().get("paper_case_id"));
                            map.put("examinee_info_id", accountId);
                            map.put("content", content_Map.toString());
                            int i = baseDao.operate(map, namespace + ".save");
                            if (i > 0) {
                                model.setResult("error");
                            } else {
                                throw new BusinessException("获取试卷失败！");
                            }
                        } else {
                            throw new BusinessException("暂无可用试卷，请联系管理员！");
                        }
                    }
                    model.getRow().put("submit_flag", 1);
                }
            }
        }
        return model;
    }

    @Override
    public ListModel getList(SelectBean selectBean) throws BusinessException {

        return baseDao.select(selectBean, namespace + ".getList");
    }

    @Override
    public OperateModel add(Map<String, Object> map) throws BusinessException {
        OperateModel model = new OperateModel();
        map.put("examinee_info_id", LocalThread.getUser().getAccountId());
        String submit_flag = map.get("submit_flag").toString();//提交状态
        String exam_case_id = map.get("exam_case_id").toString();

        CrudModel model2 = new CrudModel(baseDao.select(new SelectBean("exam_case_id", exam_case_id), namespace + ".getStartTime"));
        //考试开始时间
        String endtime = model2.getRow().get("endtime").toString();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        ParsePosition pos = new ParsePosition(0);
        long end_time = formatter.parse(endtime, pos).getTime()/1000+10000;//考试结束时间秒值

        long now_Time = new Date().getTime() / 1000;//当前时间秒值

        if("2".equals(submit_flag) && now_Time>end_time){
            model.setResult("exam_end");
        }else {
            int operate = baseDao.operate(map, namespace + ".updateAnswerPaper");

            if("2".equals(submit_flag)){//如果是提交，则保存到答卷详情表
                OperateModel model1 = answerPaperDOL.add(map);
            }
            if (operate > 0) {
                model.setResult("success");
            } else {
                throw new BusinessException("答卷保存失败！");
            }
        }
        return model;
    }

    @Override
    public OperateModel edit(Map<String, Object> map) throws BusinessException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public OperateModel remove(String id) throws BusinessException {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * 打乱试卷
     *
     * @param content
     * @param topic_is_disorder
     * @param option_is_disorder
     * @return
     */
    public Map<String, Object> breakRank(String content, String topic_is_disorder, String option_is_disorder) {
        Map<String, Object> content_Map = JSONObject.fromObject(content);

        List<Map<String, Object>> chapters = (List) JSONArray.fromObject(content_Map.get("chapter"));//章节集合
        for (Map<String, Object> chapter : chapters) {
            List<Map<String, Object>> questions = (List) JSONArray.fromObject(chapter.get("question"));//题目集合
            //选项打乱
            if ("1".equals(option_is_disorder)) {
                for (Map<String, Object> question : questions) {
                    List<Map<String, Object>> options = JSONArray.fromObject(question.get("option"));//选项集合
                    Collections.shuffle(options);
                    question.put("option", options);
                }
            }
            //题目打乱
            if ("1".equals(topic_is_disorder)) {
                Collections.shuffle(questions);
                chapter.put("question", questions);
            }
        }
        content_Map.put("chapter", chapters);
        return content_Map;
    }

}
