package codesquad.secondhand.exception.code;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum MemberCode implements Code{

    AUTHENTICATION_INVALID_USER(false, 401, -40104, "이용할 수 없는 사용자입니다."),
    REQUIRED_SIGNUP(false, 403, -40301, "추가 회원가입이 필요한 사용자입니다.");

    private final boolean success;
    private final int status;
    private final int code;
    private final String message;

}
