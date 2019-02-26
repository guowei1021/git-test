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
 * 知识点模块
 * @author XueMancang (If you want to change this class, please contact me first!)
 */
@DOL
@Service("knowledgeDOL")
public class KnowledgeServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 单条查询
	 */
	@Override
	public CrudModel get(String id) {
		CrudModel crudModel = null;
		try {
			crudModel = new CrudModel(baseDao.select(new SelectBean("id", id), "knowledge.select"));
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

		//query:0查某科目相关知识点1根据知识点名称模糊查询某科目下的知识点列表2查询某知识点父级3查所有知识点和相互关系Tree
		String query = selectBean.getParameters().get("query").toString();
		if("0".equals(query)){
				listModel = baseDao.select(selectBean, "knowledge.selectAll");
		}
		if("1".equals(query)){
			listModel = baseDao.select(selectBean, "knowledge.selectByNameVague");
		}
		if("2".equals(query)){
			listModel = baseDao.select(selectBean, "knowledge.selectKParent");
		}
		if("3".equals(query)){
			listModel = baseDao.select(selectBean, "knowledge.selectAllForTree");
/*			HashMap<String, Object> rootK = new HashMap<String, Object>();
			rootK.put("k_name", "知识点结构图：");
			rootK.put("id", "K");
			rootK.put("k_parent_id", "1");
			listModel.getRows().add(rootK);*/
		}
		return listModel;
	}

	/**
	 * 新增知识点
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		verificationInformation(map);
		map.put("id", UUID.randomUUID().toString().replace("-", ""));//ID
		map.put("create_user_id", UserCacheUtils.getUserId());
		baseDao.operate(map, "knowledge.post");
		
		//在知识点自关联表保存父级关系
		@SuppressWarnings("unchecked")
		List<Object> list = (List<Object>)map.get("k_parent_ids");
		if(list!=null && list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				@SuppressWarnings("unchecked")
				HashMap<String, Object> idMap = (HashMap<String, Object>)list.get(i);
				idMap.put("id", UUID.randomUUID().toString().replace("-", ""));
				idMap.put("k_kid_id", map.get("id"));
				baseDao.operate(idMap, "knowledge.Zpost");
			}
		}
		
		return successOperateModel("200", "新增知识点成功！");
	}
	
	/**
	 * 修改、删除知识点
	 */
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		//operate:0修改1逻辑删除
		String operate = map.get("operate").toString();
		if("0".equals(operate)){//修改
			verificationInformation(map);
			map.put("update_user_id", UserCacheUtils.getUserId());
			baseDao.operate(map, "knowledge.put");
			
			//在知识点自关联表保存父级关系（先删再改）
			baseDao.operate(map, "knowledge.ZdeleteByKidId");
			@SuppressWarnings("unchecked")
			List<Object> list = (List<Object>)map.get("k_parent_ids");
			if(list!=null && list.size()>0){
				for (int i = 0; i < list.size(); i++) {
					@SuppressWarnings("unchecked")
					HashMap<String, Object> idMap = (HashMap<String, Object>)list.get(i);
					idMap.put("id", UUID.randomUUID().toString().replace("-", ""));
					idMap.put("k_kid_id", map.get("id"));
					baseDao.operate(idMap, "knowledge.Zpost");
				}
			}
			return successOperateModel("200", "修改知识点成功！");
		}
		if("1".equals(operate)){//删除
			//如果该知识点被策略引用，则不能直接删除
			baseDao.operate(map, "knowledge.selectByUserd");
			ListModel listModel = baseDao.select(new SelectBean("id", (String)map.get("id")), "knowledge.selectByUserd");
			if(listModel.getRows()!=null && listModel.getRows().size()>0){
				throw new BusinessException("该知识点已被试卷策略引用，不能直接删除！");
			}
			
			//先删除掉与此知识点所有的关联关系
			baseDao.operate(map, "knowledge.ZdeleteByKidId");
			baseDao.operate(map, "knowledge.ZdeleteByParentId");
			
			baseDao.operate(map, "knowledge.delete");
			return successOperateModel("200", "删除知识点成功！");
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
		if(StringUtils.isBlank((String)map.get("k_name"))){
			errorsList.add(new ErrorModel("304", "知识点名称不能为空"));
		}
		if(StringUtils.isBlank((String)map.get("k_desc"))){
			errorsList.add(new ErrorModel("304", "知识点描述不能为空"));
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
