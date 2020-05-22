package ${packageName}.web;

import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import ${packageName}.web.JwtToken;

@Slf4j
public class JwtRealm extends AuthorizingRealm {
    /*
     * supports()方法用来标识这个Realm是专门用来验证JwtToken
     * */
    @Override
    public boolean supports(AuthenticationToken token) {
        //这个token就是从过滤器中传入的jwtToken
        return token instanceof JwtToken;
    }

    /*
     * doGetAuthorizationInfo（）不做授权操作
     * */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    /*
     * doGetAuthenticationInfo（）验证Jwt
     * */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String jwt = (String) token.getPrincipal();
        if (jwt == null) {
            throw new NullPointerException("jwtToken 不允许为空");
        }
        JwtUtil jwtUtil = new JwtUtil();
        if (!jwtUtil.isVerify(jwt)) {
            throw new UnknownAccountException();
        }
        String username = (String) jwtUtil.decode(jwt).get("username");
        return new SimpleAuthenticationInfo(jwt,jwt,"JwtRealm");

    }

}
