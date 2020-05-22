package ${packageName}.web;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.apache.commons.codec.binary.Base64;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/*
 * Jwt的生成与解密
 **/
public class JwtUtil {
    //创建默认的秘钥和算法，供无参的构造方法使用
    private static final String defaultbase64EncodedSecretKey = "admin";
    private static final SignatureAlgorithm defaultsignatureAlgorithm = SignatureAlgorithm.HS256;

    public JwtUtil() {
        this(defaultbase64EncodedSecretKey, defaultsignatureAlgorithm);
    }

    private final String base64EncodedSecretKey;
    private final SignatureAlgorithm signatureAlgorithm;

    public JwtUtil(String secretKey, SignatureAlgorithm signatureAlgorithm) {
        this.base64EncodedSecretKey = Base64.encodeBase64String(secretKey.getBytes());
        this.signatureAlgorithm = signatureAlgorithm;
    }

    /*
     * jwt字符串生成
     * */
    public String encode(String iss, long ttlMillis, Map<String, Object> claims) {
        if (claims == null) {
            claims = new HashMap<>();
        }
        long nowMillis = System.currentTimeMillis();

        JwtBuilder builder = Jwts.builder()
                .setClaims(claims)
                //这个是JWT的唯一标识，一般设置成唯一的，这个方法可以生成唯一标识
                .setId(UUID.randomUUID().toString())
                //这个地方就是以毫秒为单位，换算当前系统时间生成的iat
                .setIssuedAt(new Date(nowMillis))
                //签发人，也就是JWT是给谁的（逻辑上一般都是username或者userId）
                .setSubject(iss)
                //这个地方是生成jwt使用的算法和秘钥
                .signWith(signatureAlgorithm, base64EncodedSecretKey);
        if (ttlMillis >= 0) {
            long expMillis = nowMillis + ttlMillis;
            //过期时间，这个也是使用毫秒生成的，使用当前时间+前面传入的持续时间生成
            Date exp = new Date(expMillis);
            builder.setExpiration(exp);
        }
        return builder.compact();
    }

    /*
     * jwt字符串解密，拿到claim中的键值对
     * */
    public Claims decode(String jwtToken) {
        // 得到 DefaultJwtParser
        return Jwts.parser()
                // 设置签名的秘钥
                .setSigningKey(base64EncodedSecretKey)
                // 设置需要解析的 jwt
                .parseClaimsJws(jwtToken)
                .getBody();
    }
    
    /**
     *JWT中获得token中的信息无需secret解密也能获得
     * @return token中包含的用户名
     */
    public String getUsername(String jwtToken){
        DecodedJWT jwt = JWT.decode(jwtToken);
        return jwt.getClaim("username").asString();
    }

    //判断jwtToken是否合法
    public boolean isVerify(String jwtToken) {
        //这个是官方的校验规则，这里只写了一个”校验算法“，可以自己加
        Algorithm algorithm = null;
        switch (signatureAlgorithm) {
            case HS256:
                algorithm = Algorithm.HMAC256(Base64.decodeBase64(base64EncodedSecretKey));
                break;
            default:
                throw new RuntimeException("不支持该算法");
        }
        JWTVerifier verifier = JWT.require(algorithm).build();
        // 校验不通过会抛出异常
        verifier.verify(jwtToken);  
        //判断合法的标准：1. 头部和荷载部分没有篡改过。2. 没有过期
        return true;
    }
}
