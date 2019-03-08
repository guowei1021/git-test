package com.xuecheng.manage_cms.service;

import com.xuecheng.framework.domain.cms.CmsConfig;
import com.xuecheng.framework.domain.cms.response.CmsCode;
import com.xuecheng.framework.exception.ExceptionCast;
import com.xuecheng.manage_cms.dao.CmsConfigRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * cms配置service
 *
 * @Author: sungw
 * @Date: Create in 2019/3/8 22:43
 */
@Service
public class CmsConfigService {

    @Autowired
    private CmsConfigRepository cmsConfigRepository;

    public CmsConfig getCmsConfigById(String id) {

        if (id != null && id != "") {
            Optional<CmsConfig> optional = cmsConfigRepository.findById(id);
            if (optional.isPresent()){
                CmsConfig cmsConfig = optional.get();
                return cmsConfig;
            }
        }else {
            ExceptionCast.cast(CmsCode.CMS_PARAMSISNULL);
        }

        return null;
    }
}
