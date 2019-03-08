package com.xuecheng.manage_cms.dao;

import com.xuecheng.framework.domain.cms.CmsPage;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

/**
 * @Author: sungw
 * @Date: Create in 2019/1/31 16:52
 */
public interface CmsPageRepository extends MongoRepository<CmsPage, String> {

    CmsPage findByPageName(String pageName);

    CmsPage findBySiteIdAndPageNameAndAndPageWebPath(String siteId, String pageName, String pageWebPath);

}
