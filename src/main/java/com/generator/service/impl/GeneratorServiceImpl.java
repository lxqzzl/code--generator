package com.generator.service.impl;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.TemplateConfig;
import com.baomidou.mybatisplus.generator.config.converts.MySqlTypeConvert;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.generator.manager.ManagerUtil;
import com.generator.service.GeneratorService;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Service
@Component("GeneratorService")
public class GeneratorServiceImpl implements GeneratorService {
	/**
	 * 数据库字段类型：tinyint
	 */
	private static String CHANGE_TO_BOOLEAN = "tinyint";
	/**
	 * 数据库字段类型：datetime
	 */
	private static String CHANGE_TO_DATE = "datetime";
	/**
	 * 数据库字段类型：bigint
	 */
	private static String CHANGE_TO_LONG = "bigint";
	/**
	 * 时间格式化
	 */
	private static DateTimeFormatter DATETIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	
	@Override
	public void generatorStart() {	
//		mainCodeGenertor(dataBaseModel, tableNames, pre, packageName, projectPath, templatePath);
//		otherCodeGenertor(fileNames, dataModel, basePath, targetPath);

	}

	@Override
	public void mainCodeGenertor(Map<String, String> dataModel, String[] tableNames, String pre, 
			String projectPath, String templatePath) {
		AutoGenerator mpg = new AutoGenerator();
		mpg.setTemplateEngine(new FreemarkerTemplateEngine());

		//全局配置
		GlobalConfig gc = new GlobalConfig();
		gc.setOutputDir(projectPath + "/src/main/java")
				// 是否支持 AR
				.setActiveRecord(true)
				// 设置作者名字
				.setAuthor("lxq")
				// 文件覆盖(全新文件)
				.setFileOverride(true)
				// 主键策略
				.setIdType(IdType.AUTO)
				// SQL 映射文件
				.setBaseResultMap(true)
				// SQL 片段
				.setBaseColumnList(true).setOpen(false);
		gc.setEntityName("%sDO");
		gc.setMapperName("%sMapper");
		gc.setServiceName("%sService");
		gc.setServiceImplName("%sServiceImpl");
		gc.setControllerName("%sController");

		//数据源配置
		DataSourceConfig dsc = new DataSourceConfig();
		// 配置数据库类型
		dsc.setDbType(DbType.MYSQL).setUrl(dataModel.get("url"))
				.setDriverName(dataModel.get("driver"))
				.setUsername(dataModel.get("username"))
				.setPassword(dataModel.get("password")).setTypeConvert(new MySqlTypeConvert() {
					@Override
					public DbColumnType processTypeConvert(GlobalConfig globalConfig, String fieldType) {
						// tinyint转换成Boolean
						if (fieldType.toLowerCase().contains(CHANGE_TO_BOOLEAN)) {
							return DbColumnType.BOOLEAN;
						}
						// 将数据库中datetime转换成date
						if (fieldType.toLowerCase().contains(CHANGE_TO_DATE)) {
							return DbColumnType.DATE;
						}
						// 将数据库中bigint转换成long
						if (fieldType.toLowerCase().contains(CHANGE_TO_LONG)) {
							return DbColumnType.LONG;
						}
						return (DbColumnType) super.processTypeConvert(globalConfig, fieldType);
					}
				});

		//包配置
		PackageConfig pc = new PackageConfig();
		// 配置父包路径
		pc.setParent(dataModel.get("packageName").toString()).setMapper("dao").setEntity("entity").setService("service").setController("controller")
				.setServiceImpl("service.impl");

		//自定义配置
		InjectionConfig cfg = new InjectionConfig() {
			@Override
			public void initMap() {
				Map<String, Object> map = new HashMap<>();
				map.put("packageName", dataModel.get("packageName").toString());
				map.put("author", "lxq");
				map.put("date", LocalDateTime.now().format(DATETIME_FORMATTER));
				this.setMap(map);
			}
		};
        
		//模板配置
		TemplateConfig tc = new TemplateConfig();
		tc.setXml(null).setEntity(templatePath+"nentity.java").setService(templatePath+"nservice.java")
				.setServiceImpl(templatePath+"nserviceimpl.java").setController(templatePath+"ncontroller.java")
				.setMapper(templatePath+"nmapper.java");

		//策略配置
		StrategyConfig strategy = new StrategyConfig();
		// 设置命名规则 underline_to_camel 底线变驼峰
		strategy.setNaming(NamingStrategy.underline_to_camel)
				// 是否加入lombok
				.setEntityLombokModel(true)
				// 设置表名
				.setInclude(tableNames)
				// 设置controller映射联字符
				.setControllerMappingHyphenStyle(true)
				// 表的前缀
				.setTablePrefix(pre);

		//生成配置
		mpg.setCfg(cfg).setTemplate(tc).setGlobalConfig(gc).setDataSource(dsc).setPackageInfo(pc).setStrategy(strategy);
		mpg.execute();		
	}

	@Override
	public void otherCodeGenertor(List<String> fileNames, Map<String, String> dataModel, String basePath,
			String targetPath) throws IOException, TemplateException{
		// 创建输出目录子目录
		if(!basePath.contains("pom"))
		{
			targetPath = targetPath+ "/src/main/java"+ ManagerUtil.getPackagePath(dataModel.get("packageName")) + "/" + basePath.substring(basePath.lastIndexOf("\\") + 1);
		}
		if(basePath.contains("startapp")) {
			targetPath = targetPath.replace("/src/main/java/com/demo/gtest/startapp", "")+ "/src/main/java"+ ManagerUtil.getPackagePath(dataModel.get("packageName"));
		}
		if(basePath.contains("appresources"))
		{
			targetPath = targetPath.replace("java/com/demo/gtest/appresources", "")+ "resources";
		}
		File childFiles = new File(targetPath);
		// 如果子目录不存在
		if (!childFiles.exists()) {
		// 创建子目录
			childFiles.mkdir();
			System.out.println("生成对应文件夹："+targetPath);
		}
		// 创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
		Configuration configuration = new Configuration(Configuration.getVersion());
		// 设置模板文件所在的路径文件夹。
		configuration.setDirectoryForTemplateLoading(new File(basePath));
		// 设置模板文件使用的字符集。一般就是utf-8.
		configuration.setDefaultEncoding("utf-8");
		// 循环遍历文件夹中的所用文件
		for (String fileName : fileNames) {
			// 加载一个模板，创建一个模板对象。
			Template template1 = configuration.getTemplate(fileName);
			// 创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名
			Writer out = new FileWriter(new File(targetPath+ "/" + fileName.substring(0, fileName.length() - 4)));
			// 调用模板对象的process方法输出文件。
			template1.process(dataModel, out);
			// 第八步：关闭流。
			out.close();
		}
		
	}
	
	

}
