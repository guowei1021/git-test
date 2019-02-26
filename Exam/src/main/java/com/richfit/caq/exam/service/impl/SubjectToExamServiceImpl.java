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
import com.richfit.caq.comm.service.DataOperater2;

/**
 * 科目与考试关系维护
 * @author XueMancang (If you want to change this class, please contact me first!)
 */
@DOL
@Service("subject_examDOL")
public class SubjectToExamServiceImpl implements DataOperater2 {

	@Autowired
	private BaseDao baseDao;


	/**
	 * 新增
	 */
	@Override
	public OperateModel add(String id1, Map<String, Object> map) throws BusinessException {
		ListModel select = baseDao.select(new SelectBean("subject_id", id1,"exam_id",(String)map.get("exam_id")), "exam_subject.selectHasThisExam");
		if(select.getRows()!=null && select.getRows().size()>0){
			throw new BusinessException("已经存在该考试，无需重复添加！");
		}
		map.put("subject_id", id1);
		map.put("id", UUID.randomUUID().toString().replace("-", ""));//ID
		baseDao.operate(map, "exam_subject.post");
		return successOperateModel("200", "新增成功！");
	}


	/**
	 * 删除
	 */
	@Override
	public OperateModel remove(String id1, String id2) throws BusinessException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("subject_id", id1);
		map.put("exam_id", id2);
		baseDao.operate(map, "exam_subject.delete");
		return successOperateModel("200", "删除成功！");
	}

	
	@Override
	public CrudModel get(String id1, String id2) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public ListModel getList(String id1, SelectBean selectBean) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public OperateModel edit(String id1, Map<String, Object> map) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 验证信息方法
	 * 
	 * 已经关联的考试不能再添加
	 * @param list
	 * @throws BusinessException
	 */
	private void verificationInformation(Map<String, Object> map) throws BusinessException {
		BusinessException exc = new BusinessException();
		List<ErrorModel> errorsList = exc.getOperateModel().errorsList();
		if(StringUtils.isBlank((String)map.get("name"))){
			errorsList.add(new ErrorModel("304", "考试名称不能为空"));
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
