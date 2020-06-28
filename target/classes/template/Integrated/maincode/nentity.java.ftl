<#assign x = 0>
package ${cfg.packageName}.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;

<#list table.fields as field>
<#if field.propertyType == "BigDecimal">
<#assign x = x+1>
</#if>
</#list>
<#if x gt 0>
import java.math.BigDecimal; 
</#if>
import java.io.Serializable;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * @Description ${entity}实体类
 * @author ${cfg.author}
 * @since ${cfg.date}
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("${table.name}")
@ApiModel(value="${entity}对象model", description="${entity}原始数据类型，与表中字段一一对应")
public class ${entity} implements Serializable {

    private static final long serialVersionUID = 1L;
    
    <#-- 循环遍历字段 -->
    <#list table.fields as field>
    <#if field.name?contains("spare")>
    <#else>   
    /**
     *  ${field.comment}
     */
    @ApiModelProperty(value = "${field.comment}")
    </#if>
    <#-- 判断是否为主键 -->
    <#if field_index == 0>
    @TableId(value = "${field.name}", type = IdType.AUTO)
    <#else>
    <#if field.name?contains("spare")>
    <#else> 
    @TableField("${field.name}")
    </#if>
    </#if>
    <#if field.propertyType == "Date">
    @JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
    private ${field.propertyType} ${field.propertyName};
    <#else>
    <#if field.propertyType=="Boolean">
    private ${field.propertyType} ${field.propertyName?replace("Is","")};
    <#else>
    <#if field.name?contains("spare")>
    <#else>
    private ${field.propertyType} ${field.propertyName};
    </#if>
    </#if>
    </#if>
    </#list>    

    
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "${entity}{" +
        <#list table.fields as field> 
        <#if field_index == 0>
         "${field.propertyName}=" + ${field.propertyName}
        <#else>
        <#if field.propertyName?contains("Is")>
         +", ${field.propertyName}=" + ${field.propertyName?replace("Is","")}
        <#else>
        <#if field.name?contains("spare")> 
        <#else>
         +", ${field.propertyName}=" + ${field.propertyName} 
        </#if> 
        </#if>
        </#if>
        </#list>
        +"}";
    }
}
