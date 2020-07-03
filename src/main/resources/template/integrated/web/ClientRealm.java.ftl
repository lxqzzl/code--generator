package ${packageName}.web;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;

import ${packageName}.entity.SysLinkRolePermissionDO;
import ${packageName}.entity.SysLinkUserRoleDO;
import ${packageName}.entity.SysPermissionDO;
import ${packageName}.entity.SysRoleDO;
import ${packageName}.entity.SysUserDO;
import ${packageName}.service.SysLinkRolePermissionService;
import ${packageName}.service.SysLinkUserRoleService;
import ${packageName}.service.SysPermissionService;
import ${packageName}.service.SysRoleService;
import ${packageName}.service.SysUserService;

public class ClientRealm extends AuthorizingRealm {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private SysPermissionService sysPermissionService;
	@Autowired
	private SysLinkUserRoleService sysLinkUserRoleService;
	@Autowired
	private SysLinkRolePermissionService sysLinkRolePermissionService;

    private Logger logger = LoggerFactory.getLogger(ClientRealm.class);
    
    private HashMap<String, Object> fieldMap = new HashMap<String, Object>();

	/**
	 * 权限验证
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		//创建SimpleAuthorizationInfo实例
		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		//获取登录用户名
		String userLoginName = (String) principals.getPrimaryPrincipal();
		logger.info("userLoginName:"+userLoginName);
		//通过用户名获取用户数据
		fieldMap.put("userLoginName", userLoginName);
		SysUserDO sysUserDO = sysUserService.getSysUserByOther(fieldMap);
		fieldMap.clear();
		//通过用户Id获取用户所拥有的全部关联角色Id
		fieldMap.put("userId", sysUserDO.getUserId());
		List<SysLinkUserRoleDO> sysLinkUserRoleDOs = sysLinkUserRoleService.listSysLinkUserRoleByOther(fieldMap, null, null);
		fieldMap.clear();
		
		for(SysLinkUserRoleDO sysLinkUserRoleDO:sysLinkUserRoleDOs) {
			//通过角色Id获取角色数据
			SysRoleDO sysRoleDO = sysRoleService.getSysRoleById(sysLinkUserRoleDO.getRoleId());
			//添加角色名称到simpleAuthorizationInfo
			simpleAuthorizationInfo.addRole(sysRoleDO.getRoleName());
			//通过角色Id获取角色所拥有的全部权限Id
			fieldMap.put("roleId", sysRoleDO.getRoleId());
			List<SysLinkRolePermissionDO> sysLinkRolePermissionDOs = sysLinkRolePermissionService.listSysLinkRolePermissionByOther(fieldMap, null, null);
			fieldMap.clear();	
			
			for(SysLinkRolePermissionDO sysLinkRolePermissionDO:sysLinkRolePermissionDOs) {
				//通过权限id获取权限数据
				SysPermissionDO sysPermissionDO = sysPermissionService.getSysPermissionById(sysLinkRolePermissionDO.getPermissionId());
				//将权限范围与权限代码拼接后，添加到simpleAuthorizationInfo
				simpleAuthorizationInfo.addStringPermission(sysLinkRolePermissionDO.getPermissionRang()+"-"+sysPermissionDO.getPermissionCode());
			}
		}
		logger.info("用户权限：" + simpleAuthorizationInfo.getStringPermissions());
		logger.info("用户角色：" + simpleAuthorizationInfo.getRoles());
		//返回用户角色权限信息
		return simpleAuthorizationInfo;
	}

	/**
	 * 登录认证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		logger.info("Login Authentication Start");
		//将token强转为UsernamePasswordToken并获取登录的用户名
		UsernamePasswordToken userToken = (UsernamePasswordToken) token;
		String userLoginName = userToken.getUsername();
		logger.info("userLoginName："+userLoginName);
		//通过用户名获取用户数据
		fieldMap.put("userLoginName", userLoginName);
		SysUserDO sysUserDO = sysUserService.getSysUserByOther(fieldMap);
		//通过用户名获取盐值，不将盐值存数据库
		ByteSource salt = ByteSource.Util.bytes(userLoginName);
		//校验用户名和密码是否正确
		SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(sysUserDO.getUserLoginName(),
				sysUserDO.getUserPassword(), salt, getName());
		logger.info("salt:"+salt+"--Password:"+sysUserDO.getUserPassword());
		logger.info("Login Authentication End");
		//清空查询条件
		fieldMap.clear();
        //返回校验结果
		return authenticationInfo;
	}

}
