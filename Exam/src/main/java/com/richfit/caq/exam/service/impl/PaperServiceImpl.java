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
 * 试卷模板管理
 * @author langzigyq
 *
 */
@DOL
@Service("paperDOL")
public class PaperServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 查询单条
	 */
	@Override
	public CrudModel get(String id) throws BusinessException {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "Paper.getById"));
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("未查询到该试卷模板");
		}
		return crudModel;
	}

	/**
	 * 查询多条
	 * query：0查询全部，1根据静态考试id查询，2查询所有未关联到该场考试的试卷模板
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		ListModel listModel = null;
		//获取查询参数
		String query = selectBean.getParameters().get("query").toString();
		
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "Paper.getlist");
		}
		if("1".equals(query)){
			listModel = baseDao.select(selectBean, "Paper.getListByExamId");
		}
		if("2".equals(query)){
			listModel = baseDao.select(selectBean, "Paper.getOtherPaperListByExamId");
		}
		return listModel;
	}

	/**
	 * 新增试卷模板
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		//数据校验
		check(map);
		
		// 增加试卷模板id
		map.put("id", UUID.randomUUID().toString().replaceAll("-", ""));
		// 增加当前登录人id为创建者id
		map.put("createUserId", UserCacheUtils.getUserId());
		OperateModel model = new OperateModel();
		//增加试卷模板
		int rows = baseDao.operate(map, "Paper.post");
		//增加试卷模板与静态考试中间表记录
		int rows2 = baseDao.operate(map, "Paper.associateToExam");
		if (rows > 0 && rows2 > 0) {
			model.setResult("success");
		}else{
			throw new BusinessException("保存试卷模板失败");
		}
		return model;
	}

	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		//数据校验
		check(map);

		// 增加当前登录人id为修改者id
		map.put("update_user_id", UserCacheUtils.getUserId());
		OperateModel model = new OperateModel();
		int rows = baseDao.operate(map, "Paper.put");
		if (rows > 0) {
			model.setResult("success");
		}else{
			throw new BusinessException("修改试卷模板失败");
		}
		return model;
		
	}

	@Override
	public OperateModel remove(String id) throws BusinessException {
		//检查是否已生成试卷
		CrudModel model1 = new CrudModel(baseDao.select(new SelectBean("paper_id",id), "Paper.checkPaperCase"));
		if ((Long)model1.getRow().get("number") > 0) {
			throw new BusinessException("该试卷模板已生成试卷，不能删除");
		}
		//检查是否已被考试策略使用
		CrudModel model2 = new CrudModel(baseDao.select(new SelectBean("paper_id",id), "Paper.checkExamPolicy"));
		if ((Long)model2.getRow().get("number") > 0) {
			throw new BusinessException("该试卷模板已被考试使用，不能删除");
		}
		
		Map<String, Object> map = new HashMap<String, Object>(10);
		map.put("id", id);
		OperateModel model = new OperateModel();
		try {
			int i =1/0;
			baseDao.operate(map, "Paper.delete");//已在数据库进行级联操作，会同时删除下面的章节、章节策略、试卷模板与静态考试的中间表记录
			model.setResult("success");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("删除试卷模板失败");
		}
		
		return model;
	}
	
	/**
	 * 数据校验
	 */
	public void check(Map<String,Object> map) throws BusinessException {
		if (StringUtils.isBlank((String)map.get("name"))) {
			throw new BusinessException("保存失败，试卷模板名称不能为空！");
		}
	}

}
