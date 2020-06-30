package com.generator.manager;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ManagerUtil {
	/**
	 * 将包名转为路径
	 * @param packageString 包名
	 * @return filePath 路径
	 */
	public static String getPackagePath(String packageString) {
	    //用于存放路径文件夹名
		List<String> paths=new ArrayList<String>();
		//将包名的各部分拆开放进列表中
		while(packageString.contains(".")) {
		String path = packageString.substring(0, packageString.indexOf("."));
		paths.add(path);
		packageString = packageString.substring(packageString.indexOf(".")+1);
		}
		//循环到最后会剩下最后部分,要单独放到列表
		paths.add(packageString);
		String filePath = "";
		//将列表中的文件夹名拼接起来组成路劲
		for(String singlePath:paths) {
			filePath = filePath+ "/"+singlePath;
		}
		return filePath;		
	}
	
	/**
	 * 获取子文件夹路径列表 
	 * @param path 主文件夹路径
	 * @return folders 子文件夹路径列表
	 */
	public static List<String> getfolders(String path) {
		File file = new File(path);
		File[] array = file.listFiles();
		List<String> folders = new ArrayList<String>();
		//遍历文件夹下的所有文件
		for (int i = 0; i < array.length; i++) {
			//如果是文件夹就放进列表中
			if (array[i].isDirectory()) {
				folders.add(array[i].getPath());
			}
		}
		return folders;
	}
	
	/**
	 * 获取文件名列表
	 * @param path
	 * @return fileMap 文件路径
	 */
	public static Map<String, List<String>> getFiles(String path) {
		Map<String, List<String>> fileMap = new HashMap<String, List<String>>();
		//获取子文件夹列表
		List<String> folders = getfolders(path);
		//遍历所有文件夹
		for(String folderPath:folders) {
			List<String> fileNames = new ArrayList<String>();
			File file = new File(folderPath);
			File[] files = file.listFiles();
			//遍历文件夹下所有文件
			for (int i = 0; i < files.length; i++) {
				if (files[i].isFile()) {
					//将文件名存放进列表
					fileNames.add(files[i].getName());
				}
			}
			//将文件夹路径与文件名对应
			fileMap.put(folderPath, fileNames);
		}		
		return fileMap;
	}
}
