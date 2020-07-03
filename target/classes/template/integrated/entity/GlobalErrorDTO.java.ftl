package ${packageName}.entity;

import lombok.Data;

/**
 * @Description 全局错误返回数据结构            
 * @author lxq
 * @since Fri Jul 03 11:03:41 CST 2020
 */
@Data
public class GlobalErrorDTO {
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
    public GlobalErrorDTO(Integer status, String msg, Object data) {
		this.status=status;
		this.msg=msg;
		this.data=data;
	}
}
