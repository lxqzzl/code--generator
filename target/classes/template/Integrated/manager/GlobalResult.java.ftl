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

    /**
              * 构造错误返回信息
     * @param status
     * @param msg
     * @param data
     */
    public GlobalResult(Integer status, String msg, Object data) {
		this.status=status;
		this.msg=msg;
		this.data=data;
	}
}
