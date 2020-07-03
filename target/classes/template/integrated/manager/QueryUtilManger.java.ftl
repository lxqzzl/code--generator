package ${packageName}.manager;

import java.lang.annotation.Annotation;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

/**
 * @Description 条件构造工具类            
 * @author ${author}
 * @since ${date}
 */

public class QueryUtilManger {
	/**
	 * 构造相等条件
	 */
	public static <T> QueryWrapper<T> getEqQuery(Object object, HashMap<String,Object> fieldMap){
		if(fieldMap == null) {
			return null;
		}
		QueryWrapper<T> queryWrapper = new QueryWrapper<>();
		List<String> fieldNames = new ArrayList<String>(fieldMap.keySet());
		Map<String, Map<String, Annotation>> annotationMap = ReflexUtilManager.getFieldAnnotation(object, fieldNames);
		for(String fieldName:fieldNames) {
			Map<String, Annotation> annotationValueMap = annotationMap.get(fieldName);
			TableField tableField = (TableField) annotationValueMap.get("TableField");
			String tableFieldName= tableField.value();
			queryWrapper.eq(tableFieldName, fieldMap.get(fieldName));
		}
		return queryWrapper;		
	}

}
