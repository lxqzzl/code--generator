package ${cfg.packageName}.service.impl;

import java.util.Date;
import java.util.HashMap;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import ${cfg.packageName}.entity.${entity};
import ${cfg.packageName}.dao.${table.mapperName};
import ${cfg.packageName}.service.${table.serviceName};
import ${cfg.packageName}.manager.QueryUtilManger;
import ${cfg.packageName}.manager.ReflexUtilManager;
import ${cfg.packageName}.manager.StringUtilManager;

/**
 * @Description ${table.serviceImplName}服务实现类
 * @author ${cfg.author}
 * @since ${cfg.date}
 */
@Service
@Component("${table.serviceName}")
public class ${table.serviceImplName} implements ${table.serviceName} {
	/**
	 * 日志记录
	 */
	private Logger logger = LoggerFactory.getLogger(${table.serviceImplName}.class);
	/**
	 * 通过构造方法自动注入
	 */
	private ${table.mapperName} ${table.mapperName?uncap_first}; 
	@Autowired(required = false)
	public ${table.serviceImplName}(${table.mapperName} ${table.mapperName?uncap_first}) {
		this.${table.mapperName?uncap_first}=${table.mapperName?uncap_first};
	}  
	
    /**
     * 实现list${entity?replace("DO","")}ByOther()方法，用于根据特定条件值查询所有 ${entity}数据
     * @param HashMap<String,Object> fieldMap 查询条件字段
	 * @param String currentPage 请求页
	 * @param String pageSize 请求页大小
	 * @return List<${entity}> ${table.entityPath}s 返回的数据列表
     */
	@Override
	public List<${entity}> list${entity?replace("DO","")}ByOther(HashMap<String,Object> fieldMap, String currentPage, String pageSize) {
		logger.info("receive:[fieldMap:" + fieldMap + "--page:" + currentPage + "--limit:"+ pageSize + "];");
		//构造查询条件
		QueryWrapper<${entity}> queryWrapper = QueryUtilManger.getEqQuery(fieldMap);
		//存放返回的数据
		List<${entity}> ${table.entityPath}s = new ArrayList<${entity}>();
		//判断是否请求分页查询
		if (pageSize == null) {
			//若不是，查询数据全部返回
			${table.entityPath}s = this.${table.entityPath?replace("DO","")}Mapper.selectList(queryWrapper);
		} else {
			//若是，构造分页
			Page<${entity}> page = new Page<${entity}>(Integer.valueOf(currentPage), Integer.valueOf(pageSize));
			//再根据分页返回数据
			${table.entityPath}s = this.${table.entityPath?replace("DO","")}Mapper.selectPage(page, queryWrapper).getRecords();
		}
		logger.info("Intermediate variable:[queryWrapper:" + queryWrapper + "];");
		logger.info("return:" + ${table.entityPath}s);
		return ${table.entityPath}s;
	}
	
    /**
     * 实现get${entity?replace("DO","")}ById()方法，用于根据Id查询对应单条数据 
     * @param Long ${table.entityPath?replace("DO","")}Id 主键Id
	 * @return ${entity} ${table.entityPath} 查询到的数据
     */
	@Override
	public ${entity} get${entity?replace("DO","")}ById(Long ${table.entityPath?replace("DO","")}Id) {
	logger.info("receive:[${table.entityPath?replace("DO","")}Id:"+${table.entityPath?replace("DO","")}Id+"];");
	    //通过selectById()方法根据Id查询对应的数据
		${entity} ${table.entityPath}=this.${table.entityPath?replace("DO","")}Mapper.selectById(${table.entityPath?replace("DO","")}Id);		
		logger.info("return:" + ${table.entityPath});
		return ${table.entityPath};
	}
	
    /**
     * 实现get${entity?replace("DO","")}ByOther方法，用于根据其他信息查询对应单条数据 
     * @param HashMap<String,Object> fieldMap 查询条件字段
	 * @return ${entity} ${table.entityPath} 查询到的数据
     */
	@Override
	public ${entity} get${entity?replace("DO","")}ByOther(HashMap<String,Object> fieldMap) {
		logger.info("receive:[fieldMap:" + fieldMap + "];");
		//构造查询条件
		QueryWrapper<${entity}> queryWrapper = QueryUtilManger.getEqQuery(fieldMap);
		//使用selectOne()方法根据条件查询对应数据
		${entity} ${table.entityPath} = this.${table.entityPath?replace("DO","")}Mapper.selectOne(queryWrapper);
		logger.info("Intermediate variable:[queryWrapper:" + queryWrapper + "];");
		logger.info("return:" + ${table.entityPath});
		return ${table.entityPath};
	}
	
    /**
     *  实现insert${entity?replace("DO","")}()方法，用于插入一条数据
     * @param ${entity} ${table.entityPath} 需要插入的数据
	 * @return ${entity} ${table.entityPath} 插入的数据
     */
	@Override
	@Async
	public ${entity} insert${entity?replace("DO","")}(${entity} ${table.entityPath}) {
	    logger.info("receive:[${table.entityPath}:" + ${table.entityPath} + "];");
	    //设置当前时间为创建时间
	    ${table.entityPath}.setGmtCreate(new Date());
	    //设置最新一次修改时间
		${table.entityPath}.setGmtModified(new Date());
		//通过insert()方法插入数据			
	    this.${table.entityPath?replace("DO","")}Mapper.insert(${table.entityPath});
		logger.info("return:"+${table.entityPath});
		return ${table.entityPath};
	}
	
	/**
	 *  实现update${entity?replace("DO","")}()方法，用于更新${entity}数据
	 * @param ${entity} ${table.entityPath} 需要更新的数据（全部）
	 * @return ${entity} ${table.entityPath} 更新后的数据
	 */
	@Override
	@Async
	public ${entity} update${entity?replace("DO","")}(${entity} ${table.entityPath}) {	
		logger.info("receive:[${table.entityPath}:" + ${table.entityPath} + "];");
		//设置最新一次修改时间
	    ${table.entityPath}.setGmtModified(new Date());			    
		this.${table.entityPath?replace("DO","")}Mapper.updateById(${table.entityPath});
		logger.info("return:"+${table.entityPath});
		return ${table.entityPath};	
	}

	/**
	 *  实现update${entity?replace("DO","")}Field()方法，用于更新${entity}部分数据
	 * @param String data 需要修改的变量及对应值
	 * @param Long genId 需要修改的数据的主键Id
	 * @return ${entity} ${table.entityPath} 更新后的数据
	 */
	@Override
	@Async
	public ${entity} update${entity?replace("DO","")}Field(String data, Long ${table.entityPath?replace("DO","")}Id) {
		logger.info("receive:[data:" + data + "--${table.entityPath?replace("DO","")}Id:" + ${table.entityPath?replace("DO","")}Id + "];");
		//将data转化为JSONObject类型方便提取值
		JSONObject fieldJson = JSONObject.parseObject(data);
		//获取${entity}实体类的全部变量类型
		Map<String, Class<?>> fieldTypeMap = ReflexUtilManager.getFieldType(new ${entity}(), null);
		//根据Id获取原始数据
		${entity} ${table.entityPath} = this.${table.entityPath?replace("DO","")}Mapper.selectById(${table.entityPath?replace("DO","")}Id);
		//遍历要修改的变量名
		for(String key:fieldJson.keySet()) {
			//将变量名首字母大写后与"set"拼接，生成set方法名
			String methodName="set"+StringUtilManager.captureUp(key);
			try {
				//通过getMethod()方法获取${entity}对应的set方法
				//通过invoke执行该方法并将值回传给${table.entityPath}
				${table.entityPath} = (${entity}) new ${entity}().getClass().getMethod(
						methodName, (fieldTypeMap.get(key))).invoke(${table.entityPath}, fieldJson.get(key));
			} catch (Exception e) {
				//抛出异常
				e.printStackTrace();
				logger.info("error:"+e.getMessage());
			} 
		}
		this.${table.entityPath?replace("DO","")}Mapper.updateById(${table.entityPath});
		logger.info("Intermediate variable:[${table.entityPath}:" + ${table.entityPath}+ "--fieldTypeMap:"+fieldTypeMap+"];");
		logger.info("return:" + ${table.entityPath});
		return ${table.entityPath};	
	}	
	/**
	 *  实现delete${entity?replace("DO","")}ById()方法，用于删除对应Id的数据 
	 * @param Long ${table.entityPath?replace("DO","")}Id 需要删除的数据的主键Id
	 * @return boolean 是否成功
	 */
	@Override
	@Async
	public Boolean delete${entity?replace("DO","")}ById(Long ${table.entityPath?replace("DO","")}Id) {
		logger.info("receive:[${table.entityPath?replace("DO","")}Id:" + ${table.entityPath?replace("DO","")}Id + "];");
		//通过deleteById()删除对应数据
        int singleDelete = this.${table.entityPath?replace("DO","")}Mapper.deleteById(${table.entityPath?replace("DO","")}Id);	
        if(singleDelete == 1){
           	logger.info("return:true");
			//若删除成功，返回true			
			return true; 
        }     	    
		logger.info("return:false");
		return false;	
	}
}
