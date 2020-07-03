package ${packageName}.manager;

import org.apache.commons.codec.binary.Base64;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

/**
 * @Description 加密工具类            
 * @author ${author}
 * @since ${date}
 */

public class EncryptionUtilManager {
	/**
	   * 基于shiro的MD5加密
	 * @param saltSource 盐值源
	 * @param key 明文
	 * @return 密文
	 */
	public static String encryptionByMD5(String saltSource, String key) {
		// 盐为用户名得到，可以自己添加其他值
		ByteSource salt = ByteSource.Util.bytes(saltSource);
		// 参数依次为（加密方式，明文密码，盐，散列次数）
		SimpleHash simpleHash1 = new SimpleHash("MD5", key, salt, 2);
		return simpleHash1.toString();
	}
	
	/**
	  * 基于commons-codec的BASE64加密
	 * @param key 明文字符串
	 * @return encryptionKey 加密后的字符串
	 */
	public static String encryptionByBASE64(String key) {
		if(key == null) {
			return null;
		}
		//将明文转为字符数组
		byte[] encode = Base64.encodeBase64(key.getBytes());
		// 加密后的字符串
		String encryptionKey = new String(encode);
		return encryptionKey;
	}

}
