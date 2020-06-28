package ${packageName}.manager;

import lombok.Data;

/**
 * @Description 自定义响应数据结构            
 * @author ${author}
 * @since ${date}
 */
@Data
public class GlobalResult {
	/**
	 * 响应业务状态
	 */
    private Integer status;

	/**
	    * 响应消息
	 */
    private String msg;

	/**
	    * 响应中的数据
	 */ 
    private Object data;


}
