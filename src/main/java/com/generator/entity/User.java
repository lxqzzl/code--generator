package com.generator.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.gitee.sunchenbin.mybatis.actable.annotation.Column;
import com.gitee.sunchenbin.mybatis.actable.annotation.IsAutoIncrement;
import com.gitee.sunchenbin.mybatis.actable.annotation.IsKey;
import com.gitee.sunchenbin.mybatis.actable.annotation.Table;

import lombok.Data;

@Data
//对应数据库表名，如果更改表名需要同步更改数据库表名，不然会重新创建表
@Table(name = "t_user")
public class User{
    /**
              * 主键
     */
	//mybatis-plus主键注解 
    @TableId(type = IdType.AUTO) 
    //actable主键注解
    @IsKey 			
    //自增
    @IsAutoIncrement
    //对应数据库字段，不配置name会直接采用属性名作为字段名
    @Column 					 
    private Long UserId;
    /**
               * 创建时间
     */
    // name指定数据库字段名，comment为备注
    @Column(name = "gmt_create",comment = "创建时间") 
    private Date gmtCreate;
    /**
              * 最后修改时间
     */
    @Column(name = "gmt_modified",comment = "最后修改时间")
    private Date gmtModified;
}
