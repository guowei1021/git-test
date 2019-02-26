package com.richfit.caq.exam.service.impl;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.richfit.caq.comm.dao.BaseDao;
import com.richfit.caq.comm.db.DOL;
import com.richfit.caq.comm.entity.CrudModel;
import com.richfit.caq.comm.entity.ErrorModel;
import com.richfit.caq.comm.entity.ListModel;
import com.richfit.caq.comm.entity.OperateModel;
import com.richfit.caq.comm.entity.SelectBean;
import com.richfit.caq.comm.exception.BusinessException;
import com.richfit.caq.comm.service.DataOperater;
import com.richfit.caq.exam.util.UserCacheUtils;

/**
 * 试卷实例模块
 * @author XueMancang (If you want to change this class, please contact me first!)
 */
@DOL
@Service("paperCaseDOL")
public class PaperCaseServiceImpl implements DataOperater {
	private final static Logger logger = LoggerFactory.getLogger(PaperCaseServiceImpl.class);

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 单条查询
	 */
	@Override
	public CrudModel get(String id) {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "paperCase.select"));
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		return crudModel;
	}

	/**
	 * 分页查询
	 * @throws BusinessException 
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		ListModel listModel = null;

		//query:0查某考试实例对应的试卷实例1查某静态试卷对应的试卷实例2根据考试实例id找到静态考试再找到静态试卷（多个）3查询某考试实例下某章节下面对应的题目
		String query = selectBean.getParameters().get("query").toString();
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "paperCase.selectAll");
		}
		if("1".equals(query)){
			//logger.info(realTimeMakePaper("4beece5feb2d4392abef487a605dde2c"));
			listModel = baseDao.select(selectBean, "paperCase.selectAllByPaper");
		}
		if("2".equals(query)){
			listModel = baseDao.select(selectBean, "paperCase.selectPapers");
		}
		if("3".equals(query)){
			listModel = baseDao.select(selectBean, "paperDetail.selectChapterQuestion");
		}
		if("101".equals(query)){
			String realTimeMakePaperJson = realTimeMakePaper( (String) selectBean.getParameters().get("paper_id"));
			listModel = new ListModel();
			List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
			Map<String, Object> tempMap = new HashMap<String, Object>();
			tempMap.put("realTimeMakePaperJson", realTimeMakePaperJson);
			rows.add(tempMap);
			listModel.setRows(rows);
		}
		return listModel;
	}

	/**
	 * 新增试卷实例
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		map = verificationInformation(map);
		//试卷实例表
		String paper_case_id = UUID.randomUUID().toString().replace("-", "");
		map.put("id", paper_case_id);//ID
		map.put("type", "1");//手动卷
		baseDao.operate(map, "paperCase.post");
		
		//试卷详情表
		@SuppressWarnings("unchecked")
		List<Map<String,Object>> list = (List<Map<String,Object>>)map.get("pp");
		if(list!=null && list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> chapterMap = list.get(i);
				String chapterId = (String)chapterMap.get("chapter_id");
				@SuppressWarnings("unchecked")
				List<Map<String,Object>> infoList = (List<Map<String,Object>>)chapterMap.get("info");
				if(infoList!=null && infoList.size()>0){
					for (int j = 0; j < infoList.size(); j++) {
						Map<String, Object> questionMap = infoList.get(j);
						String questionId = (String)questionMap.get("question_id");
						String grade = (String)questionMap.get("grade");
						HashMap<String, Object> paramMap = new HashMap<String,Object>();
						paramMap.put("id", UUID.randomUUID().toString().replace("-", ""));//补充字段
						paramMap.put("question_id", questionId);//补充字段
						paramMap.put("chapter_id", chapterId);//补充字段
						paramMap.put("grade", grade);//补充字段
						paramMap.put("orders", j+1);//补充字段
						paramMap.put("paper_case_id", paper_case_id);//补充字段
						paramMap.put("create_user_id", UserCacheUtils.getUserId());//补充字段
						baseDao.operate(paramMap, "paperDetail.post");
					}
				}
			}
		}
		
		//试卷实例表JSON字段
		HashMap<String, Object> jMap = new HashMap<String, Object>();
		jMap.put("id", paper_case_id);
		jMap.put("content", getContent(paper_case_id, (String)map.get("name")));
		baseDao.operate(jMap, "paperCase.putJson");
		return successOperateModel("200", "新增试卷实例成功！");
	}
	
	/**
	 * 修改、删除试卷实例
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		//operate:0修改1删除2自动出卷并记录JSON3添加试卷实例与考试实例的关系4删除试卷实例与考试实例的关系5清空某考试实例所有自动卷
		String operate = map.get("operate").toString();
		if("0".equals(operate)){
			map = verificationInformation(map);
			//试卷实例表
			map.put("type", "1");//只要经过修改，全变为手动卷
			baseDao.operate(map, "paperCase.put");
			//试卷详情表（先删后增）
			baseDao.operate(map, "paperDetail.delete");
			@SuppressWarnings("unchecked")
			List<Map<String,Object>> list = (List<Map<String,Object>>)map.get("pp");
			if(list!=null && list.size()>0){
				for (int i = 0; i < list.size(); i++) {
					Map<String, Object> chapterMap = list.get(i);
					String chapterId = (String)chapterMap.get("chapter_id");
					@SuppressWarnings("unchecked")
					List<Map<String,Object>> infoList = (List<Map<String,Object>>)chapterMap.get("info");
					if(infoList!=null && infoList.size()>0){
						for (int j = 0; j < infoList.size(); j++) {
							Map<String, Object> questionMap = infoList.get(j);
							String questionId = (String)questionMap.get("question_id");
							String grade = (String)questionMap.get("grade");
							HashMap<String, Object> paramMap = new HashMap<String,Object>();
							paramMap.put("id", UUID.randomUUID().toString().replace("-", ""));//补充字段
							paramMap.put("question_id", questionId);//补充字段
							paramMap.put("chapter_id", chapterId);//补充字段
							paramMap.put("grade", grade);//补充字段
							paramMap.put("orders", j+1);//补充字段
							paramMap.put("paper_case_id", (String)map.get("id"));//补充字段
							paramMap.put("create_user_id", UserCacheUtils.getUserId());//补充字段
							baseDao.operate(paramMap, "paperDetail.post");
						}
					}
				}
			}
			
			//试卷实例表JSON字段
			String paper_case_id = (String)map.get("id");
			HashMap<String, Object> jMap = new HashMap<String, Object>();
			jMap.put("id", paper_case_id);
			jMap.put("content", getContent(paper_case_id, (String)map.get("name")));
			baseDao.operate(jMap, "paperCase.putJson");
			return successOperateModel("200", "修改试卷实例成功！");
		}
		if("1".equals(operate)){
			//如果该卷子被其它考试引用，则无法直接删除
			ListModel listModel = baseDao.select(new SelectBean("paper_case_id",(String)map.get("id")),
				"paperCase.selectIsOut");
			if(listModel.getRows()!=null && listModel.getRows().size()>0){
				throw new BusinessException("该试卷被其它考试引用，无法直接删除！");
			}
			
			//试卷详情表
			baseDao.operate(map, "paperDetail.delete");
			//试卷实例表
			baseDao.operate(map, "paperCase.delete");
			return successOperateModel("200", "删除试卷实例成功！");
		}
		if("2".equals(operate)){//自动出卷并记录JSON（0，1）
			//如果没有章节和相应的策略，不能自动出卷
			ListModel listModel = baseDao.select(new SelectBean("paper_id",(String)map.get("paper_id")), 
					"paperDetail.selectChapterAndPolicy");
			if(listModel.getRows()!=null && listModel.getRows().size()>0){//有章节
				for (int i = 0; i < listModel.getRows().size(); i++) {
					Object object = listModel.getRows().get(i).get("cpid");
					if(object==null){//有的章节没策略
						throw new BusinessException("章节策略信息不全，不能自动出卷！");
					}
				}
				autoMakePaper((String)map.get("paper_id"));//自动出卷去啦！
			}else{
				throw new BusinessException("没有章节和相应的策略，不能自动出卷！");
			}
			return successOperateModel("200", "自动出卷成功！");
		}
		if("3".equals(operate)){//配置试卷实例与考试实例的关系
			//如果已经存在，就不能再添加了
			ListModel listModel = baseDao.select(new SelectBean("exam_case_id",(String)map.get("exam_case_id"),
				"paper_case_id",(String)map.get("paper_case_id")), "paperCase.selectIsTo");
			if(listModel.getRows()!=null && listModel.getRows().size()>0){
				throw new BusinessException("已经配置过该张试卷，请勿重复添加！");
			}
			map.put("id", UUID.randomUUID().toString().replace("-", ""));
			baseDao.operate(map, "paperCase.postTo");
			return successOperateModel("200", "配置试卷成功！");
		}
		if("4".equals(operate)){//删除试卷实例与考试实例的关系
			baseDao.operate(map, "paperCase.deleteTo");
			return successOperateModel("200", "删除试卷成功！");
		}
		if("5".equals(operate)){//清空某考试实例所有自动卷
			ListModel listModel = baseDao.select(new SelectBean("exam_case_id", (String)map.get("exam_case_id")), 
				"paperCase.selectAutoPapers");
			if(listModel.getRows()!=null && listModel.getRows().size()>0){
				//先清空所有考试实例对某考试实例下所有自动卷的关联
				for (int i = 0; i < listModel.getRows().size(); i++) {
					map.put("paper_case_id", listModel.getRows().get(i).get("id"));
					baseDao.operate(map, "paperCase.deleteTo");
				}
				//再删除这些自动卷
				for (int i = 0; i < listModel.getRows().size(); i++) {
					map.put("id", listModel.getRows().get(i).get("id"));
					baseDao.operate(map, "paperCase.delete");
				}
			}
			return successOperateModel("200", "清空试卷成功！");
		}
		return successOperateModel("200", "操作成功！");
	}

	@Override
	public OperateModel remove(String id) throws BusinessException {
		return null;
	}
	
	/**
	 * 生成卷子json方法
	 * @param paper_case_id
	 * @return
	 */
	private String getContent(String paper_case_id, String paper_case_name) {
		//查
		HashMap<String, Object> jChapterMap = new HashMap<String, Object>();//最终
		List<Map<String, Object>> jChapterList = baseDao.select(new SelectBean("paper_case_id", paper_case_id),
			"paperCase.selectJChapter").getRows();
		for (int i = 0; i < jChapterList.size(); i++) {
			String chapter_id = (String) jChapterList.get(i).get("id");
			List<Map<String, Object>> jQuestionList = baseDao.select(new SelectBean("paper_case_id", paper_case_id,
				"chapter_id", chapter_id), "paperCase.selectJQuestion").getRows();
			for (int j = 0; j < jQuestionList.size(); j++) {
				String question_id = (String) jQuestionList.get(j).get("id");
				List<Map<String, Object>> jOptionList = baseDao.select(new SelectBean("question_id", question_id),
					"paperCase.selectJOption").getRows();
				jQuestionList.get(j).put("option", jOptionList);
			}
			jChapterList.get(i).put("question", jQuestionList);
		}
		jChapterMap.put("chapter", jChapterList);
		jChapterMap.put("paper_case_name", paper_case_name);
		jChapterMap.put("paper_case_id", paper_case_id);
		
		return JSONObject.toJSONString(jChapterMap);
	}

	/**
	 * 验证信息方法
	 * @param list
	 * @throws BusinessException
	 */
	private Map<String, Object> verificationInformation(Map<String, Object> map) throws BusinessException {
		BusinessException exc = new BusinessException();
		List<ErrorModel> errorsList = exc.getOperateModel().errorsList();
		if(StringUtils.isBlank((String)map.get("name"))){
			errorsList.add(new ErrorModel("304", "试卷名称不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("count"))){
			map.put("count", null);
		}
		//详情表
		@SuppressWarnings("unchecked")
		List<Map<String,Object>> list = (List<Map<String,Object>>)map.get("pp");
		if(list==null || list.size()==0){
			errorsList.add(new ErrorModel("304", "请添加章节和试题！"));
		}
		if(errorsList.size()>0){
			throw exc;
		}
		return map;
	}

	/**
	 * 自动组卷
	 * @param map
	 * @throws BusinessException 
	 */
	private void autoMakePaper(String paper_id) throws BusinessException {
		//试卷实例表
		HashMap<String, Object> map = new HashMap<String, Object>(50);
		String paper_case_id = UUID.randomUUID().toString().replace("-", "");
		map.put("id", paper_case_id);
		map.put("paper_id", paper_id);
		ListModel select = baseDao.select(new SelectBean("id",paper_id), "Paper.getById");
		String paperName = (String)select.getRows().get(0).get("name");
		map.put("name", paperName);//以试卷模版名字作为自动出卷的名字
		map.put("count", null);
		map.put("type", "0");
		//map.put("content", "");
		baseDao.operate(map, "paperCase.post");
		
		//试卷详情表
		ListModel clist = baseDao.select(new SelectBean("paper_id", paper_id), "paperDetail.selectThisChapter");
		if(clist.getRows()!=null && clist.getRows().size()>0){
			List<String> existQuestion_ids = new ArrayList<String>();
			for (int i = 0; i < clist.getRows().size(); i++) {//章节一
				String chapter_id = (String) clist.getRows().get(i).get("id");
				Integer type = (Integer) clist.getRows().get(i).get("type");
				ListModel plist = baseDao.select(new SelectBean("chapter_id", chapter_id),
					"paperDetail.selectThisPolicy");
				if(plist.getRows()!=null && plist.getRows().size()>0){
					for (int j = 0; j < plist.getRows().size(); j++) {//策略一
						String question_bank_ids = (String) plist.getRows().get(j).get("question_bank_ids");
						String knowledge_id = (String) plist.getRows().get(j).get("knowledge_id");
						Integer level = (Integer) plist.getRows().get(j).get("level");
						Integer score = (Integer) plist.getRows().get(j).get("score");
						Integer number = (Integer) plist.getRows().get(j).get("number");
						//根据策略拿到题的集合
						HashSet<String> question_ids = getQuestionByPolicy(question_bank_ids, knowledge_id, type,
							level, number, existQuestion_ids);
						int k = 0;
						for (String question_id : question_ids) {
							HashMap<String, Object> paramMap = new HashMap<String,Object>();
							paramMap.put("id", UUID.randomUUID().toString().replace("-", ""));//补充字段
							paramMap.put("question_id", question_id);//补充字段
							paramMap.put("chapter_id", chapter_id);//补充字段
							paramMap.put("grade", score);//补充字段
							paramMap.put("orders", k+=1);//补充字段
							paramMap.put("paper_case_id", paper_case_id);//补充字段
							paramMap.put("create_user_id", UserCacheUtils.getUserId());//补充字段
							baseDao.operate(paramMap, "paperDetail.post");
							//把题目存入已存在的题目集合里，下次取时不要有重复的
							existQuestion_ids.add(question_id);
						}
					}
				}
			}
		}
		
		//试卷实例表JSON字段
		HashMap<String, Object> jMap = new HashMap<String, Object>();
		jMap.put("id", paper_case_id);
		jMap.put("content", getContent(paper_case_id, paperName));
		baseDao.operate(jMap, "paperCase.putJson");
	}

	/**
	 * 根据策略抽题目ID
	 * @param existQuestion_ids 需要过滤掉的已经存在的题目
	 * @throws BusinessException 
	 */
	private HashSet<String> getQuestionByPolicy(String question_bank_ids, String knowledge_id, Integer type,
		Integer level, Integer number, List<String> existQuestion_ids) throws BusinessException {
		
		//拿到所有可选的题目id
		List<String> question_ids = new ArrayList<String>();
		String[] arr = question_bank_ids.split(",");
		//题库ids
		for (int i = 0; i < arr.length; i++) {
			SelectBean selectBean = new SelectBean();
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("question_bank_id", arr[i]);
			parameters.put("type", type);
			parameters.put("level", level);
			selectBean.setParameters(parameters);
			//根据题库ID、题目类型、题目等级抓题
			ListModel listModel = baseDao.select(selectBean, "Question.getListByQbAmdtpAmdll");
			if(listModel.getRows()!=null && listModel.getRows().size()>0){
				//题目ids
				for (int j = 0; j < listModel.getRows().size(); j++) {
					question_ids.add((String)listModel.getRows().get(j).get("id"));
				}
			}
		}
		
		//去掉已经选用的题目
		for (int i = 0; i < existQuestion_ids.size(); i++) {
			String str = existQuestion_ids.get(i);
			if(question_ids.contains(str)){
				question_ids.remove(str);
			}
		}
		
		//题目数量是否能够满足要求
		if(number >= question_ids.size()){
			throw new BusinessException("符合策略要求的题目数量不足，请补充题库或更改策略！");
		}
		
		//抽题
		HashSet<String> result_ids = new HashSet<String>();
		Random random = new Random();
		while(true){
			int nextInt = random.nextInt(question_ids.size());//包头不包尾，正好
			result_ids.add(question_ids.get(nextInt));
			if(result_ids.size()==number){
				break;
			}
		}
		return result_ids;
	}
	
	/**
	 * 自动出卷并返回JSON（2）
	 * @param code
	 * @param message
	 * @return
	 * @throws BusinessException 
	 */
	public String realTimeMakePaper(String paper_id) throws BusinessException{
		//如果没有章节和相应的策略，不能自动出卷
		ListModel listModel = baseDao.select(new SelectBean("paper_id",paper_id), "paperDetail.selectChapterAndPolicy");
		if (listModel.getRows()==null || listModel.getRows().size()==0){
			throw new BusinessException("没有章节和相应的策略，不能自动出卷！");
		}
		//章节策略信息不全，不能自动出卷
		for (int i = 0; i < listModel.getRows().size(); i++) {
			Object object = listModel.getRows().get(i).get("cpid");
			if(object==null){//有的章节没策略
				throw new BusinessException("章节策略信息不全，不能自动出卷！");
			}
		}
		//自动出卷开始
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		//1.遍历章节
		ListModel clist = baseDao.select(new SelectBean("paper_id", paper_id), "paperCase.selectChapterSomeInfo");
		List<Map<String, Object>> cBody = clist.getRows();
		if(cBody!=null && cBody.size()>0){
			//试卷已经选用的题目id
			List<String> existQuestion_ids = new ArrayList<String>();
			for (int i = 0; i < cBody.size(); i++) {//章节一
				String chapter_id = (String) cBody.get(i).get("id");
				Integer type = (Integer) cBody.get(i).get("type");
				//存储这个章节所有的策略产生的题目及选项信息
				List<Map<String, Object>> qBody = new ArrayList<Map<String, Object>>();
				ListModel plist = baseDao.select(new SelectBean("chapter_id", chapter_id),
					"paperDetail.selectThisPolicy");
				if(plist.getRows()!=null && plist.getRows().size()>0){
					for (int j = 0; j < plist.getRows().size(); j++) {//策略一
						String question_bank_ids = (String) plist.getRows().get(j).get("question_bank_ids");
						String knowledge_id = (String) plist.getRows().get(j).get("knowledge_id");
						Integer level = (Integer) plist.getRows().get(j).get("level");
						Integer score = (Integer) plist.getRows().get(j).get("score");
						Integer number = (Integer) plist.getRows().get(j).get("number");
						//根据单个策略拿到一部分题
						HashSet<String> question_ids = getQuestionByPolicy(question_bank_ids, knowledge_id, type,
							level, number, existQuestion_ids);
						//把题目放入qMap和已选题容器里
						for (String question_id : question_ids) {
							//根据题目id组装信息并放入qMap
							Map<String, Object> qMap = baseDao.select(new SelectBean("question_id", question_id),
									"paperCase.selectQuestionSomeInfo").getRows().get(0);
							List<Map<String, Object>> jOptionList = baseDao.select(new SelectBean("question_id",question_id),
									"paperCase.selectJOption").getRows();
							qMap.put("option", jOptionList);
							qMap.put("grade", score);
							qBody.add(qMap);
							//把题目id放入已选题容器里
							existQuestion_ids.add(question_id);
						}
					}
					
				}
				cBody.get(i).put("question", qBody);
			}
		}
		jsonMap.put("chapter", cBody);
		String paperName = (String) baseDao.select(new SelectBean("id", paper_id), "Paper.getById").getRows().get(0).get("name");
		jsonMap.put("paper_case_id", "");
		jsonMap.put("paper_case_name", paperName);
		String realTimePaperJson = JSONObject.toJSONString(jsonMap);
		return realTimePaperJson;
	}
	
	// 返回1条错误信息
	public OperateModel failOperateModel(String code, String message) {
		OperateModel operateModel = new OperateModel();
		operateModel.setResult("fail");
		ErrorModel[] errorModels = new ErrorModel[1];
		errorModels[0] = new ErrorModel(code, message);
		operateModel.setErrors(errorModels);
		return operateModel;
	}

	// 返回1条成功信息
	public OperateModel successOperateModel(String code, String message) {
		OperateModel operateModel = new OperateModel();
		operateModel.setResult("success");
		ErrorModel[] errorModels = new ErrorModel[1];
		errorModels[0] = new ErrorModel(code, message);
		operateModel.setErrors(errorModels);
		return operateModel;
	}

}
