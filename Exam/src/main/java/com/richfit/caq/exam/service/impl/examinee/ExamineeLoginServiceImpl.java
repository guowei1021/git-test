package com.richfit.caq.exam.service.impl.examinee;

import com.richfit.caq.comm.dao.BaseDao;
import com.richfit.caq.comm.db.DOL;
import com.richfit.caq.comm.entity.CrudModel;
import com.richfit.caq.comm.entity.ListModel;
import com.richfit.caq.comm.entity.OperateModel;
import com.richfit.caq.comm.entity.SelectBean;
import com.richfit.caq.comm.exception.BusinessException;
import com.richfit.caq.comm.service.DataOperater;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @Author: Sunguowei
 * @Date: Create in 2018/8/31 10:36
 */
@DOL
@Service("examineeLoginDOL")
public class ExamineeLoginServiceImpl implements DataOperater {

    private String namespace = "com.richfit.caq.exam.service.impl.examinee.examineeLogin";

    @Autowired
    private BaseDao baseDao;

    @Override
    public CrudModel get(String id) throws BusinessException {

        return null;
    }

    /**
     * 登录
     */
    @Override
    public ListModel getList(SelectBean selectBean) throws BusinessException {
        ListModel listModel = baseDao.select(selectBean, namespace + ".getUserByNameAndPass");
        if (listModel.getRows().size() < 1) {
            throw new BusinessException("账号与密码不匹配，请核对后登录！");
        } else {
            listModel.setResult("success");
        }
        return listModel;
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
