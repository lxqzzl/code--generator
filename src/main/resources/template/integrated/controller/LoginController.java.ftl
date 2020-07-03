package ${packageName}.controller;

import java.util.HashMap;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import ${packageName}.entity.SysUserDO;
import ${packageName}.manager.EncryptionUtilManager;
import ${packageName}.service.SysUserService;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

@RestController
@RequestMapping("${global.version}")
public class LoginController {
	/**
	 * 通过构造方法自动注入
	 */
    private SysUserService sysUserService;	
	@Autowired
    public LoginController(@Qualifier("SysUserService")SysUserService sysUserService) {
		this.sysUserService=sysUserService;
	}
	
	/**
	 * 查询条件集
	 */
	private HashMap<String, Object> fieldMap = new HashMap<String, Object>();
	
	/**
	 * 日志记录
	 */
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	/**
	 * 登录 
	 * @param username 用户名
	 * @param password 密码
	 * @return SysUserDO 用户实体类
	 */
	@PostMapping("/login")
	@ApiOperation(value = "登录", httpMethod = "POST", notes = "登录")
	@ApiImplicitParams({ 
		@ApiImplicitParam(name = "data", value = "包含用户名和Base64加密后的密码；数据结构为{\"username\":\"用户名\",\"password\":\"Base64加密后的密码\"}", paramType = "body", dataType = "String")
		})
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
			@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
			@ApiResponse(code = 555, message = "请求超时，请重试") })
	public SysUserDO doLogin(@RequestBody(required=false) String data) {
		logger.info("receive:[data:"+data+"]");
		//将请求体的数据转换为JSONObject，并获取用户名和密码
		JSONObject dataJsonObject = JSONObject.parseObject(data);
		String userLoginName = dataJsonObject.getString("username");
		String userPassword = dataJsonObject.getString("password");
		//创建Subject参数
		Subject subject = SecurityUtils.getSubject();
		try {
			//调用login()方法进行登录验证
			subject.login(new UsernamePasswordToken(userLoginName, userPassword));
			//根据用户名获取用户数据并返回
			fieldMap.put("userLoginName", userLoginName);
			SysUserDO sysUserDO = this.sysUserService.getSysUserByOther(fieldMap);
			logger.info("return:[sysUserDO:"+sysUserDO+"]");
			return sysUserDO;
		} catch (Exception e) {
			//捕捉异常并返回null
			logger.info(e.getMessage());
			return null;
		}	
	}
	
	/**
	 * 登录 
	 * @param username 用户名
	 * @param password 密码
	 * @return 注册结果
	 */
	@PostMapping("/registered")
	@ApiOperation(value = "注册", httpMethod = "POST", notes = "登录")
	@ApiImplicitParams({ 
		@ApiImplicitParam(name = "data", value = "包含用户名和Base64加密后的密码；数据结构为{\"username\":\"用户名\",\"password\":\"Base64加密后的密码\"}", paramType = "body", dataType = "String")
		})
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
			@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
			@ApiResponse(code = 555, message = "请求超时，请重试") })
	public Boolean registered(@RequestBody(required=false) String data) {
		logger.info("receive:[data:"+data+"]");
		//将请求体的数据转换为JSONObject，并获取用户名和密码
		JSONObject dataJsonObject = JSONObject.parseObject(data);
		String userLoginName = dataJsonObject.getString("username");
		String userPassword = dataJsonObject.getString("password");
		//创建SysUserDO，写入用户登录名与MD5加密后的密码
		SysUserDO sysUserDO = new SysUserDO();
		sysUserDO.setUserLoginName(userLoginName);
		sysUserDO.setUserPassword(EncryptionUtilManager.encryptionByMD5(userLoginName, userPassword));
		try {
			//调用insertSysUser()方法插入数据，并返回true
			logger.info("Intermediate variable:[userLoginName:"+sysUserDO.getUserLoginName()+"--userPassword:"+sysUserDO.getUserPassword()+";]");
			this.sysUserService.insertSysUser(sysUserDO);
			return true;
		}catch (Exception e) {
			//捕捉异常并返回false
			logger.info(e.getMessage());
			return false;
		}
	
	}
}
