package ${cfg.packageName}.service;

import ${cfg.packageName}.entity.${entity};
import java.util.List;

/**
 * @Description 服务类接口
 * @author ${author}
 * @since ${date}
 */
public interface ${table.serviceName} {
	
	/**
	 * 根据其他信息查询数据
	 * @param fieldValue 查询条件值
	 * @param fieldName 查询条件值属性名
	 * @param page 页数
	 * @param limit 每页限制条数
     * @return Page<${entity}>
	 */
	List<${entity}> list${entity?replace("DO","")}ByOther(String fieldValue, String fieldName, String page, String limit);
	
	/**
	  * 根据Id查询数据
	 * @param ${table.entityPath?replace("DO","")}Id ${table.entityPath?replace("DO","")}Id
     * @return ${entity}
	 */
	${entity} get${entity?replace("DO","")}ById(Long ${table.entityPath?replace("DO","")}Id);
	
	/**
	   * 根据其他信息查询数据
	 * @param fieldValue 查询条件值
	 * @param fieldName 查询条件值属性名
     * @return ${entity}
	 */
	${entity} get${entity?replace("DO","")}ByOther(String fieldValue, String fieldName);
	
	/**
	 * 插入新的数据
	 * @param ${table.entityPath} ${entity}实体对象
     * @return String 
	 */
	${entity} insert${entity?replace("DO","")}(${entity} ${table.entityPath});
		
	/**
	 * 更新数据
	 * @param ${table.entityPath} ${entity}实体对象
     * @return String
	 */
	${entity} update${entity?replace("DO","")}(${entity} ${table.entityPath});
	
	/**
	 * 更新部分数据
	 * @param data 修改部分的信息
	 * @param ${table.entityPath?replace("DO","")}Id ${table.entityPath?replace("DO","")}Id
     * @return String
	 */
	${entity} update${entity?replace("DO","")}Field(String data, Long ${table.entityPath?replace("DO","")}Id);
	
	/**
	 * 根据Id删除数据
	 * @param ${table.entityPath?replace("DO","")}Id ${table.entityPath?replace("DO","")}Id
     * @return String
	 */
	Boolean delete${entity?replace("DO","")}ById(String ${table.entityPath?replace("DO","")}Id);	
}