package ${cfg.packageName}.service.impl;

import java.util.Date;

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
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;

import ${cfg.packageName}.entity.${entity};
import ${cfg.packageName}.dao.${table.mapperName};
import ${cfg.packageName}.service.${table.serviceName};
import ${cfg.packageName}.manager.GetEntity;

/**
 * @Description ${table.serviceImplName}服务实现类
 * @author ${cfg.author}
 * @since ${cfg.date}
 */
@Service
@Component("${table.serviceName}")
public class ${table.serviceImplName} implements ${table.serviceName} {
	private Logger logger = LoggerFactory.getLogger(${table.serviceImplName}.class);
	
	@Autowired(required = false)
	private ${table.mapperName} ${table.mapperName?uncap_first};   
	private GetEntity getEntity = new GetEntity();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
    /**
     * 实现list${entity?replace("DO","")}ByOther()方法
     * 用于根据特定条件值查询所有 ${entity}数据
     */
	@Override
	public List<${entity}> list${entity?replace("DO","")}ByOther(String fieldValue, String fieldName, String page, String limit) {
	    List<${entity}> ${table.entityPath}s = new ArrayList<${entity}>();
	    Field[] fields = new ${entity}().getClass().getDeclaredFields();
		String annotationValue = null;
		if(fieldName != null) {
		    annotationValue = getEntity.getAnnotationValue(fields, fieldName);
		    if(limit == null) {
		        ${table.entityPath}s = this.${table.mapperName?uncap_first}.selectList(new QueryWrapper<${entity}>()
					.eq(annotationValue, fieldValue));
			} else {
			    Page<${entity}> lpage = new Page<${entity}>(Integer.valueOf(page),Integer.valueOf(limit));
	            ${table.entityPath}s = this.${table.entityPath?replace("DO","")}Mapper.selectPage(lpage,new QueryWrapper<${entity}>()
					.eq(annotationValue, fieldValue)).getRecords();
			}
		}else {
		    if(limit == null) {
		        ${table.entityPath}s = this.${table.mapperName?uncap_first}.selectList(null);
			} else {
			    Page<${entity}> lpage = new Page<${entity}>(Integer.valueOf(page),Integer.valueOf(limit));
	            ${table.entityPath}s = this.${table.entityPath?replace("DO","")}Mapper.selectPage(lpage,null).getRecords();
			}
		}
        logger.info("receive:[fieldValue:"+fieldValue+"--fieldName:"+fieldName+"--page:"+page+"--limit:"+limit+"];Intermediate variable:[--annotationValue:"+annotationValue+"];--return:"+${table.entityPath}s);
        return ${table.entityPath}s;
	}
	
	    /**
     * 实现get${entity?replace("DO","")}ById()方法
     * 用于根据Id查询对应单条数据 
     */
	@Override
	public ${entity} get${entity?replace("DO","")}ById(Long ${table.entityPath?replace("DO","")}Id) {
		${entity} ${table.entityPath}=this.${table.entityPath?replace("DO","")}Mapper.selectById(${table.entityPath?replace("DO","")}Id);
		logger.info("receive:[${table.entityPath?replace("DO","")}Id:"+${table.entityPath?replace("DO","")}Id+"];--return:"+${table.entityPath});
		return ${table.entityPath};
	}
	
    /**
     * 实现get${entity?replace("DO","")}ByOther方法
     * 用于根据其他信息查询对应单条数据 
     */
	@Override
	public ${entity} get${entity?replace("DO","")}ByOther(String fieldValue, String fieldName) {
		Field[] fields = new ${entity}().getClass().getDeclaredFields();		
		try{
		    String annotationValue = getEntity.getAnnotationValue(fields, fieldName);
		    ${entity} ${table.entityPath} = this.${table.entityPath?replace("DO","")}Mapper.selectOne(new QueryWrapper<${entity}>()
				    .eq(annotationValue, fieldValue));
		    logger.info("receive:[fieldValue:"+fieldValue+"--fieldName:"+fieldName+"];Intermediate variable:[--annotationValue:"+annotationValue+"];--return:"+${table.entityPath});
		    return ${table.entityPath};
		} catch (Exception e) {
		   return null;
		}
	}
	
    /**
     *  实现insert${entity?replace("DO","")}()方法
     *  用于插入一条数据
     */
	@Override
	@Async
	public ${entity} insert${entity?replace("DO","")}(${entity} ${table.entityPath}) {
	    ${table.entityPath}.setGmtCreate(new Date());
		${table.entityPath}.setGmtModified(new Date());			
	    this.${table.entityPath?replace("DO","")}Mapper.insert(${table.entityPath});
		logger.info("receive:[${table.entityPath}:"+${table.entityPath}+"];--return:"+${table.entityPath});
		return ${table.entityPath};
	}
	
	/**
	 *  实现update${entity?replace("DO","")}()方法
	 *  用于更新${entity}数据
	 */
	@Override
	@Async
	public ${entity} update${entity?replace("DO","")}(${entity} ${table.entityPath}) {	
	    ${table.entityPath}.setGmtModified(new Date());			    
		this.${table.entityPath?replace("DO","")}Mapper.updateById(${table.entityPath});
		logger.info("receive:[${table.entityPath}:"+${table.entityPath}+"];--return:"+${table.entityPath});
		return ${table.entityPath};	
	}

	/**
	 *  实现update${entity?replace("DO","")}Field()方法
	 *  用于更新${entity}部分数据
	 */
	@Override
	@Async
	public ${entity} update${entity?replace("DO","")}Field(String data, Long ${table.entityPath?replace("DO","")}Id) {
		Field[] fields = new ${entity}().getClass().getDeclaredFields();				
		${entity} ${table.entityPath} = (${entity}) getEntity.setTableField(
				data, ${entity}.class, fields, this.${table.entityPath?replace("DO","")}Mapper.selectById(${table.entityPath?replace("DO","")}Id));		
		${table.entityPath}.setGmtModified(new Date());		    
		this.${table.entityPath?replace("DO","")}Mapper.updateById(${table.entityPath});
		logger.info("receive:[data:"+data+"--${table.entityPath?replace("DO","")}Id:"+${table.entityPath?replace("DO","")}Id+"];Intermediate variable:[--${table.entityPath}:"+${table.entityPath}+"];--return:"+${table.entityPath});
		return ${table.entityPath};	
	}	
	/**
	 *  实现delete${entity?replace("DO","")}ById()方法
	 *  用于删除对应Id的数据 
	 */
	@Override
	@Async
	public Boolean delete${entity?replace("DO","")}ById(String ${table.entityPath?replace("DO","")}Id) {
		Boolean flag = false;
        int singleDelete = this.${table.entityPath?replace("DO","")}Mapper.deleteById(${table.entityPath?replace("DO","")}Id);	
        if(singleDelete == 1){
           flag = true; 
        }     	    
        logger.info("receive:[${table.entityPath?replace("DO","")}Id:"+${table.entityPath?replace("DO","")}Id+"];Intermediate variable:[--singleDelete:"+singleDelete+"];--return:"+flag);
		return flag;	
	}
}
