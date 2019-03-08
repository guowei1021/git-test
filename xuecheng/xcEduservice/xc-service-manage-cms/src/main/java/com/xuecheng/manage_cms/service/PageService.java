package com.xuecheng.manage_cms.service;

import ch.qos.logback.core.net.SyslogOutputStream;
import com.xuecheng.framework.domain.cms.CmsPage;
import com.xuecheng.framework.domain.cms.request.QueryPageRequest;
import com.xuecheng.framework.domain.cms.response.CmsCode;
import com.xuecheng.framework.domain.cms.response.CmsPageResult;
import com.xuecheng.framework.exception.ExceptionCast;
import com.xuecheng.framework.exception.ExceptionCatch;
import com.xuecheng.framework.model.response.*;
import com.xuecheng.manage_cms.dao.CmsPageRepository;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;

/**
 * @Author: sungw
 * @Date: Create in 2019/1/31 22:29
 */
@Service
public class PageService {

    @Autowired
    private CmsPageRepository cmsPageRepository;

    /**
     * 分页查询
     *
     * @param page             页码,从1开始计数
     * @param size             每页记录数
     * @param queryPageRequest 查询参数
     * @return
     */
    public QueryResponseResult findList(int page, int size, QueryPageRequest queryPageRequest) {

        if (queryPageRequest == null) {
             queryPageRequest = new QueryPageRequest();
        }

        //自定义条件查询
        //定义条件匹配器
        ExampleMatcher exampleMatcher = ExampleMatcher.matching();
        exampleMatcher = exampleMatcher.withMatcher("pageAliase", ExampleMatcher.GenericPropertyMatchers.contains());

        //条件值对象
        CmsPage cmsPage = new CmsPage();

        //设置条件值
        //站点ID作为查询条件
        if(StringUtils.isNotEmpty(queryPageRequest.getSiteId())){
            cmsPage.setSiteId(queryPageRequest.getSiteId());
        }
        //模板ID作为查询条件
        if(StringUtils.isNotEmpty(queryPageRequest.getTemplateId())){
            cmsPage.setTemplateId(queryPageRequest.getTemplateId());
        }
        //页面别名作为查询条件
        if(StringUtils.isNotEmpty(queryPageRequest.getPageAliase())){
            cmsPage.setPageAliase(queryPageRequest.getPageAliase());
        }

        //自定义Example
        Example<CmsPage> example = Example.of(cmsPage, exampleMatcher);

        //分页参数
        if (page <= 0) {
            page = 1;
        }
        page = page - 1;

        if (size <= 0) {
            size = 10;
        }
        Pageable pageable = PageRequest.of(page, size);
        Page<CmsPage> all = cmsPageRepository.findAll(example,pageable);

        QueryResult<CmsPage> queryResult = new QueryResult<>();
        queryResult.setList(all.getContent());//数据集合
        queryResult.setTotal(all.getTotalElements());//总记录数

        QueryResponseResult queryResponseResult = new QueryResponseResult(CommonCode.SUCCESS, queryResult);

        return queryResponseResult;
    }

    /**
     * 新增页面信息
     * @param cmsPage
     * @return
     */
    public CmsPageResult add(CmsPage cmsPage){
        //异常处理
        if(cmsPage==null){

        }
        //根据站点ID,页面名称,页面webPath查询页面的唯一性
        CmsPage queryResult = cmsPageRepository.findBySiteIdAndPageNameAndAndPageWebPath(cmsPage.getSiteId(), cmsPage.getPageName(), cmsPage.getPageWebPath());
        if(queryResult != null){
            //捕获异常
            ExceptionCast.cast(CmsCode.CMS_ADDPAGE_EXISTSNAME);
        }

        cmsPage.setPageId(null);
        //插入页面信息
        CmsPage save = cmsPageRepository.save(cmsPage);
        return new CmsPageResult(CommonCode.SUCCESS, save);

        //添加失败
        //return new CmsPageResult(CommonCode.FAIL,null);
    }

    /**
     * 根据id查询页面信息
     * @param id
     * @return
     */
    public CmsPage findById(String id){
        Optional<CmsPage> optional = cmsPageRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return null;
    }

    /**
     * 根据id修改页面信息
     * @param id
     * @param cmsPage
     * @return
     */
    public CmsPageResult edit(String id, CmsPage cmsPage){
        //根据id查询页面信息
        CmsPage cmsPage1 = this.findById(id);
        //根据站点id，页面名称，页面webpath查询是否已存在（不包括自己）
        CmsPage cmsPage2 = cmsPageRepository.findBySiteIdAndPageNameAndAndPageWebPath(cmsPage.getSiteId(), cmsPage.getPageName(), cmsPage.getPageWebPath());
        if(cmsPage1 == null){
            CommonCode.FAIL.setSuccess(false);
            CommonCode.FAIL.setCode(11111);
            CommonCode.FAIL.setMessage("您要修改的数据不存在,请查证后操作!");
            return new CmsPageResult(CommonCode.FAIL,null);
        }else if(cmsPage2!=null && !id.equals(cmsPage2.getPageId())){
            CommonCode.FAIL.setSuccess(false);
            CommonCode.FAIL.setCode(11111);
            CommonCode.FAIL.setMessage("此站点下已有相同页面名称、相同页面webPath的页面！");
            return new CmsPageResult(CommonCode.FAIL,null);
        }else if(cmsPage1!=null){
            //更新页面信息
            cmsPage1.setTemplateId(cmsPage.getTemplateId());
            cmsPage1.setSiteId(cmsPage.getSiteId());
            cmsPage1.setPageAliase(cmsPage.getPageAliase());
            cmsPage1.setPageName(cmsPage.getPageName());
            cmsPage1.setPageWebPath(cmsPage.getPageWebPath());
            cmsPage1.setPagePhysicalPath(cmsPage.getPagePhysicalPath());
            //保存数据
            CmsPage save = cmsPageRepository.save(cmsPage1);
            return new CmsPageResult(CommonCode.SUCCESS,save);
        }
        return new CmsPageResult(CommonCode.FAIL,null);
    }

    /**
     * 根据id删除页面
     * @param id
     * @return
     */
    public ResponseResult delete(String id){
        //查询页面是否存在
        Optional<CmsPage> optional = cmsPageRepository.findById(id);
        if(optional.isPresent()){
            //删除
            cmsPageRepository.deleteById(id);
            return new ResponseResult(CommonCode.SUCCESS);
        }
        return new ResponseResult(CommonCode.FAIL);
    }
}
