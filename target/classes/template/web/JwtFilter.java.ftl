package ${packageName}.web;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.web.filter.AccessControlFilter;

import com.alibaba.fastjson.JSON;

import ${packageName}.web.JwtToken;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
* Jwt拦截器
*/
public class JwtFilter extends AccessControlFilter {

	/**
	 * isAccessAllowed()验证JWT
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse,
			Object mappedValue) throws Exception {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		Boolean flag = false;
		if (request.getMethod().equals("OPTIONS")) {
		    flag =true;
		} else {
		String jwt = request.getHeader("Authorizationtoken");
		try {
			JwtToken jwtToken = new JwtToken(jwt);
			getSubject(servletRequest, servletResponse).login(jwtToken);
			flag = true;
		} catch (AuthenticationException e) {
			flag = false;
		}
		}
		return flag;
	}

	/**
	 * onAccessDenied未携带JWT,提示未登录
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
		HttpServletResponse res = (HttpServletResponse) servletResponse;
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		if (request.getMethod().equals("OPTIONS")) {
			return true;
		} else {
			res.setHeader("Access-Control-Allow-Origin", "*");
			res.setStatus(HttpServletResponse.SC_OK);
			res.setCharacterEncoding("UTF-8");
			res.setContentType("application/json");
			PrintWriter writer = res.getWriter();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("status", 553);
			map.put("msg", "未登录");
			map.put("data", null);
			writer.write(JSON.toJSONString(map));
			writer.close();
			return true;
		}
	}
}
