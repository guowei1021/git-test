package com.richfit.caq.exam.service.impl;

import java.util.Collections;
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
import com.richfit.caq.comm.entity.ListModel;
import com.richfit.caq.comm.entity.OperateModel;
import com.richfit.caq.comm.entity.SelectBean;
import com.richfit.caq.comm.exception.BusinessException;
import com.richfit.caq.comm.service.DataOperater;
import com.richfit.caq.exam.util.UserCacheUtils;
/**
 * 章节管理
 * @author langzigyq
 *
 */
@DOL
@Service("chapterDOL")
public class ChapterServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 查询单条
	 */
	@Override
	public CrudModel get(String id) throws BusinessException {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "Chapter.getById"));
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("未查询到该章节"); 
		}
		return crudModel;
	}

	/**
	 * 查询多条
	 * query：0查询全部，1根据静态试卷id查询
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		ListModel listModel = null;
		//获取查询参数
		String query = selectBean.getParameters().get("query").toString();
		
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "Chapter.getlist");
		}
		if("1".equals(query)){
			listModel = baseDao.select(selectBean, "Chapter.getListByPaperId");
		}
		return listModel;
	}

	/**
	 * 新增章节
	 * 
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		//数据校验
		check(map);
		
		// 增加id
		map.put("id", UUID.randomUUID().toString().replaceAll("-", ""));
		// 增加当前登录人id为创建者id
		map.put("create_user_id", UserCacheUtils.getUserId());
		
		OperateModel model = new OperateModel();
		try {
			//获取最大排序位置
			CrudModel crudModel = new CrudModel(baseDao.select(new SelectBean("id", map.get("paper_id").toString()), "Chapter.getMaxSort"));
			if (crudModel.getRow() != null && StringUtils.isNotBlank(crudModel.getRow().get("maxSort").toString())) {
				map.put("sort", crudModel.getRow().get("maxSort"));
			}else{
				map.put("sort", 1);
			}
			
			baseDao.operate(map, "Chapter.post");
			model.setResult("success");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("新增章节失败");
		}
		
		return model;
	}

	/**
	 * 修改章节
	 * update:0修改章节内容，1修改章节排序
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		OperateModel model = new OperateModel();
		//获取查询参数
		String update = map.get("update").toString();
		
		if ("0".equals(update)) {
			//数据校验
			check(map);
			
			// 增加当前登录人id为修改者id
			map.put("update_user_id", UserCacheUtils.getUserId());
			
			try {
				baseDao.operate(map, "Chapter.put");
				model.setResult("success");
			} catch (Exception e) {
				throw new BusinessException("新增章节失败");
			}
		}
		
		if("1".equals(update)){
			
			try {
				//获取排序集合
				List sortList = (List)map.get("sortList");
				if (sortList == null) {
					throw new BusinessException("修改排序失败,未获取到排序集合");
				}
				map.put("min", Integer.parseInt(Collections.min(sortList).toString())-1);
				map.put("newSort", StringUtils.strip(sortList.toString(),"[]"));
				baseDao.operate(map, "Chapter.sort");
				model.setResult("success");
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException("修改排序失败");
			}
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
			//单条查询章节
			CrudModel crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "Chapter.getById"));
			if (crudModel.getRow() != null && StringUtils.isNotBlank(crudModel.getRow().get("sort").toString())) {
				map.put("sort", crudModel.getRow().get("sort"));
				map.put("paper_id", crudModel.getRow().get("paper_id"));
			}else{
				throw new BusinessException("未查询到该章节，无法删除");
			}
			//先删除章节策略
			baseDao.operate(map, "Chapter.deletePolicy");
			//再删除章节
			baseDao.operate(map, "Chapter.delete");
			//重新排序
			baseDao.operate(map, "Chapter.changeSort");
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
		if (StringUtils.isBlank((String)map.get("chapter_name"))) {
			throw new BusinessException("保存失败，章节名称不能为空！");
		}
		if (StringUtils.isBlank((String)map.get("type"))) {
			throw new BusinessException("保存失败，章节题型不能为空！");
		}
		if (StringUtils.isBlank((String)map.get("chapter_grade"))) {
			throw new BusinessException("保存失败，章节分数不能为空！");
		}
		if (Integer.parseInt((String)map.get("chapter_grade"))<0) {
			throw new BusinessException("保存失败，章节分数不能为负数！");
		}
	}

}
