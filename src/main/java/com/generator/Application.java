package com.generator;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;

@SpringBootApplication
@MapperScan({"com.gitee.sunchenbin.mybatis.actable.dao.*"} )
@ComponentScans(value = 
    {@ComponentScan("com.gitee.sunchenbin.mybatis.actable.manager.*"),
	@ComponentScan("com.generator.controller.*")}
	)
public class Application {
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}
