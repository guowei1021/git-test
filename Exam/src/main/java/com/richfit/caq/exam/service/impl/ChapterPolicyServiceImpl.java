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
 * 章节策略管理
 * @author langzigyq
 *
 */
@DOL
@Service("chapterPolicyDOL")
public class ChapterPolicyServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 查询单条
	 */
	@Override
	public CrudModel get(String id) throws BusinessException {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "ChapterPolicy.getById"));
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("未查询到该章节"); 
		}
		return crudModel;
	}

	/**
	 * 查询多条
	 * query：0查询全部，1根据章节id查询，2查询所有题库，3查询所有可关联知识点
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		ListModel listModel = null;
		//获取查询参数
		String query = selectBean.getParameters().get("query").toString();
		
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "ChapterPolicy.getList");
		}
		if("1".equals(query)){
			listModel = baseDao.select(selectBean, "ChapterPolicy.getListByChapterId");
		}
		if("2".equals(query)){
			listModel = baseDao.select(selectBean, "ChapterPolicy.getQuestionBankList");
		}
		if("3".equals(query)){
			listModel = baseDao.select(selectBean, "ChapterPolicy.getKnowledgeList");
		}
		return listModel;
	}

	/**
	 * 新增章节策略
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		//数据校验
		check(map);
		
		// 增加章节策略id
		map.put("id", UUID.randomUUID().toString().replaceAll("-", ""));
		// 增加当前登录人id为创建者id
		map.put("create_user_id", UserCacheUtils.getUserId());
		
		OperateModel model = new OperateModel();
		try {
			baseDao.operate(map, "ChapterPolicy.post");
			changeChapterGrade((String)map.get("chapter_id"));
			model.setResult("success");
		} catch (Exception e) {
			throw new BusinessException("新增章节策略失败");
		}
		
		return model;
	}

	/**
	 * 修改章节
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		//数据校验
		check(map);
		
		// 增加当前登录人id为修改者id
		map.put("update_user_id", UserCacheUtils.getUserId());
		
		OperateModel model = new OperateModel();
		try {
			baseDao.operate(map, "ChapterPolicy.put");
			changeChapterGrade((String)map.get("chapter_id"));
			model.setResult("success");
		} catch (Exception e) {
			throw new BusinessException("修改章节策略失败");
		}
		return model;
	}

	/**
	 * 删除章节
	 */
	@Override
	public OperateModel remove(String id) throws BusinessException {
		Map<String, Object> map = new HashMap<String, Object>(10);
		map.put("id", id);
		OperateModel model = new OperateModel();
		try {
			CrudModel crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "ChapterPolicy.getById"));
			baseDao.operate(map, "ChapterPolicy.delete");
			changeChapterGrade((String)crudModel.getRow().get("chapter_id"));
			model.setResult("success");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("删除章节失败");
		}
		
		return model;
	}
	
	/**
	 * 数据校验
	 */
	public void check(Map<String,Object> map) throws BusinessException {
		if (StringUtils.isBlank((String)map.get("question_bank_ids"))) {
			throw new BusinessException("保存失败，请选择题库！");
		}
		if (StringUtils.isBlank((String)map.get("knowledge_id"))) {
			throw new BusinessException("保存失败，请选择知识点！");
		}
		if (StringUtils.isBlank((String)map.get("level"))) {
			throw new BusinessException("保存失败，请选择难易程度！");
		}
		if (StringUtils.isBlank((String)map.get("number"))) {
			throw new BusinessException("保存失败，试题数量不能为空！");
		}
		if (StringUtils.isBlank((String)map.get("score"))) {
			throw new BusinessException("保存失败，每题分值不能为空！");
		}
		if (Integer.parseInt((String)map.get("number"))<0) {
			throw new BusinessException("保存失败，章节分数不能为负数！");
		}
		if (Integer.parseInt((String)map.get("score"))<0) {
			throw new BusinessException("保存失败，章节分数不能为负数！");
		}
	}
	
	/**
	 * 修改章节表分数
	 * @param chapter_id,baseDao  ,BaseDao baseDao
	 * @throws BusinessException 
	 */
	public void changeChapterGrade(String chapter_id) throws BusinessException{
		Map<String, Object> map = new HashMap<String, Object>(10);
		map.put("id", chapter_id);
		try {
			baseDao.operate(map, "ChapterPolicy.sum");
		} catch (Exception e) {
			throw new BusinessException("汇总章节总分失败");
		}
	}

}
