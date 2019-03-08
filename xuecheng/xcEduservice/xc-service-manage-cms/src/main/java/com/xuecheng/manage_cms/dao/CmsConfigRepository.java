package com.xuecheng.manage_cms.dao;

import com.xuecheng.framework.domain.cms.CmsConfig;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * cms配置Dao接口
 * @Author: sungw
 * @Date: Create in 2019/3/8 22:41
 */
public interface CmsConfigRepository extends MongoRepository<CmsConfig,String> {

}
