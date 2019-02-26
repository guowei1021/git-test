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
import com.richfit.caq.comm.entity.ListModel;
import com.richfit.caq.comm.entity.OperateModel;
import com.richfit.caq.comm.entity.SelectBean;
import com.richfit.caq.comm.exception.BusinessException;
import com.richfit.caq.comm.service.DataOperater;
import com.richfit.caq.exam.util.UserCacheUtils;


/**
 * 试题管理
 * @author langzigyq
 *
 */
@DOL
@Service("questionDOL")
public class QuestionServiceImpl implements DataOperater {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 根据id查询试题，包括选项
	 */
	@Override
	public CrudModel get(String id) throws BusinessException {
		CrudModel model = null;
		ListModel optionsModel = null;
		CrudModel knowledgeNameModel = null;
		//查询试题
		try {
			model = new CrudModel(baseDao.select(new SelectBean("id", id), "Question.getById"));
			//markdown渲染为html
			//String m = MDTool.markdown2Html((String)(model.getRow().get("topic")));
			//model.getRow().put("topic", m);
		} catch (Exception e) {
			throw new BusinessException("查询该试题失败"); 
		}
		//查询选项
		try {
			optionsModel = baseDao.select(new SelectBean("id", id), "Question.getOptionByQuestionId");
			optionsModel = changeNumToChar(optionsModel);
		} catch (Exception e) {
			throw new BusinessException("查询到试题的选项失败"); 
		}
		//转换知识点id为name
		try {
			knowledgeNameModel =  new CrudModel(baseDao.select(new SelectBean("knowledges", (String)model.getRow().get("knowledges")), "Question.convertKnowledge"));
		} catch (Exception e) {
			throw new BusinessException("查询该试题关联的知识点名称失败"); 
		}
		
		//将选项数据放入试题model中
		model.getRow().put("options", optionsModel.getRows());
		//将知识点name数据放入试题model中
		model.getRow().put("knowledge_names", knowledgeNameModel.getRow().get("knowledge_names"));
		
		/*CrudModel model1 = new CrudModel(baseDao.select(new SelectBean("id", "1"), "Question.getById"));
		String m = MDTool.markdown2Html((String)(model1.getRow().get("topic")));
		model.getRow().put("markdown", m);*/
		return model;
	}

	/**
	 * 查询多条试题
	 * query：0查询全部试题，1根据题库id查询试题,2查询全部知识点，3根据题库id和试题类型
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		ListModel listModel = null;
		//获取查询参数
		String query = selectBean.getParameters().get("query").toString();
		
		if("0".equals(query)){
			listModel = baseDao.select(selectBean, "Question.getList");
		}
		if("1".equals(query)){
			listModel = baseDao.select(selectBean, "Question.getListByQuestionBankId");
		}
		if("2".equals(query)){
			listModel = baseDao.select(selectBean, "Question.getKnowledgeList");
		}
		if("3".equals(query)){
			listModel = baseDao.select(selectBean, "Question.getListByQbAmdtp");
		}
		
		return listModel;
	}

	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		//先做数据校验
		check(map);
		//获取页面传过来的试题id
		String id = (String) map.get("id");
		//为该试题生成新的id，如果是修改则ucode是不变的
		String newId = UUID.randomUUID().toString().replaceAll("-", "");
		map.put("id",newId);
		//判断是修改还是新增
		if(StringUtils.isNotBlank(id)){//修改
			//取消对应id试题的最新状态
			Map<String, Object> idMap = new HashMap<String, Object>(10);
			idMap.put("id", id);
			cancelQuestionIsNew(idMap);
		}else{
			//增加code
			map.put("question_code", UUID.randomUUID().toString().replaceAll("-", ""));
		}
		
		//增加当前登录人id为增加着id
		map.put("createUserId", UserCacheUtils.getUserId());
		
		OperateModel model = new OperateModel();
		//保存试题
		try {
			baseDao.operate(map, "Question.post");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("保存试题时，增加试题失败");
		}
		
		if (StringUtils.isNotBlank(id)) {
			//如果是修改，在保存完试题后复制一份该题下的所有选项，挂到新的id下面
			ListModel listModel = baseDao.select(new SelectBean("question_id", id), "Option.getListByQuestionId");
			for (Map<String, Object> map2 : listModel.getRows()) {
				map2.put("id", UUID.randomUUID().toString().replaceAll("-", ""));
				map2.put("question_id", newId);
				try {
					baseDao.operate(map2, "Option.post");
				} catch (Exception e) {
					e.printStackTrace();
					throw new BusinessException("保存试题时，复制选项失败");
				}
			}
		}
		
		//保存试题与知识点的关系
		try {
			String[]  knowledges = ((String)map.get("knowledges")).split(",");
			for (String knowledge_id : knowledges) {
				Map<String, Object> rMap = new HashMap<String, Object>(10);
				rMap.put("id", UUID.randomUUID().toString().replaceAll("-", ""));
				rMap.put("knowledge_id", knowledge_id);
				rMap.put("question_id", newId);
				baseDao.operate(rMap, "Question.addRelationship");
			}
		} catch (Exception e) {
			throw new BusinessException("保存试题时，增加试题与知识点的关联失败");
		}
		model.setResult("success");
		return model;
	}

	
	@Override
	public OperateModel edit(Map<String, Object> map) throws BusinessException {
		
		return null;
	}

	@Override
	public OperateModel remove(String id) throws BusinessException {
		//检查外键关系（试卷详情和答卷详情表）,看看是否可以删除
		CrudModel model1 = new CrudModel(baseDao.select(new SelectBean("id",id), "Question.checkDelete"));
		if ((Long)model1.getRow().get("number") > 0) {
			throw new BusinessException("该试题已被使用，无法删除");
		}
		
		Map<String, Object> map = new HashMap<String, Object>(10);
		map.put("id", id);
		OperateModel model = new OperateModel();
		try {
			//删除与知识点的关系
			//baseDao.operate(map, "Question.deleteRelationship");
			//删除试题选项
			//baseDao.operate(map, "Question.deleteOption");
			//删除试题
			baseDao.operate(map, "Question.delete");//已设置级联删除，会同时删除试题选项、与知识点的关系中间表记录
			model.setResult("success");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("删除该试题失败");
		}
		
		return model;
	}
	
	//取消试题最新状态
	public void cancelQuestionIsNew(Map<String, Object> map)throws BusinessException{
		int rows = baseDao.operate(map, "Question.cancelQuestionIsNew");
		if(rows != 1){
			throw new BusinessException("修改试题时，取消原试题最新状态失败");
		}
	}
	
	/**
	 * 数据校验
	 */
	public void check(Map<String,Object> map) throws BusinessException {
		if (StringUtils.isBlank((String)map.get("topic"))) {
			throw new BusinessException("试题题干不能为空");
		}
		if (StringUtils.isBlank((String)map.get("type"))) {
			throw new BusinessException("试题类型不能为空");
		}
		if (StringUtils.isBlank((String)map.get("level"))) {
			throw new BusinessException("试题难易程度不能为空");
		}
		if (StringUtils.isBlank((String)map.get("knowledges"))) {
			throw new BusinessException("试题关联知识点不能为空");
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
}
