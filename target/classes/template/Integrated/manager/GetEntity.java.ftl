package ${packageName}.manager;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.Set;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.annotation.TableField;

/**
 * @Description 反射获取实体类TableField标签名
 * @author ${author}
 * @since ${date}
 */

public class GetEntity {

	public String getAnnotationValue(Field[] fields, String fieldName) {
		String annotationValue = null;
		for (int i = 0; i < fields.length; i++) {
			String name = fields[i].getName();
			if(fieldName.equals(name)) {
				annotationValue=fields[i].getAnnotation(TableField.class).value();
			}
		}
		return annotationValue;
	}

	public Object setTableField(String data, Class<?> clazz, Field[] fields, Object obj) {	
		JSONObject fieldJson = JSONObject.parseObject(data);
		Set<String> keyList = fieldJson.keySet();
		Iterator<String> it = keyList.iterator();
		while (it.hasNext()) {
			String fieldName = it.next();
			char[] cs = fieldName.toCharArray();
			cs[0] -= 32;
			String fieldMethodName = String.valueOf(cs);
			String methodName = "set" + fieldMethodName;
			Class<?> typeClass = null;
			for (int i = 0; i < fields.length; i++) {
				if(fieldName.equals(fields[i].getName())) {					
					typeClass = (Class<?>) fields[i].getGenericType();
				}
			}			
			try {
				Method method = clazz.getDeclaredMethod(methodName, new Class[] { typeClass });
				method.invoke(obj, new Object[] { getClassTypeValue(typeClass, fieldJson.get(fieldName)) });
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return obj;
	}

	private Object getClassTypeValue(Class<?> typeClass, Object value) {
		if (typeClass == int.class || value instanceof Integer) {
			if (null == value) {
				return 0;
			}
			return value;
		} else if (typeClass == short.class) {
			if (null == value) {
				return 0;
			}
			return value;
		} else if (typeClass == byte.class) {
			if (null == value) {
				return 0;
			}
			return value;
		} else if (typeClass == double.class) {
			if (null == value) {
				return 0;
			}
			return value;
		} else if (typeClass == long.class) {
			if (null == value) {
				return 0;
			}
			return value;
		} else if (typeClass == String.class) {
			if (null == value) {
				return "";
			}
			return value;
		} else if (typeClass == boolean.class) {
			if (null == value) {
				return true;
			}
			return value;
		} else if (typeClass == BigDecimal.class) {
			if (null == value) {
				return new BigDecimal(0);
			}
			return new BigDecimal(value + "");
		} else {
			return typeClass.cast(value);
		}
	}

}
