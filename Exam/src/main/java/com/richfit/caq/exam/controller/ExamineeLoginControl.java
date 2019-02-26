package com.richfit.caq.exam.controller;

import com.richfit.caq.comm.entity.ListModel;
import com.richfit.caq.comm.entity.OperateModel;
import com.richfit.caq.comm.entity.SelectBean;
import com.richfit.caq.comm.exception.BusinessException;
import com.richfit.caq.comm.service.DataOperater;
import com.richfit.caq.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Encoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: Sunguowei
 * @Date: Create in 2018/8/31 10:25
 */
@Controller
@RequestMapping("/login")
public class ExamineeLoginControl {

    @Autowired
    private DataOperater examineeLoginDOL;

    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    public ListModel login(HttpServletRequest request, HttpServletResponse response) throws BusinessException {

        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String s = md5Password(password);
        ListModel listModel = examineeLoginDOL.getList(new SelectBean("account", account, "password", md5Password(password)));
        if (listModel.getResult()=="success"){
            User user = new User();
            user.setAccountId(listModel.getRows().get(0).get("account_id").toString());
            user.setAccount(listModel.getRows().get(0).get("account").toString());
            //将用户信息存到session中
            request.getSession().setAttribute("user",user);
        }
        return listModel;
    }

    //退出登录
    @RequestMapping(value = "loginout", method=RequestMethod.POST )
    @ResponseBody
    public OperateModel loginout(HttpServletRequest request, HttpServletResponse response) throws BusinessException {
        OperateModel model = new OperateModel();
        request.getSession().removeAttribute("user");
        model.setResult("success");
        return model;
    }
    //获取用户信息
    @RequestMapping(value = "user", method=RequestMethod.POST )
    @ResponseBody
    public User user(HttpServletRequest request, HttpServletResponse response) throws BusinessException {
        return (User) request.getSession().getAttribute("user");
    }

    /**
     * 生成32位md5码
     * @param password
     * @return
     */
    public String md5Password(String password) {

        try {
            // 得到一个信息摘要器
            MessageDigest digest = MessageDigest.getInstance("md5");
            byte[] result = digest.digest(password.getBytes());
            StringBuffer buffer = new StringBuffer();
            // 把每一个byte 做一个与运算 0xff;
            for (byte b : result) {
                // 与运算
                int number = b & 0xff;// 加盐
                String str = Integer.toHexString(number);
                if (str.length() == 1) {
                    buffer.append("0");
                }
                buffer.append(str);
            }

            // 标准的md5加密后的结果
            return buffer.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return "";
        }

    }
}
