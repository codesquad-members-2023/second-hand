package com.secondhand.user.login;

import com.secondhand.user.entity.User;
import com.secondhand.user.login.dto.GithubToken;
import com.secondhand.user.login.dto.LoggedInUser;
import com.secondhand.user.login.dto.UserProfileResponse;
import com.secondhand.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class LoginService {

    private final UserRepository userRepository;

    @Value("${OAUTH_GITHUB_URL}")
    private String url;

    @Value("${OAUTH_GITHUB_CLIENT_ID}")
    private String clientId;

    @Value("${OAUTH_GITHUB_CLIENT_SECRET}")
    private String clientSecret;
    @Value("${OAUTH_REDIRECT_URL}")
    private String redirectUrl;

    public GithubToken getAccessToken(String code) {

        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        Map<String, String> header = new HashMap<>();
        header.put("Accept", "application/json"); //json 형식으로 응답 받음
        headers.setAll(header);

        MultiValueMap<String, String> requestPayloads = new LinkedMultiValueMap<>();
        Map<String, String> requestPayload = new HashMap<>();
        requestPayload.put("client_id", clientId);
        requestPayload.put("client_secret", clientSecret);
        requestPayload.put("code", code);
        requestPayloads.setAll(requestPayload);

        HttpEntity<?> request = new HttpEntity<>(requestPayloads, headers);
        ResponseEntity<?> response = new RestTemplate().postForEntity(url, request, GithubToken.class); //미리 정의해둔 GithubToken 클래스 형태로 Response Body를 파싱해서 담아서 리턴

        return (GithubToken) response.getBody();
    }

    public UserProfileResponse getUserProfile(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<?> requestEntity = new HttpEntity<>(headers);

        return new RestTemplate().exchange(
                        "https://api.github.com/user",
                        HttpMethod.GET,
                        requestEntity,
                        UserProfileResponse.class)
                .getBody();
    }

    @Transactional
    public LoggedInUser createUser(UserProfileResponse userProfile) {

        Optional<User> signedUser = userRepository.findByGithubId(userProfile.getId());

        if (signedUser.isPresent()) {
            return new LoggedInUser(signedUser.get());
        }

        return new LoggedInUser(userRepository.save(new User(userProfile)));
    }
}
