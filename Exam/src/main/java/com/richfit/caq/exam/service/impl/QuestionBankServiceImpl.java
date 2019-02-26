package com.richfit.caq.exam.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
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
import com.richfit.caq.exam.util.UserCacheUtils;

/**
 * 题库管理
 * 
 * @author langzigyq
 *
 */
@DOL
@Service("questionBankDOL")
public class QuestionBankServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;

	/**
	 * 查询单条
	 */
	@Override
	public CrudModel get(String id) throws BusinessException {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "QuestionBank.getById"));
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("未查询到该题库"); 
		}
		return crudModel;
	}

	/**
	 * 分页查询
	 * query:0查询全部题库，1（预留，根据不同权限查看题库）
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		ListModel listModel = null;
		//获取查询参数
		String query = selectBean.getParameters().get("query").toString();
		
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "QuestionBank.getList");
		}
		return listModel;
	}

	/**
	 * 新增或修改题库
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		//数据校验
		check(map);
		
		// 获取题库id
		String id = (String) map.get("id");

		if (StringUtils.isNotBlank(id)) {
			// 增加当前登录人id为修改者id
			map.put("updateUserId", UserCacheUtils.getUserId());
		} else {
			// 增加id
			map.put("id", UUID.randomUUID().toString().replaceAll("-", ""));
			// 增加当前登录人id为创建者id
			map.put("createUserId", UserCacheUtils.getUserId());
		}

		OperateModel model = new OperateModel();
		int rows = baseDao.operate(map, "QuestionBank.post");
		if (rows > 0) {
			model.setResult("success");
		}
		return model;
	}

	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {

		return null;
	}

	@Override
	public OperateModel remove(String id) throws BusinessException {
		Map<String, Object> map = new HashMap<String, Object>(10);
		map.put("id", id);
		OperateModel model = new OperateModel();
		try {
			baseDao.operate(map, "QuestionBank.delete");
			model.setResult("success");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("该题库中已录入试题，不能删除");
		}
		
		return model;
	}
	
	/**
	 * 数据校验
	 */
	public void check(Map<String,Object> map) throws BusinessException {
		if (StringUtils.isBlank((String)map.get("name"))) {
			throw new BusinessException("保存失败，题库名称不能为空！");
		}
	}

}
