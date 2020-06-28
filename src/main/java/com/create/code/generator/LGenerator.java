package com.create.code.generator;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.converts.MySqlTypeConvert;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

/**
 * @author lxq
 * @since 2019-11-01
 */
public class LGenerator {
	private static String CHANGE_TO_BOOLEAN = "tinyint";
	private static String CHANGE_TO_DATE = "datetime";
	private static String CHANGE_TO_LONG = "bigint";
	static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public static void generator(Map<String, Object> dataBaseModel, String[] tableNames, String pre, String packageName,
			String projectPath, String templatePath) {

		AutoGenerator mpg = new AutoGenerator();
		mpg.setTemplateEngine(new FreemarkerTemplateEngine());

		// ============================== 全局配置
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

		// ============================== 数据源配置
		DataSourceConfig dsc = new DataSourceConfig();
		// 配置数据库类型
		dsc.setDbType(DbType.MYSQL).setUrl(dataBaseModel.get("url").toString())
				.setDriverName(dataBaseModel.get("driver").toString())
				.setUsername(dataBaseModel.get("username").toString())
				.setPassword(dataBaseModel.get("password").toString()).setTypeConvert(new MySqlTypeConvert() {
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

		// ==============================包配置
		PackageConfig pc = new PackageConfig();
		// 配置父包路径
		pc.setParent(packageName).setMapper("dao").setEntity("entity").setService("service").setController("controller")
				.setServiceImpl("service.impl");

		// ============================== 自定义配置
		InjectionConfig cfg = new InjectionConfig() {
			@Override
			public void initMap() {
				Map<String, Object> map = new HashMap<>();
				map.put("packageName", packageName);
				map.put("author", "lxq");
				map.put("date", formatter.format(new Date()));
				this.setMap(map);
			}
		};

		TemplateConfig tc = new TemplateConfig();
		tc.setXml(null).setEntity(templatePath+"nentity.java").setService(templatePath+"nservice.java")
				.setServiceImpl(templatePath+"nserviceimpl.java").setController(templatePath+"ncontroller.java")
				.setMapper(templatePath+"nmapper.java");

		// ============================== 策略配置
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

		// ============================== 生成配置

		mpg.setCfg(cfg).setTemplate(tc).setGlobalConfig(gc).setDataSource(dsc).setPackageInfo(pc).setStrategy(strategy);
		mpg.execute();
	}
//	public static void main(String[] args) {
//		// 不同类型数据库许修改数据库类型，默认mariaDB
//		//数据库连接url
//		String url = "jdbc:mysql://192.168.0.156:3306/harem?useUnicode=true&characterEncoding=utf8&autoReconnect=true&allowMultiQueries=true&useSSL=false&serverTimezone=UTC";
//		//数据库驱动
//		String driver = "com.mysql.cj.jdbc.Driver";
//		//数据库用户名
//		String username = "root";
//		//数据库密码
//		String password = "123456";
//		//要生成的数据表
//		String[] tableName = new String[] {"harem_attribute","harem_clothes","harem_eye","harem_hair","harem_info","harem_merge","harem_threes"};
//		//表头
//		String tableNamePrefix = "harem_";
//		//包路径
//		String packageName = "com.harem.info.hareminfomanager";
//		generator(url, driver, username, password, tableName, tableNamePrefix, packageName);
//	}

}
