package ${packageName}.web;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;

import ${packageName}.entity.SysUserDO;
import ${packageName}.service.SysUserService;

@Component
public class GateWayHandlerInterceptor implements HandlerInterceptor {
	private SysUserService sysUserService;
	@Autowired
	public GateWayHandlerInterceptor(@Qualifier("SysUserService")SysUserService sysUserService) {
		this.sysUserService=sysUserService;
	}
	private HashMap<String,Object> fieldMap = new HashMap<String, Object>();

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Boolean flag = false;
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		String timeStamp = request.getHeader("TimeStamp");
		String UserToken = request.getHeader("UserToken");
		String signature = request.getHeader("Signature");
		if (request.getMethod().equals("OPTIONS")) {
			flag = true;
		} else {
			try {
				long s = (System.currentTimeMillis() - Long.valueOf(timeStamp)) / (1000 * 60);
				if (s < 1 && s >= 0) {
					fieldMap.put("userToken", UserToken);
					SysUserDO sysUserDO = sysUserService.getSysUserByOther(fieldMap);
					if (sysUserDO != null) {
						String secretKey = sysUserDO.getUserSecretKey();
						if (signature.equals(DigestUtils.md5Hex(UserToken + timeStamp + secretKey))) {
							flag = true;
						} else {
							JSONObject result = new JSONObject();
							result.put("status", 554);
							result.put("msg", "签名校验失败");
							result.put("data", null);
							PrintWriter out = response.getWriter();
							out.append(result.toString());
							flag = false;
						}
					} else {
						JSONObject result = new JSONObject();
						result.put("status", 554);
						result.put("msg", "令牌错误");
						result.put("data", null);
						PrintWriter out = response.getWriter();
						out.append(result.toString());
						flag = false;
					}
				} else {
					JSONObject result = new JSONObject();
					result.put("status", 554);
					result.put("msg", "时间戳错误");
					result.put("data", null);
					PrintWriter out = response.getWriter();
					out.append(result.toString());
					flag = false;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return flag;
	}

}
