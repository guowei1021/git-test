package com.richfit.caq.exam.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
 * 考试实例模块
 * @author XueMancang (If you want to change this class, please contact me first!)
 */
@DOL
@Service("examCaseDOL")
public class ExamCaseServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 单条查询
	 */
	@Override
	public CrudModel get(String id) {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "examCase.select"));
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

		//query:0查所有
		String query = selectBean.getParameters().get("query").toString();
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "examCase.selectAll");
		}
		return listModel;
	}

	/**
	 * 新增考试实例
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		map = verificationInformation(map);
		//考试实例表
		String exam_case_id = UUID.randomUUID().toString().replace("-", "");
		map.put("id", exam_case_id);//ID
		map.put("create_user_id", UserCacheUtils.getUserId());
		baseDao.operate(map, "examCase.post");
		//试卷策略表（不管是任何试卷策略，都在策略表加一条记录）
		map.put("id", UUID.randomUUID().toString().replace("-", ""));
		map.put("exam_case_id", exam_case_id);
		baseDao.operate(map, "examPolicy.post");
		//如果是预生成
		String isBeforehand = (String)map.get("is_beforehand");
		if("1".equals(isBeforehand)){
			batchMakePapers(exam_case_id);
		}
		return successOperateModel("200", "新增考试实例成功！");
	}
	
	/**
	 * 修改、删除考试实例
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		//operate:0修改1删除
		String operate = map.get("operate").toString();
		if("0".equals(operate)){//修改
			map = verificationInformation(map);
			//考试实例表
			map.put("create_user_id", UserCacheUtils.getUserId());
			baseDao.operate(map, "examCase.put");
			
			//试卷策略表--验证试卷策略是否已存在
			ListModel listModel = baseDao.select(new SelectBean("exam_case_id", (String)map.get("id")), "examPolicy.selectExamPolicy");
			map.put("exam_case_id", (String)map.get("id"));
			map.put("create_user_id", UserCacheUtils.getUserId());
			if(listModel.getRows()!=null && listModel.getRows().size()>0){////--存在就是修改操作
				baseDao.operate(map, "examPolicy.put");
			}else{//--不存在就是新增操作
				map.put("id", UUID.randomUUID().toString().replace("-", ""));
				baseDao.operate(map, "examPolicy.post");
			}
			//如果是预生成、现生成
			String isBeforehand = (String)map.get("is_beforehand");
			if("1".equals(isBeforehand)){//预生成
				checkPaperModel(map);//检查模版
				batchMakePapers((String)map.get("id"));//批量组卷去啦！
			}else if("2".equals(isBeforehand)){//实时生成
				checkPaperModel(map);//检查模版
			}
			return successOperateModel("200", "修改考试实例成功！");
		}
		if("1".equals(operate)){//删除
			//试卷策略表
			map.put("exam_case_id", (String)map.get("id"));
			baseDao.operate(map, "examPolicy.delete");
			
			//考试实例表
			baseDao.operate(map, "examCase.delete");
			return successOperateModel("200", "删除考试实例成功！");
		}
		return successOperateModel("200", "操作成功！");
	}

	/**
	 * 检查试卷模版
	 * @param map
	 * @throws BusinessException
	 */
	private void checkPaperModel(Map<String, Object> map) throws BusinessException {
		//如果没有章节和相应的策略，不能自动出卷
		ListModel listModel = baseDao.select(new SelectBean("paper_id",(String)map.get("paper_id")), "paperDetail.selectChapterAndPolicy");
		if(listModel.getRows()!=null && listModel.getRows().size()>0){//有章节
			for (int i = 0; i < listModel.getRows().size(); i++) {
				Object object = listModel.getRows().get(i).get("cpid");
				if(object==null){//有的章节没策略
					throw new BusinessException("章节策略信息不全，不能自动出卷！");
				}
			}
		}else{
			throw new BusinessException("没有章节和相应的策略，不能自动出卷！");
		}
	}
	
	/**
	 * 批量组卷
	 * @param map
	 * @throws BusinessException 
	 */
	private void batchMakePapers(String exam_case_id) throws BusinessException {
		//获取考试实例全部信息包含策略，模板
		CrudModel crudModel = new CrudModel(baseDao.select(new SelectBean("id", exam_case_id), "examCase.get"));;
		if(crudModel.getRow() != null){
			for (int i = 1; i < Integer.parseInt((String)crudModel.getRow().get("number"))+1; i++) {
				//出卷
				HashMap<String, Object> map = new HashMap<String, Object>();
				String paper_case_id = UUID.randomUUID().toString().replace("-", "");
				map.put("id", paper_case_id);
				map.put("name", (String)(crudModel.getRow().get("exam_case_name"))+"X" + i);
				map.put("paper_id", (String)(crudModel.getRow().get("paper_id")));
				map.put("count", "1");
				map.put("type", "0");//自动卷
				baseDao.operate(map, "paperCase.post");
				//并建立与考试实例的关系
				map.put("exam_case_id", exam_case_id);
				map.put("paper_case_id", paper_case_id);
				
				baseDao.operate(map, "paperCase.postTo");
			}
		}else{
			throw new BusinessException("组卷失败，请重试！");
		}
	}

	@Override
	public OperateModel remove(String id) throws BusinessException {
		return null;
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
			errorsList.add(new ErrorModel("304", "考试名称不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("exam_type"))){
			errorsList.add(new ErrorModel("304", "考试类型不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("is_connect"))){
			errorsList.add(new ErrorModel("304", "是否支持续考不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("topic_is_disorder"))){
		errorsList.add(new ErrorModel("304", "题目是否乱序不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("option_is_disorder"))){
			errorsList.add(new ErrorModel("304", "选项是否乱序不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("sorce_line"))){
			errorsList.add(new ErrorModel("304", "分数线不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("locked_times"))){
			errorsList.add(new ErrorModel("304", "锁定次数不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("is_charge"))){
			errorsList.add(new ErrorModel("304", "是否有费用不能为空"));
		}else{
			String isCharge = (String)map.get("is_charge");
			if("1".equals(isCharge)){
				if(StringUtils.isBlank((String)map.get("fee"))){
					errorsList.add(new ErrorModel("304", "费用不能为空"));
				}
				if(StringUtils.isBlank((String)map.get("account"))){
					errorsList.add(new ErrorModel("304", "缴费账号不能为空"));
				}
			}
		}
		if(StringUtils.isBlank((String)map.get("starttime"))){
			errorsList.add(new ErrorModel("304", "开始时间不能为空"));
		}else if(map.get("starttime").toString().length()!=16){
			errorsList.add(new ErrorModel("304", "开始时间格式不正确"));
		}else{
			map.put("starttime", map.get("starttime")+":00");
		}
		if(StringUtils.isBlank((String)map.get("endtime"))){
			errorsList.add(new ErrorModel("304", "结束时间不能为空"));
		}else if(map.get("endtime").toString().length()!=16){
			errorsList.add(new ErrorModel("304", "结束时间格式不正确"));
		}else{
			map.put("endtime", map.get("endtime")+":00");
		}
		if(StringUtils.isBlank((String)map.get("duration"))){
			errorsList.add(new ErrorModel("304", "时长不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("examiner_id"))){
			errorsList.add(new ErrorModel("304", "考试负责人不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("is_beforehand"))){
			errorsList.add(new ErrorModel("304", "试卷策略不能为空"));
		}else{
			String isBeforehand = (String)map.get("is_beforehand");
			if("0".equals(isBeforehand)){
				map.put("beforehand_number", null);
				map.put("warn_num", null);
				map.put("warn_supply_num", null);
				map.put("check_time", null);
				map.put("trigger_num", null);
			}else if("2".equals(isBeforehand)){
				if(StringUtils.isBlank((String)map.get("paper_id"))){
					errorsList.add(new ErrorModel("304", "试卷模版不能为空"));
				}
				map.put("beforehand_number", null);
				map.put("warn_num", null);
				map.put("warn_supply_num", null);
				map.put("check_time", null);
				map.put("trigger_num", null);
			}else if("1".equals(isBeforehand)){
				if(StringUtils.isBlank((String)map.get("paper_id"))){
					errorsList.add(new ErrorModel("304", "试卷模版不能为空"));
				}
				if(StringUtils.isBlank((String)map.get("beforehand_number"))){
					errorsList.add(new ErrorModel("304", "预先生成数量不能为空"));
				}
				if(StringUtils.isBlank((String)map.get("warn_num"))){
					errorsList.add(new ErrorModel("304", "预警数量不能为空"));
				}
				if(StringUtils.isBlank((String)map.get("warn_supply_num"))){
					errorsList.add(new ErrorModel("304", "预警补充数量不能为空"));
				}
				if(StringUtils.isBlank((String)map.get("check_time"))){
					errorsList.add(new ErrorModel("304", "检查时间不能为空"));
				}
				if(StringUtils.isBlank((String)map.get("trigger_num"))){
					errorsList.add(new ErrorModel("304", "触发数量不能为空"));
				}
			}
		}
		if(errorsList.size()>0){
			throw exc;
		}
		return map;
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
