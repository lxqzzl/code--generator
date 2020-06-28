package com.create.code.file;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FileIn {
	/**
	 * 获取文件夹列表
	 * 
	 * @param path
	 */
	public static List<String> getfolders(String path) {
		File file = new File(path);
		File[] array = file.listFiles();
		List<String> folders = new ArrayList<String>();
		for (int i = 0; i < array.length; i++) {
			if (array[i].isDirectory()) {
				folders.add(array[i].getPath());
			}
		}
		return folders;
	}

	/**
	 * 获取文件列表
	 * 
	 * @param path
	 */
	public static Map<String, List<String>> getFile(String path) {
		Map<String, List<String>> fileMap = new HashMap<String, List<String>>();
		List<String> folders = getfolders(path);		
		for(String folderPath:folders) {
			List<String> filePaths = new ArrayList<String>();
			File file = new File(folderPath);
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++) {
				if (files[i].isFile()) {
					filePaths.add(files[i].getName());
				}
			}
			fileMap.put(folderPath, filePaths);
		}		
		return fileMap;
	}
}
