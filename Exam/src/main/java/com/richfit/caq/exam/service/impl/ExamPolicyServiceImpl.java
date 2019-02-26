package com.richfit.caq.exam.service.impl;
import java.util.Map;

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

/**
 * 考试策略（试卷策略）模块
 * @author XueMancang (If you want to change this class, please contact me first!)
 */
@DOL
@Service("examPolicyDOL")
public class ExamPolicyServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 单条查询
	 */
	@Override
	public CrudModel get(String id) {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("exam_case_id", id), "examPolicy.selectExamPolicy"));
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
		return null;
	}

	/**
	 * 新增试卷策略
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		return null;
	}
	
	/**
	 * 修改、删除试卷策略
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		return null;
	}

	@Override
	public OperateModel remove(String id) throws BusinessException {
		return null;
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
