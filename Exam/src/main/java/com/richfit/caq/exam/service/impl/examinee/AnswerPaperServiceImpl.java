package com.richfit.caq.exam.service.impl.examinee;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

@DOL
@Service("answerPaperDOL")
public class AnswerPaperServiceImpl implements DataOperater {
	@Autowired
	private BaseDao baseDao;
	private String namespace = "com.richfit.caq.exam.service.impl.examinee.examPaper";
	@Override
	public CrudModel get(String id) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		OperateModel model = new OperateModel();
		String answer_paper_id = map.get("answer_paper_id").toString();//答卷ID
		
		//查询每道题对应的答案
		/*ListModel listModel = baseDao.select(new SelectBean("paper_case_id", paper_case_id), namespace+".getQuestionAnswer");
		List<Map<String, Object>> rows = listModel.getRows();*/


		List<Map<String, Object>> answer_papers = (List<Map<String, Object>>)map.get("answer_paper");//答卷
		
		Map<String, Object> hashMap = null;
		int fenshu = 0;
		for (int i = 0; i < answer_papers.size(); i++) {
			String uuid = UUID.randomUUID().toString().replace("-", "");
			String question_id = answer_papers.get(i).get("ques_id").toString();//每道题的ID
			String opt_id = answer_papers.get(i).get("opts_id").toString();//选项拼的字符串
			
			hashMap = new HashMap<String, Object>();
			hashMap.put("id", uuid);
			hashMap.put("answer_paper_id", answer_paper_id);
			hashMap.put("question_id", question_id);
			hashMap.put("question_option_id", opt_id);

			//计算每道题的得分并保存到数据库
			/*String[] optId = opt_id.split(",");//将选项分割成数组
			for (int j = 0; j < rows.size(); j++) {
				String ques_id = rows.get(j).get("question_id").toString();//题id
				String option_id = rows.get(j).get("option_id").toString();//每道题的正确选项
				String grade = rows.get(j).get("grade").toString();//每道题的分数
				String[] optIds = option_id.split(",");//将选项分割成数组
				if(question_id.equals(ques_id)){
					if(optId.length!=optIds.length){//数组长度不一致,直接得零分
						hashMap.put("score", 0);
					}else{//循环比较相同的个数
						int c = 0;
						for (int k = 0; k < optId.length; k++) {
							for (int m = 0; m < optIds.length; m++) {
								if(optId[k].equals(optIds[m])){
									c++;
								}
							}
						}
						if (c == optId.length && c == optIds.length) {//相同的个数一致,得分
							hashMap.put("score", grade);
						}else{
							hashMap.put("score", 0);
						}
					}
				}
			}
			fenshu += Integer.parseInt(hashMap.get("score").toString());
			baseDao.operate(hashMap, namespace+".saveAnswerPaperDetail");*/

            int operate = baseDao.operate(hashMap, namespace + ".saveAnswerPaperDetail");
            if(operate>0){
                model.setResult("success");
            }
        }
        //保存总分
		/*Map<String, Object> hashMap2 = new HashMap<String, Object>();
		hashMap2.put("id", answer_paper_id);
		hashMap2.put("total_score", fenshu);
		int operate = baseDao.operate(hashMap2, namespace+".saveTotalScore");
		if(operate>0){
			model.setResult("success");
		}*/
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

}
