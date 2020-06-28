package com.pay.web.api.manager;

import org.apache.ibatis.javassist.NotFoundException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.AuthorizationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;


import io.jsonwebtoken.ExpiredJwtException;

import org.springframework.web.HttpRequestMethodNotSupportedException;

/**
 * @Description 全局异常类            
 * @author ${author}
 * @since ${date}
 */
 
@ControllerAdvice
@ResponseBody
public class GlobalExceptionHandler {
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
	/**
	* 全局异常
	* @param ex UnauthorizedException
	* @return
	*/
	@ExceptionHandler(Exception.class)
    @ResponseBody
    public GlobalResult globaldefaultExceptionHandler(
    	Exception ex){
	    logger.error("发生错误，{}", ex.getMessage());
        return new GlobalResult(500,  "发生错误", ex.getMessage());
    }
	
	/**
	* 缺少请求参数异常
	* @param ex HttpMessageNotReadableException
	* @return
	*/
	@ExceptionHandler(MissingServletRequestParameterException.class)
	public GlobalResult httpMessageNotReadableExceptionhandler(
	    MissingServletRequestParameterException ex) {
	    logger.error("缺少请求参数，{}", ex.getMessage());
	    return new GlobalResult(554,  "缺少必要的请求参数", ex.getMessage());
	}
	
	/**
	* 请求方式异常
	* @param ex HttpRequestMethodNotSupportedException
	* @return
	*/
	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	public GlobalResult httpRequestMethodNotSupportedException(
	    HttpRequestMethodNotSupportedException ex) {
	    logger.error("请求方式错误，{}", ex.getMessage());
	    return new GlobalResult(405,  "请求方式错误", ex.getMessage());
	}
	
	/**
	* 找不到路径
	* @param ex UnauthorizedException
	* @return
	*/
	@ExceptionHandler(NotFoundException.class)
    @ResponseBody
    public GlobalResult missPathdefaultExceptionHandler(
    	NotFoundException ex){
	    logger.error("未找到，{}", ex.getMessage());
        return new GlobalResult(404,  "未找到指定路径", ex.getMessage());
    }	
	
	/**
	* 权限不够
	* @param ex AuthorizationException
	* @return
	*/
	@ExceptionHandler(AuthorizationException.class)
    public GlobalResult authorizationExceptionHandler(
    		AuthorizationException ex){
	    logger.error("权限不够，{}", ex.getMessage());
        return new GlobalResult(553,  "权限不够", ex.getMessage());
    }
	
	/**
	* 登录验证失败
	* @param ex AuthenticationException
	* @return
	*/
	@ExceptionHandler(AuthenticationException.class)
    public GlobalResult authenticationExceptionHandler(
    		AuthenticationException ex){
	    logger.error("登录失败，{}", ex.getMessage());
        return new GlobalResult(553,  "登录验证失败", ex.getMessage());
    }
	
}
