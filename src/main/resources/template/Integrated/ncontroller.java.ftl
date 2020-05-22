package ${cfg.packageName}.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;

import ${cfg.packageName}.service.${table.serviceName};
import ${cfg.packageName}.service.impl.${table.serviceName}Impl;
import ${cfg.packageName}.entity.${entity};

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import springfox.documentation.annotations.ApiIgnore;

/**
 * @Description ${table.controllerName}前端控制器
 * @author ${cfg.author}
 * @since ${cfg.date}
 */

@RestController
@RequestMapping("${r'${global.version}'}/${table.entityPath?replace("DO","")?lower_case}s")
@Api(tags = "${table.name}表操作API")	
public class ${table.controllerName} {
    private Logger logger = LoggerFactory.getLogger(${table.controllerName}.class);
    @Autowired
    @Qualifier("${table.serviceName}")
    private ${table.serviceName} ${table.serviceName?uncap_first} = new ${table.serviceName}Impl();	
	
	/**
	 * 获取满足某些条件的全部数据列表 
	 * @param fieldValue 查询条件值
	 * @param fieldName 查询条件值属性名
	 * @param page 页数
	 * @param limit 每页限制条数
	 * @return ${table.entityPath}实体类数据列表
	 */
	@GetMapping("/")
	@RequiresPermissions({ "${entity?replace("DO","")?lower_case}-r" })
	@ApiOperation(value = "获取满足某些条件的全部数据列", httpMethod = "GET", notes = "用于通过指定条件,查询${table.name}表对应所用数据")
	@ApiImplicitParams({ @ApiImplicitParam(name = "page", value = "请求页码", paramType = "query", dataType = "String"),
			@ApiImplicitParam(name = "limit", value = "每页数据条数", paramType = "query", dataType = "String"), 
			@ApiImplicitParam(name = "fieldValue", value = "查询条件值", paramType = "query", dataType = "String"),
			@ApiImplicitParam(name = "fieldName", value = "查询条件值属性名", paramType = "query", dataType = "String")})
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
			@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
			@ApiResponse(code = 555, message = "请求超时，请重试") })
	public List<${entity}> list${entity?replace("DO","")}ByOther(@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "limit", required = false) String limit,
			@RequestParam(value = "fieldValue", required = false) String fieldValue,
			@RequestParam(value = "fieldName", required = false) String fieldName) {
		logger.info("receive:[page:"+page+"--limit:"+limit+"--fieldValue:"+fieldValue+"--fieldName:"+fieldName+"]");
		List<${entity}> ${table.entityPath?replace("DO","")}s = ${table.serviceName?uncap_first}.list${entity?replace("DO","")}ByOther(fieldValue, fieldName, page, limit);
		return ${table.entityPath?replace("DO","")}s;
	}
	
    /**
     * 根据ID查找数据
     * @return ${table.entityPath}实体类数据
     */
	@GetMapping("/{${table.entityPath?replace("DO","")}Id}")
	@RequiresPermissions({"${entity?replace("DO","")?lower_case}-r" })
    @ApiOperation(value = "根据ID查找数据",httpMethod = "GET",notes = "用于通过${table.entityPath?replace("DO","")}Id，查询${table.name}表中对应的一条数据")
	@ApiImplicitParam(name = "${table.entityPath?replace("DO","")}Id", value = "${table.entityPath?replace("DO","")}Id", paramType = "path", dataType = "String")
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
		@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
		@ApiResponse(code = 555, message = "请求超时，请重试") })
	public ${entity} get${entity?replace("DO","")}ById(@ApiParam(value = "${table.entityPath?replace("DO","")}Id", required = true)@PathVariable("${table.entityPath?replace("DO","")}Id")String ${table.entityPath?replace("DO","")}Id) {	
		logger.info("receive:[${table.entityPath?replace("DO","")}Id:"+${table.entityPath?replace("DO","")}Id+"]");
		${entity} ${table.entityPath} = ${table.serviceName?uncap_first}.get${entity?replace("DO","")}ById(Long.valueOf(${table.entityPath?replace("DO","")}Id));		    
		return ${table.entityPath};		
	}
	
	/**
	 * 根据其他查找数据
	 * @param fieldValue 查询条件值
	 * @param fieldName 查询条件值属性名
	 * @return ${table.entityPath}实体类数据
	 */
	@GetMapping("/${table.entityPath?replace("DO","")?lower_case}")
	@RequiresPermissions({ "${entity?replace("DO","")?lower_case}-r" })
	@ApiIgnore
	@ApiOperation(value = "根据其他查找数据", httpMethod = "GET", notes = "用于通过指定字段，查询uuuec_user表中对应的一条数据")
	@ApiImplicitParams({
	@ApiImplicitParam(name = "fieldValue", value = "查询条件值", paramType = "query", dataType = "String"),
	@ApiImplicitParam(name = "fieldName", value = "查询条件值属性名", paramType = "query", dataType = "String")
	})
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
			@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
			@ApiResponse(code = 555, message = "请求超时，请重试") })
	public ${entity} get${entity?replace("DO","")}ByOther(@RequestParam(value = "fieldValue", required = false) String fieldValue
			,@RequestParam(value = "fieldName", required = false) String fieldName) {
		logger.info("receive:[fieldValue:"+fieldValue+"--fieldName:"+fieldName+"]");
		${entity} ${table.entityPath} = ${table.serviceName?uncap_first}.get${entity?replace("DO","")}ByOther(fieldValue,fieldName);
		return ${table.entityPath};
	}
	
    /**
     * 添加数据
     * @return ${table.entityPath}实体类数据
     */
	@PostMapping("/")
	@RequiresPermissions({ "${entity?replace("DO","")?lower_case}-r", "${entity?replace("DO","")?lower_case}-c"})
	@ApiOperation(value = "添加数据",httpMethod = "POST",notes = "用于在${table.name}表中插入对应的一条数据，为异步方法，结果会回调到异步地址中\n;"
			+ "${entity}实体类数据{\n"
			<#list table.fields as field> 
			<#if field.name?contains("spare")>
            <#else>
            <#if field.propertyType == "Date">
            <#else>
            <#if field_index == 0>
            <#else>
			+ "变量名：\"${field.propertyName}\",类型：${field.propertyType},注释：${field.comment}\n,"
	        </#if>
	        </#if>
	        </#if>
	        </#list>
	        + "}\n")
	@ApiImplicitParam(name = "data", value = "${table.entityPath}实体类数据", paramType = "body", dataType = "String")
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
		@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
		@ApiResponse(code = 555, message = "请求超时，请重试") })
	public ${entity} insert${entity?replace("DO","")}(@RequestBody(required=true)String data) {
		logger.info("receive:[data:"+data+"]");		
		${entity} ${table.entityPath}=JSONObject.parseObject(data, ${entity}.class);	 
		${table.serviceName?uncap_first}.insert${entity?replace("DO","")}(${table.entityPath});		
		return ${table.entityPath};		
	}

	
    /**
     * 更新数据
     * @param data ${table.entityPath}实体类数据
     * @return ${table.entityPath}实体类数据
     */
	@PutMapping("/{${table.entityPath?replace("DO","")}Id}")
	@RequiresPermissions({"${entity?replace("DO","")?lower_case}-r", "${entity?replace("DO","")?lower_case}-u"})
	@ApiOperation(value = "更新数据",httpMethod = "PUT",notes = "用于更新${table.name}表中对应的一条数据，为异步方法，结果会回调到异步地址中\n"
			+ "${entity}实体类数据{\n"
			<#list table.fields as field> 
			<#if field.name?contains("spare")>
            <#else>
            <#if field.propertyType == "Date">
            <#else>
            <#if field_index == 0>
            <#else>
			+ "变量名：\"${field.propertyName}\",类型：${field.propertyType},注释：${field.comment}\n,"
	        </#if>
	        </#if>
	        </#if>
	        </#list>
	        + "}\n")
	@ApiImplicitParams({
	@ApiImplicitParam(name = "${table.entityPath?replace("DO","")}Id", value = "${table.entityPath?replace("DO","")}Id", paramType = "path", dataType = "String"),
	@ApiImplicitParam(name = "data", value = "${table.entityPath}实体类数据", paramType = "body", dataType = "String")
	})
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
		@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
		@ApiResponse(code = 555, message = "请求超时，请重试") })
	public ${entity} update${entity}(@RequestBody(required=true)String data) {
		logger.info("receive:[data:"+data+"]");
		${entity} ${table.entityPath}=JSONObject.parseObject(data, ${entity}.class);	    
		${table.entityPath} = ${table.serviceName?uncap_first}.update${entity?replace("DO","")}(${table.entityPath});		
        return ${table.entityPath};
     }

    /**
     * 更新部分数据
     * @param ${table.entityPath?replace("DO","")}Id ${table.entityPath?replace("DO","")}Id
     * @param data ${table.entityPath}部分信息
     * @return GetResult<Boolean>(suatus:状态码,msg:消息,data:处理结果)
     */
	@PatchMapping("/{${table.entityPath?replace("DO","")}Id}")
	@RequiresPermissions({ "${entity?replace("DO","")?lower_case}-r", "${entity?replace("DO","")?lower_case}-u"})
	@ApiOperation(value = "更新部分数据",httpMethod = "PATCH",notes = "用于更新${table.name}表中对应的一条数据，为异步方法，结果会回调到异步地址中")
	@ApiImplicitParams({
	@ApiImplicitParam(name = "${table.entityPath?replace("DO","")}Id", value = "${table.entityPath?replace("DO","")}Id", paramType = "path", dataType = "String"),
	@ApiImplicitParam(name = "data", value = "${table.entityPath}实体类数据", paramType = "body", dataType = "String")
	})
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
		@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
		@ApiResponse(code = 555, message = "请求超时，请重试") })
	public ${entity} update${entity?replace("DO","")}ForField(@ApiParam(value = "${table.entityPath?replace("DO","")}Id", required = true)@PathVariable("${table.entityPath?replace("DO","")}Id")String ${table.entityPath?replace("DO","")}Id,
			@RequestBody(required=false) String data) {
		logger.info("receive:[${table.entityPath?replace("DO","")}Id:"+${table.entityPath?replace("DO","")}Id+"--data:"+data+"]");		    					
		${entity} ${table.entityPath} = ${table.serviceName?uncap_first}.update${entity?replace("DO","")}Field(data, Long.valueOf(${table.entityPath?replace("DO","")}Id));
        ${table.entityPath}.set${entity?replace("DO","")}Id(Long.valueOf(${table.entityPath?replace("DO","")}Id));
        return ${table.entityPath};
     }
	
    /**
     * 根据Id删除数据
     * @param ${table.entityPath}Id ${table.entityPath}Id
     * @return GetResult<Boolean>(suatus:状态码,msg:消息,data:处理结果)
     */
	@DeleteMapping("/{${table.entityPath?replace("DO","")}Id}")
	@RequiresPermissions({"${entity?replace("DO","")?lower_case}-r", "${entity?replace("DO","")?lower_case}-d"})
	@ApiOperation(value = "根据Id删除数据",httpMethod = "DELETE",notes = "用于通过${table.entityPath}Id，删除${table.name}表中对应的一条数据，为异步方法，结果会回调到异步地址中")
	@ApiImplicitParam(name = "${table.entityPath?replace("DO","")}Id", value = "${table.entityPath?replace("DO","")}Id", paramType = "path", dataType = "String")
	@ApiResponses({ @ApiResponse(code = 551, message = "第三方平台错误"), @ApiResponse(code = 552, message = "本平台错误"),
		@ApiResponse(code = 553, message = "权限不够"), @ApiResponse(code = 554, message = "请求数据有误"),
		@ApiResponse(code = 555, message = "请求超时，请重试") })
	public Boolean delete${entity}ById(@ApiParam(value = "${table.entityPath?replace("DO","")}IdListString", required = true)@PathVariable("${table.entityPath?replace("DO","")}Id")String ${table.entityPath?replace("DO","")}Id) {		
		Boolean flag = null;
		logger.info("receive:[${table.entityPath?replace("DO","")}Id:"+${table.entityPath?replace("DO","")}Id+"]");
		flag = ${table.serviceName?uncap_first}.delete${entity?replace("DO","")}ById(${table.entityPath?replace("DO","")}Id);
		return flag;		
	}	
}