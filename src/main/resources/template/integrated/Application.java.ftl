package ${cfg.packageName};

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@MapperScan({"${cfg.packageName}.dao.*"} )
@EnableAsync
public class Application {
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}