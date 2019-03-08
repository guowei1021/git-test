package com.xuecheng.manage_cms.service;

import com.xuecheng.framework.domain.cms.CmsPage;
import com.xuecheng.framework.domain.cms.CmsSite;
import com.xuecheng.framework.model.response.CommonCode;
import com.xuecheng.framework.model.response.QueryResponseResult;
import com.xuecheng.framework.model.response.QueryResult;
import com.xuecheng.manage_cms.dao.CmsPageRepository;
import com.xuecheng.manage_cms.dao.CmsSiteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: sungw
 * @Date: Create in 2019/2/7 19:59
 */
@Service
public class SiteService {

    @Autowired
    private CmsSiteRepository cmsSiteRepository;

    public QueryResponseResult findSiteAll(){

        List<CmsSite> list = cmsSiteRepository.findAll();

        QueryResult<CmsSite> queryResult = new QueryResult<>();
        queryResult.setList(list);

        QueryResponseResult queryResponseResult = new QueryResponseResult(CommonCode.SUCCESS,queryResult);

        return queryResponseResult;
    }
}
