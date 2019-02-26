package com.richfit.caq.exam.controller;

import com.alibaba.fastjson.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: Sunguowei
 * @Date: Create in 2018/8/29 9:57
 */
@Controller
public class JsonpTestControl {

    private Logger logger = LoggerFactory.getLogger(JsonpTestControl.class);

    @RequestMapping(value = "/jsonpTest", produces = "application/json; charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public String jsonpTest(HttpServletResponse response, HttpServletRequest request) throws IOException {

        String name = request.getParameter("name");
        String callback = request.getParameter("callback");

        JSONArray arr = new JSONArray();
        arr.add("a");
        arr.add("b");
        arr.add("c");

        //logger.info("123+321+456");

        return callback + "(" + arr.toString() + ")";
        //return null;
    }
}
