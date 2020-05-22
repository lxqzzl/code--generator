package ${packageName}.manager;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
 
/**
    * 生成swagger文档配置
 *
 * @author lxq
 * @since ${date}
 */

@Configuration
@EnableSwagger2
public class Swagger2Config {
   @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                 //这里是controller所处的包名
                .apis(RequestHandlerSelectors.basePackage("${packageName}.controller"))
                .paths(PathSelectors.any())
                .build();
    }
   /**
             *    构建api文档的详细信息函数
    * @return ApiInfoBuilder
    */

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                //页面标题
                .title("${apiDocTitle}")
                //描述
                .description("${apiDocDesc}")
                .termsOfServiceUrl("${apiDocUrl}")
                //版本号
                .version("${r'${version}'}")
                .build();
    }
}


