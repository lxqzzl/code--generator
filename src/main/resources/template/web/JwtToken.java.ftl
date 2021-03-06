package ${packageName}.web;

import org.apache.shiro.authc.AuthenticationToken;

/**
 * JwtToken实体类
 */
public class JwtToken implements AuthenticationToken {


	private static final long serialVersionUID = 1L;

	private String jwt;

	public JwtToken(String jwt) {
		this.jwt = jwt;
	}

	@Override 
	public Object getPrincipal() {
		return jwt;
	}

	@Override 
	public Object getCredentials() {
		return jwt;
	}
}
