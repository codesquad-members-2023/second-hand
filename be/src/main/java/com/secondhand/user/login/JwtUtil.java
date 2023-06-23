package com.secondhand.user.login;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.secondhand.user.login.dto.LoggedInUser;
import io.jsonwebtoken.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.util.Base64;
import java.util.Date;
import java.util.LinkedHashMap;

@Slf4j
@Component
public class JwtUtil {

    @Value("${JWT_SECRET_KEY}")
    private String secret; // 시크릿 키를 설정

    public String createToken(LoggedInUser loggedInUser, Date expiredDate) {

        return Jwts.builder()
                .setHeaderParam("typ", "JWT")
                .setSubject("login_member")
                .claim("userProfile", loggedInUser)
                .setExpiration(expiredDate)
                .signWith(SignatureAlgorithm.HS256, secret)
                .compact();
    }

    public boolean validateTokenIsExpired(String token) {

        try {
            Jws<Claims> claimsJws = Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token);

            if (claimsJws.getBody().getExpiration().before(new Date())) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean validateTokenIsManipulated(String token) {

        try {

            byte[] decodedSecretKey = Base64.getDecoder().decode(secret);
            Key key = new SecretKeySpec(decodedSecretKey, 0, decodedSecretKey.length, "HmacSHA256");

            Jwts.parser()
                    .setSigningKey(key) // 비밀 키를 사용하여 서명을 검증
                    .parseClaimsJws(token);

            return true;
        } catch (JwtException e) {
            log.info(e.getMessage() + " 토근 검증 실패");
            return false;
        }
    }

    public LoggedInUser extractedUserFromToken(String token) {

        String[] jwtParts = token.split("\\.");
        String encodedPayload = jwtParts[1]; // 페이로드는 두 번째 부분

        byte[] decodedBytes = Base64.getUrlDecoder().decode(encodedPayload);
        String decodedPayload = new String(decodedBytes);

        ObjectMapper objectMapper = new ObjectMapper();

        return parseUserFromJwt(decodedPayload, objectMapper);
    }

    private LoggedInUser parseUserFromJwt(String decodedPayload, ObjectMapper objectMapper) {

        LoggedInUser loggedInUser = new LoggedInUser();

        try {

            LinkedHashMap<String, Object> payloadMap = objectMapper.readValue(decodedPayload, LinkedHashMap.class);

            Object userProfile = payloadMap.get("userProfile");
            String userProfileJson = objectMapper.writeValueAsString(userProfile);// JSON 문자열로 변환 (로그인 유저 정보)

            loggedInUser = objectMapper.readValue(userProfileJson, LoggedInUser.class);
        } catch (JsonProcessingException e) {
           log.info("json 파싱 실패");
        }
        return loggedInUser;
    }
}
