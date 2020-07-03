package ${packageName}.manager;

import org.apache.ibatis.javassist.NotFoundException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.AuthorizationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Description 全局异常类            
 * @author ${author}
 * @since ${date}
 */
 
@ControllerAdvice
@ResponseBody
public class GlobalExceptionManager {
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionManager.class);
	/**
	* 全局异常
	* @param ex UnauthorizedException
	* @return
	*/
	@ExceptionHandler(Exception.class)
    @ResponseBody
    public GlobalErrorDTO globaldefaultExceptionHandler(
    	Exception ex){
	    logger.error("发生错误，{}", ex.getMessage());
        return new GlobalErrorDTO(500,  "发生错误", ex.getMessage());
    }
	
	/**
	* 缺少请求参数异常
	* @param ex HttpMessageNotReadableException
	* @return
	*/
	@ExceptionHandler(MissingServletRequestParameterException.class)
	public GlobalErrorDTO httpMessageNotReadableExceptionhandler(
	    MissingServletRequestParameterException ex) {
	    logger.error("缺少请求参数，{}", ex.getMessage());
	    return new GlobalErrorDTO(554,  "缺少必要的请求参数", ex.getMessage());
	}
	
	/**
	* 请求方式异常
	* @param ex HttpRequestMethodNotSupportedException
	* @return
	*/
	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	public GlobalErrorDTO httpRequestMethodNotSupportedException(
	    HttpRequestMethodNotSupportedException ex) {
	    logger.error("请求方式错误，{}", ex.getMessage());
	    return new GlobalErrorDTO(405,  "请求方式错误", ex.getMessage());
	}
	
	/**
	* 找不到路径
	* @param ex UnauthorizedException
	* @return
	*/
	@ExceptionHandler(NotFoundException.class)
    @ResponseBody
    public GlobalErrorDTO missPathdefaultExceptionHandler(
    	NotFoundException ex){
	    logger.error("未找到，{}", ex.getMessage());
        return new GlobalErrorDTO(404,  "未找到指定路径", ex.getMessage());
    }	
	
	/**
	* 权限不够
	* @param ex AuthorizationException
	* @return
	*/
	@ExceptionHandler(AuthorizationException.class)
    public GlobalErrorDTO authorizationExceptionHandler(
    		AuthorizationException ex){
	    logger.error("权限不够，{}", ex.getMessage());
        return new GlobalErrorDTO(553,  "权限不够", ex.getMessage());
    }
	
	/**
	* 登录验证失败
	* @param ex AuthenticationException
	* @return
	*/
	@ExceptionHandler(AuthenticationException.class)
    public GlobalErrorDTO authenticationExceptionHandler(
    		AuthenticationException ex){
	    logger.error("登录失败，{}", ex.getMessage());
        return new GlobalErrorDTO(553,  "登录验证失败", ex.getMessage());
    }
	
}