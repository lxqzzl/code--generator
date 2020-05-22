package com.create.code.generator;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
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

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @author lxq
 * @since 2019-11-01
 */
public class LGenerator {
	private static String CHANGE_TO_BOOLEAN="tinyint";
	private static String CHANGE_TO_DATE="datetime";
	private static String CHANGE_TO_LONG="bigint";
	static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static void generator(String url, String driver, String username, String password, String[] tableName,
			String tableNamePrefix, String packageName) {

		AutoGenerator mpg = new AutoGenerator();
		mpg.setTemplateEngine(new FreemarkerTemplateEngine());
		
		String projectPath = System.getProperty("user.dir");
        System.out.println("--------------------------------------------->"+projectPath);
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
		dsc.setDbType(DbType.MYSQL).setUrl(url).setDriverName(driver).setUsername(username).setPassword(password)
		.setTypeConvert(new MySqlTypeConvert() {
		@Override
        public DbColumnType processTypeConvert(GlobalConfig globalConfig, String fieldType) {
            //tinyint转换成Boolean
            if ( fieldType.toLowerCase().contains( CHANGE_TO_BOOLEAN ) ) {
               return DbColumnType.BOOLEAN;
            }
            //将数据库中datetime转换成date
           if ( fieldType.toLowerCase().contains( CHANGE_TO_DATE ) ) {
               return DbColumnType.DATE;
           }
            //将数据库中bigint转换成long
           if(fieldType.toLowerCase().contains(CHANGE_TO_LONG)) {
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
		tc.setXml(null)
		.setEntity("template/nentity.java")
		.setService("template/nservice.java")
		.setServiceImpl("template/nserviceimpl.java")
		.setController("template/ncontroller.java")
		.setMapper("template/nmapper.java");
//		.setController("templates/ncontroller.java.vm")
//				.setMapper("templates/nmapper.java.vm").setService("templates/nservice.java.vm")
//				.setServiceImpl("templates/nserviceImpl.java.vm");

		// ============================== 策略配置
		StrategyConfig strategy = new StrategyConfig();
		// 设置命名规则 underline_to_camel 底线变驼峰
		strategy.setNaming(NamingStrategy.underline_to_camel)
				// 是否加入lombok
				.setEntityLombokModel(true)
				// 设置表名
				.setInclude(tableName)
				// 设置controller映射联字符
				.setControllerMappingHyphenStyle(true)
				// 表的前缀
				.setTablePrefix(tableNamePrefix);

		// ============================== 生成配置

		mpg.setCfg(cfg).setTemplate(tc).setGlobalConfig(gc).setDataSource(dsc).setPackageInfo(pc).setStrategy(strategy);
		mpg.execute();
	}

	public static void create1() throws IOException, TemplateException {
		 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        // 第一步：创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
	        Configuration configuration = new Configuration(Configuration.getVersion());
	        // 第二步：设置模板文件所在的路径。
	        String projectPath = System.getProperty("user.dir");
	        configuration.setDirectoryForTemplateLoading(new File(projectPath + "/src/main/resources/template/manager"));
	        // 第三步：设置模板文件使用的字符集。一般就是utf-8.
	        configuration.setDefaultEncoding("utf-8");
	        // 第四步：加载一个模板，创建一个模板对象。
	        Template template1 = configuration.getTemplate("GetEntity.java.ftl");
	        Template template2 = configuration.getTemplate("GetResult.java.ftl");
	        Template template3 = configuration.getTemplate("ListResult.java.ftl");
	        Template template4 = configuration.getTemplate("PermissionTrans.java.ftl");
	        Template template5 = configuration.getTemplate("Swagger2Config.java.ftl");
	        // 第五步：创建一个模板使用的数据集，可以是pojo也可以是map。一般是Map。
	        Map<String, String> dataModel = new HashMap<>();
	        //向数据集中添加数据
	        dataModel.put("packageName", "com.zc.mp");
	        dataModel.put("date", formatter.format(new Date()));
	        dataModel.put("apiDocTitle", "TestTitle");
	        dataModel.put("apiDocDesc", "");
	        dataModel.put("apiDocUrl", "192.168.0.185");
	        
	        // 第六步：创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名。
	        Writer out1 = new FileWriter(new File(projectPath+"/src/main/java/com/zc/mp/manager/GetEntity.java"));
	        Writer out2 = new FileWriter(new File(projectPath+"/src/main/java/com/zc/mp/manager/GetResult.java"));
	        Writer out3 = new FileWriter(new File(projectPath+"/src/main/java/com/zc/mp/manager/ListResult.java"));
	        Writer out4 = new FileWriter(new File(projectPath+"/src/main/java/com/zc/mp/manager/PermissionTrans.java"));
	        Writer out5 = new FileWriter(new File(projectPath+"/src/main/java/com/zc/mp/manager/Swagger2Config.java"));
	        // 第七步：调用模板对象的process方法输出文件。
	        template1.process(dataModel, out1);
	        template2.process(dataModel, out2);
	        template3.process(dataModel, out3);
	        template4.process(dataModel, out4);
	        template5.process(dataModel, out5);
	        // 第八步：关闭流。
	        out1.close();
	        out2.close();
	        out3.close();
	        out4.close();
	        out5.close();
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

    private void getFile(String path) {
        // get file list where the path has
        File file = new File(path);
        // get the folder list
        File[] array = file.listFiles();

        for (int i = 0; i < array.length; i++) {
            if (array[i].isFile()) {
                // only take file name
                System.out.println("^^^^^" + array[i].getName());
                // take file path and name
                System.out.println("#####" + array[i]);
                // take file path and name
                System.out.println("*****" + array[i].getPath());
            } else if (array[i].isDirectory()) {
                getFile(array[i].getPath());
            }
        }
    }
}
