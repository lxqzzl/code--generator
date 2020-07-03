package ${packageName}.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import ${packageName}.web.GateWayHandlerInterceptor;
/**
 * @Description web网关配置类
 * @author ${author}
 * @since ${date}
 */

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	@Autowired
	GateWayHandlerInterceptor gatewayHandlerInterceptor;
	
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("GET", "HEAD", "POST", "PUT", "PATCH", "DELETE", "OPTIONS")
                .allowCredentials(true)
                .maxAge(3600)
                .allowedHeaders("*");
    }
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(gatewayHandlerInterceptor).addPathPatterns("/**").excludePathPatterns("/login")
				.excludePathPatterns("/swagger-resources/**", "/webjars/**", "/v2/**", "/swagger-ui.html/**",
						"/doc.html/**");
    }
}
