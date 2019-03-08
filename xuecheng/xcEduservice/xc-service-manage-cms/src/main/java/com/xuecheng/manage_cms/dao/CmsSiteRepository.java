package com.xuecheng.manage_cms.dao;

import com.xuecheng.framework.domain.cms.CmsSite;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author: sungw
 * @Date: Create in 2019/2/7 19:57
 */
public interface CmsSiteRepository extends MongoRepository<CmsSite,String> {


}
