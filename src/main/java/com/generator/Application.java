package com.generator;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@MapperScan({"com.gitee.sunchenbin.mybatis.actable.dao.*"} )
@ComponentScan("com.gitee.sunchenbin.mybatis.actable.manager.*") 
public class Application {
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}
