package ${packageName}.web;

import org.apache.shiro.web.servlet.ShiroHttpServletRequest;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.util.StringUtils;
 
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;

public class SessionUtilManager extends DefaultWebSessionManager {
	
	private static final String AUTHORIZATION = "Authorization";  
	  
	private static final String REFERENCED_SESSION_ID_SOURCE = "Stateless request";  

    @Override
    protected Serializable getSessionId(ServletRequest request, ServletResponse response) {
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        String sessionId = httpServletRequest.getHeader(AUTHORIZATION);
        //如果请求头中含有AUTHORIZATION，则设置为sessionId
        if(!StringUtils.isEmpty(sessionId)){       	
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_SOURCE, REFERENCED_SESSION_ID_SOURCE);
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID, sessionId);
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_IS_VALID, Boolean.TRUE);  
            return sessionId;
        }else {
        	//否则按默认规则从cookie取sessionId 
            return super.getSessionId(request, response);
        }
        
    }
}