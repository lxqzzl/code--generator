package ${packageName}.manager;

import java.io.Serializable;
import java.util.List;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("列表对象")
public class ListResult<T> implements Serializable {
	
	private static final long serialVersionUID = 1L;

	// 响应业务状态
    @ApiModelProperty(value = "返回码",dataType = "int")
    private Integer status;

    // 响应消息
    @ApiModelProperty(value = "信息",dataType = "String")
    private String msg;
    
    @ApiModelProperty(value = "返回列表数据信息")
    private List<T> data;
}