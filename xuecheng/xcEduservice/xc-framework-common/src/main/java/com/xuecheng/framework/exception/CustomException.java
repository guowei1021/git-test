package com.xuecheng.framework.exception;

import com.xuecheng.framework.model.response.ResultCode;

/**
 * 自定义异常类型
 * @Author: sungw
 * @Date: Create in 2019/3/4 21:55
 */
public class CustomException extends RuntimeException {

    //错误代码
    ResultCode resultCode;

    public CustomException(ResultCode resultCode){
        this.resultCode = resultCode;
    }

    public ResultCode getResultCode(){
        return resultCode;
    }
}
