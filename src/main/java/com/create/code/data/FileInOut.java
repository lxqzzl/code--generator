package com.create.code.data;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileInOut {
    public static List<String> getFile(String path) {
        File file = new File(path);
        File[] array = file.listFiles();
        List<String> templateNameList = new ArrayList<String>();        
        for (int i = 0; i < array.length; i++) {
            if (array[i].isFile()) {
                templateNameList.add(array[i].getName());
            } else if (array[i].isDirectory()) {
                getFile(array[i].getPath());
            }
        }
        return templateNameList; 
    }
    
    
}
