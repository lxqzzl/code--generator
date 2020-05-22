package com.create.code.generator;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class CreateCode {
	private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 * 
	 */
	public static void create1(List<String> fileNames, String basePath, Map<String, String> dataModel, String targetPath) throws IOException, TemplateException {		    
	        // 创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
	        Configuration configuration = new Configuration(Configuration.getVersion());
        	// 设置模板文件所在的路径文件夹。	
        	configuration.setDirectoryForTemplateLoading(new File(basePath));
	        // 设置模板文件使用的字符集。一般就是utf-8.
	        configuration.setDefaultEncoding("utf-8");
	        //循环遍历文件夹中的所用文件
	        for(String fileName:fileNames) {
		        // 加载一个模板，创建一个模板对象。
		        Template template1 = configuration.getTemplate(fileName);
		     // 创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名
		        Writer out = new FileWriter(new File(targetPath+"/GetEntity.java"));
		     // 调用模板对象的process方法输出文件。
		        template1.process(dataModel, out);
		        // 第八步：关闭流。
		        out.close();
	        }
	}

}
