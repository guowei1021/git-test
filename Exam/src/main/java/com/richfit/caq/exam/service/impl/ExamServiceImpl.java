package com.richfit.caq.exam.service.impl;
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
 * 考试模块
 * @author XueMancang (If you want to change this class, please contact me first!)
 */
@DOL
@Service("examDOL")
public class ExamServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 单条查询
	 */
	@Override
	public CrudModel get(String id) {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "exam.select"));
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

		//query:0查所有考试 1查某科目相关考试2查某考试对应的静态模版
		String query = selectBean.getParameters().get("query").toString();
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "exam.selectAll");
		}
		if("1".equals(query)){
			listModel = baseDao.select(selectBean, "exam.selectBySub");
		}
		if("2".equals(query)){
			listModel = baseDao.select(selectBean, "exam.selectPapers");
		}
		return listModel;
	}

	/**
	 * 新增考试
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		verificationInformation(map);
		map.put("id", UUID.randomUUID().toString().replace("-", ""));//ID
		map.put("create_user_id", UserCacheUtils.getUserId());
		baseDao.operate(map, "exam.post");
		return successOperateModel("200", "新增考试成功！");
	}
	
	/**
	 * 修改、删除考试
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		//operate:0修改1删除
		String operate = map.get("operate").toString();
		if("0".equals(operate)){//修改
			verificationInformation(map);
			map.put("update_user_id", UserCacheUtils.getUserId());
			baseDao.operate(map, "exam.put");
			return successOperateModel("200", "修改考试成功！");
		}
		if("1".equals(operate)){//删除
			//如果有考试实例，不能删除考试类目
			ListModel listModel = baseDao.select(new SelectBean("id",(String)map.get("id")), "exam.selectHasExamCase");
			if(listModel.getRows()!=null && listModel.getRows().size()>0){
				throw new BusinessException("该考试类目下存在考试，无法直接删除！");
			}
			//如果有试卷模版，不能删除考试类目
			ListModel listModel2 = baseDao.select(new SelectBean("id",(String)map.get("id")), "exam.selectPapers");
			if(listModel2.getRows()!=null && listModel2.getRows().size()>0){
				throw new BusinessException("该考试类目下存在试卷模版，无法直接删除！");
			}
			
			//先删除该考试所有的科目关系
			baseDao.operate(map, "exam_subject.deleteAllExam");
			
			baseDao.operate(map, "exam.delete");
			return successOperateModel("200", "删除考试成功！");
		}
		return successOperateModel("200", "操作成功！");
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
	private void verificationInformation(Map<String, Object> map) throws BusinessException {
		BusinessException exc = new BusinessException();
		List<ErrorModel> errorsList = exc.getOperateModel().errorsList();
		if(StringUtils.isBlank((String)map.get("name"))){
			errorsList.add(new ErrorModel("304", "考试类目名称不能为空"));
		}
		if(errorsList.size()>0){
			throw exc;
		}
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
