package com.richfit.caq.exam.service.impl.examinee;

import com.richfit.caq.comm.dao.BaseDao;
import com.richfit.caq.comm.db.DOL;
import com.richfit.caq.comm.entity.CrudModel;
import com.richfit.caq.comm.entity.ListModel;
import com.richfit.caq.comm.entity.OperateModel;
import com.richfit.caq.comm.entity.SelectBean;
import com.richfit.caq.comm.exception.BusinessException;
import com.richfit.caq.comm.service.DataOperater;
import com.richfit.caq.controller.LocalThread;
import com.richfit.caq.exam.util.UserCacheUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @Author: Sunguowei
 * @Date: Create in 2018/9/18 17:30
 */
@DOL
@Service("startExamDOL")
public class StartExamServiceImpl implements DataOperater{

    @Autowired
    private BaseDao baseDao;

    private String namespace = "com.richfit.caq.exam.service.impl.examinee.examPaper";

    @Override
    public CrudModel get(String id) throws BusinessException {
        CrudModel model = null;
        String accountId = LocalThread.getUser().getAccountId();
        if(accountId!=null && !"".equals(accountId)){
            ListModel listModel = baseDao.select(new SelectBean("exam_case_id", id, "examinee_info_id", accountId), namespace + ".getLonginExam");
            if (listModel.getRows().size() < 1) {//未报名本次考试
                throw new BusinessException("NoApply","您未报名本次考试，请先报名！");
            }else {
                model= new CrudModel(listModel);
                model.setResult("1");
            }
        }else{
            throw new BusinessException("NoLogin","您未登录或登录超时，请重新登录！");
        }

        return model;
    }

    @Override
    public ListModel getList(SelectBean selectBean) throws BusinessException {
        return null;
    }

    @Override
    public OperateModel add(Map<String, Object> map) throws BusinessException {
        return null;
    }

    @Override
    public OperateModel edit(Map<String, Object> map) throws BusinessException {
        return null;
    }

    @Override
    public OperateModel remove(String id) throws BusinessException {
        return null;
    }
}
