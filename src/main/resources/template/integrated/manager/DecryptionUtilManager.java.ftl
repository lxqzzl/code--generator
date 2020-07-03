package ${packageName}.manager;

import org.apache.commons.codec.binary.Base64;

/**
 * @Description 解密工具类            
 * @author ${author}
 * @since ${date}
 */

public class DecryptionUtilManager {
	/**
	 * 基于commons-codec的BASE64解密
	 * @param encryptionKey BASE64加密后字符串
	 * @return decryptionKey 解密后的字符串
	 */
	public static String decryptionByBASE64(String encryptionKey) {
		if(encryptionKey == null) {
			return null;
		}
		byte[] decode = Base64.decodeBase64(encryptionKey);
		// 解密后的字符串
		String decryptionKey = new String(decode);
		return decryptionKey;
	}
}
