package com.create.code;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.create.code.file.FileIn;
import com.create.code.generator.Generator;
import com.create.code.generator.LGenerator;

import freemarker.template.TemplateException;

/**
 * @author lxq
 * @since 2020-04-22 14:00:52
 */
public class ApiApplication 
{
    public static void main( String[] args ) throws IOException, TemplateException
    {
    	String projectPath = System.getProperty("user.dir");
    	Map<String, List<String>> map = FileIn.getFile(projectPath+"/src/main/resources/template/integrated");
    	Map<String, String> dataModel = new HashMap<String, String>();
    	dataModel.put("packageName", "com.demo.gtest");
    	dataModel.put("author", "lxq");
    	dataModel.put("date", new Date().toString());
    	dataModel.put("swaggerName", "dev");
    	Map<String, Object> dataBaseModel = new HashMap<String, Object>();
    	dataBaseModel.put("url", "jdbc:mysql://192.168.0.185:3306/gtest?useUnicode=true&characterEncoding=utf8&autoReconnect=true&allowMultiQueries=true&useSSL=false&serverTimezone=UTC");
    	dataBaseModel.put("driver", "com.mysql.cj.jdbc.Driver");
    	dataBaseModel.put("username", "root");
    	dataBaseModel.put("password", "123456");
    	String[] tableNames = new String[] {"gen"};
    	LGenerator.generator(dataBaseModel, tableNames, "", dataModel.get("packageName"), "D:\\WorkSpace\\fireweb\\gtest", "template/integrated/maincode/");
    	for(String basePath:map.keySet()) {
    		if(!basePath.contains("maincode")) {
    			System.out.println("正在生成"+basePath+"下的");
        		Generator.baseCodeGenerate(map.get(basePath), dataModel, basePath, "D:\\WorkSpace\\fireweb\\gtest");
        		System.out.println("生成"+basePath+"下的完成");
    		}
    	}

    	System.out.println("生成结束");
//    	CreateCode.baseCodeGenerate(map, null,projectPath+"/src/main/resources/template/Integrated", "D:/ltest");  
    	}
}