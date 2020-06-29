package com.create.code.generator;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;

import ch.qos.logback.core.joran.conditional.IfAction;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class Generator {
	/**
	 * 生成其他基础类
	 * 
	 */
	public static void baseCodeGenerate(List<String> fileNames, Map<String, String> dataModel, String basePath,
			String targetPath) throws IOException, TemplateException {
		// 创建输出目录子目录
		File childFiles = new File(targetPath + "/src/main/java"+ getPackagePath(dataModel.get("packageName"))+ "/" + basePath.substring(basePath.lastIndexOf("\\") + 1));
		// 如果子目录不存在
		if (!childFiles.exists()) {
		// 创建子目录
			childFiles.mkdir();
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
			System.out.println("正在生成" + fileName + "下的");
			Template template1 = configuration.getTemplate(fileName);
			// 创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名
			Writer out = new FileWriter(new File(targetPath+ "/src/main/java"+ getPackagePath(dataModel.get("packageName")) + "/" + basePath.substring(basePath.lastIndexOf("\\") + 1)
					+ "/" + fileName.substring(0, fileName.length() - 4)));
			// 调用模板对象的process方法输出文件。
			template1.process(dataModel, out);
			System.out.println("生成" + fileName + "结束");
			// 第八步：关闭流。
			out.close();
		}
	}
	
	public static String getPackagePath(String packageString) {
		List<String> paths=new ArrayList<String>();
		while(packageString.contains(".")) {
		String path = packageString.substring(0, packageString.indexOf("."));
		paths.add(path);
		packageString = packageString.substring(packageString.indexOf(".")+1);
		}
		paths.add(packageString);
		String filePath = "";
		for(String singlePath:paths) {
			filePath = filePath+ "/"+singlePath;
		}
		System.out.println(filePath);
		return filePath;
		
	}
}
