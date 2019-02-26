package com.richfit.caq.exam.service.impl;

import java.util.ArrayList;
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
 * 试题选项管理
 * 
 * @author langzigyq
 *
 */
@DOL
@Service("optionDOL")
public class OptionServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;

	/**
	 * 查询单条
	 */
	@Override
	public CrudModel get(String id) throws BusinessException {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "Option.getById"));
			if (crudModel.getRow() == null) {
				throw new BusinessException("未查询到该选项");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("未查询到该选项");
		}
		
		return crudModel;
	}

	/**
	 * 查询多条 query：0查询全部，1根据试题id查询,2查询正确选项的数量
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		ListModel listModel = null;
		// 获取查询参数
		String query = selectBean.getParameters().get("query").toString();

		if ("0".equals(query)) {
			listModel = baseDao.select(selectBean, "Option.getlist");
			listModel = changeNumToChar(listModel);
		}
		if ("1".equals(query)) {
			listModel = baseDao.select(selectBean, "Option.getListByQuestionId");
			listModel = changeNumToChar(listModel);
		}
		if ("2".equals(query)) {
			listModel = baseDao.select(selectBean, "Option.getTrueNumberByQuestionId");
		}

		return listModel;
	}

	/**
	 * 新增选项
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		// 数据校验
		check(map);

		// 增加id
		map.put("id", UUID.randomUUID().toString().replaceAll("-", ""));
		// 增加当前登录人id为创建者id
		map.put("create_user_id", UserCacheUtils.getUserId());

		OperateModel model = new OperateModel();
		try {
			// 获取最大排序位置
			CrudModel crudModel = new CrudModel(
					baseDao.select(new SelectBean("id", map.get("question_id").toString()), "Option.getMaxSort"));
			if (crudModel.getRow() != null && StringUtils.isNotBlank(crudModel.getRow().get("maxSort").toString())) {
				map.put("sort", crudModel.getRow().get("maxSort"));
			} else {
				map.put("sort", 1);
			}

			baseDao.operate(map, "Option.post");
			model.setResult("success");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("新增选项失败");
		}
		// 修改试题状态
		changeQuestionStatus((String) map.get("question_id"));
		return model;
	}

	/**
	 * 修改选项 update:0修改选项内容，1修改选项排序
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		OperateModel model = new OperateModel();
		// 获取查询参数
		String update = map.get("update").toString();

		// 修改
		if ("0".equals(update)) {
			// 数据校验
			check(map);

			// 增加当前登录人id为修改者id
			map.put("update_user_id", UserCacheUtils.getUserId());

			try {
				baseDao.operate(map, "Option.put");
				model.setResult("success");
			} catch (Exception e) {
				throw new BusinessException("新增选项失败");
			}
			// 修改试题状态
			changeQuestionStatus((String) map.get("question_id"));
		}

		// 排序
		if ("1".equals(update)) {

			try {
				// 获取排序集合
				List sortList = (List) map.get("sortList");
				if (sortList == null) {
					throw new BusinessException("修改排序失败,未获取到排序集合");
				}
				sortList = changeCharToNum(sortList);

				map.put("min", Integer.parseInt(Collections.min(sortList).toString()) - 1);
				map.put("newSort", StringUtils.strip(sortList.toString(), "[]"));
				
				baseDao.operate(map, "Option.sort");
				model.setResult("success");
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException("修改排序失败");
			}
		}

		return model;
	}

	/**
	 * 删除选项
	 */
	@Override
	public OperateModel remove(String id) throws BusinessException {
		Map<String, Object> map = new HashMap<String, Object>(10);
		map.put("id", id);
		OperateModel model = new OperateModel();
		try {
			// 单条查询选项
			CrudModel crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "Option.getById"));

			if (crudModel.getRow() != null && StringUtils.isNotBlank(crudModel.getRow().get("sort").toString())) {
				map.put("sort", crudModel.getRow().get("sort"));
				map.put("question_id", crudModel.getRow().get("question_id"));
			} else {
				throw new BusinessException("未查询到该选项，无法删除");
			}

			// 删除选项
			baseDao.operate(map, "Option.delete");
			// 重新排序
			baseDao.operate(map, "Option.changeSort");
			// 设置试题状态
			changeQuestionStatus((String) crudModel.getRow().get("question_id"));
			model.setResult("success");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("删除选项失败");
		}

		return model;
	}

	/**
	 * 数据校验
	 */
	public void check(Map<String, Object> map) throws BusinessException {
		if (StringUtils.isBlank((String) map.get("option_content"))) {
			throw new BusinessException("保存失败，选项内容不能为空！");
		}
		if (StringUtils.isBlank((String) map.get("is_true"))) {
			throw new BusinessException("保存失败，请选择选项是否正确！");
		}
	}

	/**
	 * 设置题目启用状态 1可用、2不可用，该试题无选项、3不可用，该试题无正确选项、4不可用，单选题正确选项过多
	 * 
	 * @throws BusinessException
	 */
	public void changeQuestionStatus(String question_id) throws BusinessException {
		int status;
		CrudModel crudModel;
		try {
			crudModel = new CrudModel(
					baseDao.select(new SelectBean("question_id", question_id), "Option.getTrueNumberByQuestionId"));

		} catch (Exception e) {
			throw new BusinessException("查询正确选项数量失败失败");
		}

		Integer type = (Integer) crudModel.getRow().get("type");
		Long number = (Long) crudModel.getRow().get("number");
		Long trueNumber = (Long) crudModel.getRow().get("trueNumber");
		if (number < 1) {
			status = 2;
		} else if (trueNumber < 1) {
			status = 3;
		} else if (type == 0 && trueNumber > 1) {
			status = 4;
		} else {
			status = 1;
		}

		// 修改题目状态
		Map<String, Object> map = new HashMap<String, Object>(10);
		map.put("id", question_id);
		map.put("status", status);
		try {
			baseDao.operate(map, "Option.changeQuestionStatus");
		} catch (Exception e) {
			throw new BusinessException("修改题目状态失败");
		}
	}

	/**
	 * 数字转字母，将1234转换为ABCD
	 * 
	 * @throws BusinessException
	 */
	public ListModel changeNumToChar(ListModel listModel) throws BusinessException {
		List<Map<String, Object>> list = listModel.getRows();
		try {
			if (list != null) {
				for (Map<String, Object> map : list) {
					if ((int) map.get("sort") > 0) {
						map.put("sort", (char) ((int) map.get("sort") + '@'));
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("选项编号转换异常");
		}
		return listModel;
	}

	/**
	 * 字母转数字，将ABCD转换为1234
	 */
	public List changeCharToNum(List<String> list) {
		List newList = new ArrayList();
		if (list != null) {
			for (String s : list) {
				newList.add(s.charAt(0) - 64);
			}
		}
		return newList;
	}
}
