package com.richfit.caq.exam.service.impl.examinee;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import com.richfit.caq.controller.LocalThread;
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
 * 未报名的考试
 * @author sunguowei
 *
 */
@DOL
@Service("applyExamListDOL")
public class ApplyExamListServiceImpl implements DataOperater {
	Logger logger = LoggerFactory.getLogger(ApplyExamListServiceImpl.class);
	@Autowired
	private BaseDao baseDao;
	
	private String namespace = "com.richfit.caq.exam.service.impl.examinee.applyExam";
	
	@Override
	public CrudModel get(String id) throws BusinessException {
		CrudModel model = null;
		model = new CrudModel(baseDao.select(new SelectBean("id", id), namespace+".getById"));

		String accountId = LocalThread.getUser().getAccountId();
		if(accountId!=null && !"".equals(accountId)){
			CrudModel model1 = new CrudModel(baseDao.select(new SelectBean("id", id, "examinee_info_id", accountId), namespace + ".getSubFlag"));
			if (model1.getRow()!=null){
				String submit_flag = model1.getRow().get("submit_flag").toString();
				model.getRow().put("submit_flag",submit_flag);
			}else {
				model.getRow().put("submit_flag","0");
			}
		}
		return model;
	}
	/**
	 * 未报名列表
	 */
	@Override
	public ListModel getList(SelectBean selectBean) throws BusinessException {
		String accountId = LocalThread.getUser().getAccountId();
		selectBean.getParameters().put("examinee_id", LocalThread.getUser().getAccountId());
		return baseDao.select(selectBean, namespace+".getList");
	}
	/**
	 * 报名
	 */
	@Override
	public OperateModel add(Map<String, Object> map) throws BusinessException {
		OperateModel model = new OperateModel();
		String accountId = LocalThread.getUser().getAccountId();
		if("1".equals(map.get("is_charge"))){//需付费才能报名
			String payment_info_id = UUID.randomUUID().toString().replace("-", "");
			map.put("id", payment_info_id);
			map.put("examinee_info_id", accountId);
			int operate = baseDao.operate(map, namespace+".savePayInnfo");//保存付费信息
			if(operate > 0){
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				String id = UUID.randomUUID().toString().replace("-", "");
				hashMap.put("id", id);
				hashMap.put("examinee_info_id", accountId);
				hashMap.put("exam_case_id", map.get("exam_case_id"));
				int i = baseDao.operate(hashMap, namespace+".saveApply");//保存为已报名考试
				if(i > 0){
					model.setResult("success");
				}
			}
		}else{//不需付费就可以报名
			String uuid = UUID.randomUUID().toString().replace("-", "");
			map.put("id", uuid);
			//map.put("examinee_info_id", "1");
			map.put("examinee_info_id", accountId);
			int operate = baseDao.operate(map, namespace+".saveApply");
			if(operate > 0){
				model.setResult("success");
			}
		}
		return model;
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
