package com.generator.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import freemarker.template.TemplateException;

public interface GeneratorService {
	/**
	 * 开始生成
	 */
	public void generatorStart();
	/**
	 * 主要逻辑代码生成（如entity层等）
	 */
	public void mainCodeGenertor(Map<String, Object> dataBaseModel, String[] tableNames, String pre, String packageName,
			String projectPath, String templatePath);
	/**
	 * 其他代码生成（如web层等）
	 */
	public void otherCodeGenertor(List<String> fileNames, Map<String, String> dataModel, String basePath,
			String targetPath)throws IOException, TemplateException;
}
