package ${packageName}.manager;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description 反射工具类
 * @author ${author}
 * @since ${date}
 */
public class ReflexUtilManager {
	/**
	 * 获取对应变量的全部注解
	 */
	public static Map<String, Map<String, Annotation>> getFieldAnnotation(Object object, List<String> fieldNames) {
		// annotationMap用于存放变量名与注解（若指定变量名，则存放注解名与对应类）返回
		Map<String, Map<String, Annotation>> annotationMap = new HashMap<String, Map<String, Annotation>>();
		// 获取所有字段并转为List类型
		// object.getClass().getDeclaredFields()：获取所有字段
		List<Field> fields = Arrays.asList(object.getClass().getDeclaredFields());
		if (fieldNames != null) {
			try {
				// 初始化fields
				fields = new ArrayList<Field>();
				// 遍历字段
				for (String fieldName : fieldNames) {
					// 将指定的字段存放进fields中
					// object.getClass().getDeclaredField(fieldName)：获取指定的字段名
					fields.add(object.getClass().getDeclaredField(fieldName));
				}
			} catch (Exception e) {
				// 捕捉异常
				e.printStackTrace();
			}
		}
		for (Field field : fields) {
			Map<String, Annotation> annotationValueMap = new HashMap<String, Annotation>();
			// 遍历所有注解
			for (Annotation annotation : field.getAnnotations()) {
				// 通过Annotation中的annotationType()方法获取注解类型并转为简单名称，annotation为注解的对应类，存放到annotationValueMap中
				annotationValueMap.put(annotation.annotationType().getSimpleName(), annotation);
			}
			// 将变量名与annotationValueMap关联绑定
			annotationMap.put(field.getName(), annotationValueMap);
		}
		return annotationMap;
	}

	/**
	 * 获取全部变量名称
	 */
	public static List<String> getFieldName(Object object) {
		List<String> fieldNames = new ArrayList<String>();
		// 遍历字段
		// object.getClass().getDeclaredFields()：获取所有字段
		for (Field field : object.getClass().getDeclaredFields()) {
			// 将字段名添加到fieldNames中
			fieldNames.add(field.getName());
		}
		return fieldNames;
	}

	/**
	 * 获取变量类型
	 */
	public static Map<String, Class<?>> getFieldType(Object object, List<String> fieldNames) {
		// typeMap用于存放变量名与注解（若指定变量名，则存放注解名与对应类）返回
		Map<String, Class<?>> typeMap = new HashMap<String, Class<?>>();
		// 获取所有字段并转为List类型
		List<Field> fields = Arrays.asList(object.getClass().getDeclaredFields());
		if (fieldNames != null) {
			try {
				// 初始化fields
				fields = new ArrayList<Field>();
				for (String fieldName : fieldNames) {
					fields.add(object.getClass().getDeclaredField(fieldName));
				}
			} catch (Exception e) {
				// 捕捉异常
				e.printStackTrace();
			}
		}
		// object.getClass().getDeclaredFields()：获取所有字段
		for (Field field : fields) {
			// 获取字段的名称和类型，存放在typeMap中
			typeMap.put(field.getName(), field.getType());
		}
		return typeMap;
	}

	/**
	 * 获取方法
	 */
	public static List<Method> getFieldMothed(Object object, String methodKeyWord) {
		// 获取所有字段并转为List类型
		if (methodKeyWord == null) {
			return Arrays.asList(object.getClass().getMethods());
		}
		List<Method> methods = new ArrayList<Method>();
		for (Method method : Arrays.asList(object.getClass().getMethods())) {
			if (method.getName().contains(methodKeyWord)) {
				methods.add(method);
			}
		}
		return methods;
	}

}
