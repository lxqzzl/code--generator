package ${packageName}.web;

import javax.servlet.Filter;

import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authc.Authenticator;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authc.pam.FirstSuccessfulStrategy;
import org.apache.shiro.authc.pam.ModularRealmAuthenticator;
import org.apache.shiro.mgt.DefaultSessionStorageEvaluator;
import org.apache.shiro.mgt.DefaultSubjectDAO;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.mgt.SubjectFactory;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.filter.authc.AnonymousFilter;
import org.apache.shiro.web.filter.authc.LogoutFilter;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;


@Configuration
public class ShiroConfig {
	List<Realm> allRealms = new ArrayList<Realm>();
	
    /*
            *  告诉shiro不要使用默认的DefaultSubject创建对象，因为不能创建Session
     **/
    @Bean
    public SubjectFactory subjectFactory() {
        return new JwtDefaultSubjectFactory();
    }
    
    @Bean
    public Realm jwtRealm() {
        JwtRealm jwtrealm=new JwtRealm();
        return jwtrealm;
    }
    
    @Bean
	public Realm clientRealm() {
		ClientRealm clientRealm=new ClientRealm(); 
		clientRealm.setCredentialsMatcher(hashedCredentialsMatcher());
		return clientRealm;
	}
    
    @Bean
    public DefaultWebSecurityManager securityManager() {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        allRealms.add(jwtRealm());
        allRealms.add(clientRealm());
        securityManager.setRealms(allRealms);
        // 关闭 ShiroDAO 功能
        DefaultSubjectDAO subjectDAO = new DefaultSubjectDAO();
        DefaultSessionStorageEvaluator defaultSessionStorageEvaluator = new DefaultSessionStorageEvaluator();
        // 不需要将 Shiro Session 中的东西存到任何地方（包括 Http Session 中）
        defaultSessionStorageEvaluator.setSessionStorageEnabled(false);
        subjectDAO.setSessionStorageEvaluator(defaultSessionStorageEvaluator);
        securityManager.setSubjectDAO(subjectDAO);
        //禁止Subject的getSession方法
        securityManager.setSubjectFactory(subjectFactory());
        return securityManager;
    }
    
    @Bean
    public Authenticator authenticator(){
        ModularRealmAuthenticator authenticator = new ModularRealmAuthenticator();
        authenticator.setRealms(Arrays.asList(this.jwtRealm(),this.clientRealm()));
        //如果有多个Realms才需要指定realm匹配策略
        authenticator.setAuthenticationStrategy(new FirstSuccessfulStrategy());
        return authenticator;
    }

    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
        shiroFilter.setSecurityManager(securityManager);
        shiroFilter.setLoginUrl("/unauthenticated");
        shiroFilter.setUnauthorizedUrl("/unauthorized");
        /*
         *  添加jwt过滤器，并在下面注册
         * 也就是将jwtFilter注册到shiro的Filter中
         * 指定除了login和logout之外的请求都先经过jwtFilter
         * */
        Map<String, Filter> filterMap = new HashMap<>();
        //这个地方其实另外两个filter可以不设置，默认就是
        filterMap.put("anon", new AnonymousFilter());
        filterMap.put("jwt", new JwtFilter());
        filterMap.put("logout", new LogoutFilter());
        shiroFilter.setFilters(filterMap);

        // 拦截器
        Map<String, String> reqfilterMap = new LinkedHashMap<>();
        reqfilterMap.put("/login", "anon");
        reqfilterMap.put("/logout", "anon");
        reqfilterMap.put("/doc.html", "anon");
        
        shiroFilter.setFilterChainDefinitionMap(reqfilterMap);
        return shiroFilter;
    }
	
	@Bean
    public HashedCredentialsMatcher hashedCredentialsMatcher() {
        HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
        hashedCredentialsMatcher.setHashAlgorithmName("md5");//散列算法:这里使用MD5算法;
        hashedCredentialsMatcher.setHashIterations(2);//散列的次数，比如散列两次，相当于 md5(md5(""));
        return hashedCredentialsMatcher;
    }	
	
	/**
	 * 保证实现了Shiro内部lifecycle函数的bean执行
	 */
	@Bean
	public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
		return new LifecycleBeanPostProcessor();
	}

	/**
	 * 启用shrio授权注解拦截方式，AOP式方法级权限检查
	 */
	@Bean
	@DependsOn({"lifecycleBeanPostProcessor"})
	public DefaultAdvisorAutoProxyCreator defaullifecycleBeanPostProcessortAdvisorAutoProxyCreator() {
		return new DefaultAdvisorAutoProxyCreator();
	}
	
	/**
	 * 加入注解的使用，不加入这个注解不生效 使用shiro框架提供的切面类，用于创建代理对象
	 * 
	 * @param securityManager
	 * @return
	 */
	@Bean
	public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(
			DefaultWebSecurityManager securityManager) {
		AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
		authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
		return authorizationAttributeSourceAdvisor;
	}
	/**
	 * 以下为不是用JWT,采用Session保存登录信息
	 */
	//	@Bean
//    public SessionManager sessionManager(){  
//		MySessionManager mySessionManager=new MySessionManager();
//	    return mySessionManager;
//    }


//	@Bean
//	public SecurityManager securityManager() {
//		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
//        securityManager.setRealm(clientRealm());
//        securityManager.setSessionManager(sessionManager());
//		return securityManager;
//	}
//	

//	@Bean
//	public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
//		ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
//		shiroFilter.setSecurityManager(securityManager);		
//      Map<String, Filter> filterMap = new HashMap<>();
//      filterMap.put("auth",new reqAuthenticationFilter());      
//      shiroFilter.setFilters(filterMap);       
//		Map<String, String> map = new LinkedHashMap<>();		
//		map.put("/dologin", "anon");
//		map.put("/","anon");	
//		shiroFilter.setFilterChainDefinitionMap(map);
//		return shiroFilter;
//	}	

}
