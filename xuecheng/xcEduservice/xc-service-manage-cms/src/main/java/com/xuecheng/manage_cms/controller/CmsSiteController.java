package com.xuecheng.manage_cms.controller;

import com.xuecheng.api.cms.CmsSiteControllerApi;
import com.xuecheng.framework.domain.cms.request.QuerySiteRequest;
import com.xuecheng.framework.model.response.QueryResponseResult;
import com.xuecheng.manage_cms.service.SiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @Author: sungw
 * @Date: Create in 2019/2/7 20:09
 */
@RestController
@RequestMapping("/cms/site")
public class CmsSiteController implements CmsSiteControllerApi {

    @Autowired
    private SiteService siteService;


    @Override
    @GetMapping("/list/{page}/{size}")
    public QueryResponseResult findSiteList(@PathVariable("page") int page, @PathVariable("size") int size, com.xuecheng.framework.domain.cms.request.QuerySiteRequest querySiteRequest) {
        return null;
    }

    @Override
    /**
     * 查询有所有站点
     */
    @GetMapping("/all")
    public QueryResponseResult findSiteAll() {
        return siteService.findSiteAll();
    }
}
