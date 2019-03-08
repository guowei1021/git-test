package com.xuecheng.manage_cms.dao;

import com.xuecheng.framework.domain.cms.CmsPage;
import com.xuecheng.framework.domain.cms.CmsPageParam;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.*;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * @Author: sungw
 * @Date: Create in 2019/1/31 17:00
 */
@SpringBootTest
@RunWith(SpringRunner.class)
public class CmsPageRepositoryTest {

    @Autowired
    private CmsPageRepository cmsPageRepository;

    @Test
    public void testFindAll() {

        List<CmsPage> all = cmsPageRepository.findAll();
        System.out.println(all);
    }

    @Test
    public void testFindPage() {

        PageRequest pageRequest = PageRequest.of(2, 10);
        Page<CmsPage> list = cmsPageRepository.findAll(pageRequest);
        System.out.println(list);
    }

    @Test
    public void testSave() {
        CmsPage cmsPage = new CmsPage();
        cmsPage.setSiteId("s02");
        cmsPage.setTemplateId("t02");
        cmsPage.setPageName("测试页面2");
        cmsPage.setPageCreateTime(new Date());

        List<CmsPageParam> cmsPageParams = new ArrayList<>();
        CmsPageParam cmsPageParam = new CmsPageParam();
        cmsPageParam.setPageParamName("param1");
        cmsPageParam.setPageParamValue("value1");
        cmsPageParams.add(cmsPageParam);
        cmsPage.setPageParams(cmsPageParams);

        cmsPage.setPageParams(cmsPageParams);

        cmsPageRepository.save(cmsPage);
        System.out.println(cmsPage);
    }

    @Test
    public void testDelete() {
        cmsPageRepository.deleteById("5c52fd8b058f1b1d38783582");
    }

    @Test
    public void testUpdate() {
        //先查询对象
        Optional<CmsPage> optional = cmsPageRepository.findById("5c52fd40058f1b3bdc7109a4");
        if (optional.isPresent()) {
            CmsPage cmsPage = optional.get();
            //设置要修改的值
            cmsPage.setPageName("测试页面01");
            //修改
            cmsPageRepository.save(cmsPage);
        }
    }

    @Test
    public void testFindByPageName() {
        CmsPage cmsPage = cmsPageRepository.findByPageName("测试页面01");
        System.out.println(cmsPage);
    }

    //自定义条件查询
    @Test
    public void findAllExample() {
        //分页参数
        int page = 0;
        int size = 10;
        Pageable pageable = PageRequest.of(page, size);

        //条件值对象
        CmsPage cmsPage = new CmsPage();
        //要查询5a751fab6abb5044e0d19ea1站点的页面
        //cmsPage.setSiteId("s01");
        cmsPage.setPageAliase("轮播");
        //条件匹配器
        ExampleMatcher exampleMatcher = ExampleMatcher.matching();
        exampleMatcher = exampleMatcher.withMatcher("pageAliase", ExampleMatcher.GenericPropertyMatchers.contains());
        //自定义Example
        Example<CmsPage> example = Example.of(cmsPage, exampleMatcher);

        Page<CmsPage> all = cmsPageRepository.findAll(example, pageable);

        System.out.println(all.getContent());
    }

}
