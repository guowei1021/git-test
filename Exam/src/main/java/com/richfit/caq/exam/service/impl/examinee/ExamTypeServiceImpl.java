package com.richfit.caq.exam.service.impl.examinee;

import java.util.Map;

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

/**
 * 考试类型
 * @author sunguowei
 *
 */
@DOL
@Service("examTypeDOL")
public class ExamTypeServiceImpl implements DataOperater {
	Logger logger = LoggerFactory.getLogger(ExamTypeServiceImpl.class);
	
	@Autowired
	private BaseDao baseDao;
	
	private String namespace = "com.richfit.caq.exam.service.impl.examinee.examType";
	
	@Override
	public CrudModel get(String id) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 考试类型列表
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		
		return baseDao.select(selectBean, namespace+".getList");
	}

	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
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
