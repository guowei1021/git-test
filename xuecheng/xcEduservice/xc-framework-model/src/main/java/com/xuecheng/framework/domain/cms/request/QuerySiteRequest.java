package com.xuecheng.framework.domain.cms.request;

import com.xuecheng.framework.model.request.RequestData;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @Author: sungw
 * @Date: Create in 2019/2/7 19:47
 */
@Data
public class QuerySiteRequest extends RequestData {

    @ApiModelProperty("站点ID")
    private String siteId;

    @ApiModelProperty("站点名称")
    private String siteName;
}
