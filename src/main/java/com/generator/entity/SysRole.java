package com.generator.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.gitee.sunchenbin.mybatis.actable.annotation.Column;
import com.gitee.sunchenbin.mybatis.actable.annotation.IsAutoIncrement;
import com.gitee.sunchenbin.mybatis.actable.annotation.IsKey;
import com.gitee.sunchenbin.mybatis.actable.annotation.Table;

import lombok.Data;

/**
 * @Description sys_role表字段
 * @author lxq
 * @since 2020-07-02 18:16:46
 */
@Data
//对应数据库表名，如果更改表名需要同步更改数据库表名，不然会重新创建表
@Table(name = "sys_role")
public class SysRole {
	/**
	 * 角色表主键id
	 */
	// mybatis-plus主键注解
	@TableId(type = IdType.AUTO)
	// actable主键注解
	@IsKey
	// 自增
	@IsAutoIncrement
	// 对应数据库字段，不配置name会直接采用属性名作为字段名
	@Column(name = "role_Id", comment = "角色表主键id", type = "bigint")
	private Long RoleId;
	/**
	 * 创建时间，格式为YY-MM-DD hh:mm:ss
	 */
	// name指定数据库字段名，comment为备注
	@Column(name = "gmt_create", comment = "创建时间，格式为YY-MM-DD hh:mm:ss", type = "datetime")
	private Date gmtCreate;
	/**
	 * 最后修改时间，格式为YY-MM-DD hh:mm:ss
	 */
	@Column(name = "gmt_modified", comment = "最后修改时间，格式为YY-MM-DD hh:mm:ss", type = "datetime")
	private Date gmtModified;
	/**
	 * 角色名称
	 */
	@Column(name = "role_name", comment = "角色名称", type = "varchar")
	private String roleName;	
	/**
	 * 备注
	 */
	@Column(name = "remark", comment = "备注", type = "varchar")
	private String remark;
	/**
	 * 预留字段
	 */
	@Column(name = "spare", comment = "预留字段", type = "varchar")
	private String spare;
}
