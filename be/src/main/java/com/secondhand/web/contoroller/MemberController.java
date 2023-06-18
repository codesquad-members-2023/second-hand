package com.secondhand.web.contoroller;

import com.secondhand.domain.member.MemberService;
import com.secondhand.domain.town.TownService;
import com.secondhand.util.Message;
import com.secondhand.web.dto.resp.MemberLoginResponseDTO;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final TownService townService;
    private final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Operation(
            summary = "깃허브 로그인",
            tags = "member",
            description = "사용자 깃허브를 통한 로그인"
    )
    @GetMapping("/auth/login")
    public ResponseEntity<Message<MemberLoginResponseDTO>> login(@RequestParam String code) throws IOException, InterruptedException {
        logger.debug("프론트로 부터 받은 코드 = {}", code);
        MemberLoginResponseDTO memberResponseDTO = memberService.login(code);

        Message message = Message.builder()
                .success(true)
                .message("")
                .apiStatus(20000)
                .httpStatus(HttpStatus.OK)
                .data(memberResponseDTO)
                .build();

        return ResponseEntity.ok(message);
    }

    @Operation(
            summary = "로그아웃",
            tags = "member",
            description = "사용자 로그아웃."
    )
    @GetMapping("/auth/logout")
    public ResponseEntity<Message<MemberLoginResponseDTO>> logout() {

        Message message = Message.builder()
                .success(true)
                .message("")
                .apiStatus(20000)
                .httpStatus(HttpStatus.OK)
                .build();

        return ResponseEntity.ok(message);
    }
}
