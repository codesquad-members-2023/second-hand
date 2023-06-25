package com.secondhand.web.contoroller;

import com.secondhand.login.LoginCheck;
import com.secondhand.login.LoginValue;
import com.secondhand.service.TownService;
import com.secondhand.util.BasicResponse;
import com.secondhand.web.dto.requset.TownRegisterRequest;
import com.secondhand.web.dto.requset.TownRequest;
import com.secondhand.web.dto.response.TownResponse;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/towns")
@RequiredArgsConstructor
public class TownController {

    private final TownService townService;

    @Operation(
            summary = "전체 동네 목록을 조회",
            tags = "towns",
            description = "사용자는 전체 동네 목록을 볼수 있다.."
    )
    @LoginCheck
    @GetMapping
    public BasicResponse<List<TownResponse>> read() {
        List<TownResponse> townList = townService.findByAll();
        log.debug("전체 동네 목록을 가져온다 = {}", townList);

        return BasicResponse.<List<TownResponse>>builder()
                .message("성공")
                .success(true)
                .data(townList)
                .httpStatus(HttpStatus.OK)
                .apiStatus(20000)
                .build();
    }

    @Operation(
            summary = "사용자가 등록한 동네.",
            tags = "towns",
            description = "사용자는 특정 동네를 가져올 수있다."
    )
    @LoginCheck
    @GetMapping("/member")
    public BasicResponse<List<TownResponse>> readRegisterByMember(@LoginValue long userId) {
        List<TownResponse> townDetail = townService.findTownDetail(userId);
        log.debug("사용자가 등록한 동네를 가져올수 있다  = {}", townDetail);

        return BasicResponse.<List<TownResponse>>builder()
                .success(true)
                .message("")
                .apiStatus(20000)
                .httpStatus(HttpStatus.OK)
                .data(townDetail)
                .build();
    }

    //TODO : 등록을 숫자로가지고한다? 수정필요
    @Operation(
            summary = "사용자의 처음 동네 등록",
            tags = "members",
            description = "사용자의 화원가입할 때 메인, 서브  동네를 등록할 수있다."
    )
    @LoginCheck
    @PostMapping
    public BasicResponse registerTown(@LoginValue long userId,
                                      @RequestBody TownRegisterRequest request) {

        if (request.getTownId() == null) {
            throw new IllegalArgumentException("필수 지역 정보 없음");
        }

        townService.save(userId, request.getTownId());

        return BasicResponse.builder()
                .success(true)
                .message("사용자의 처음 동네 등록")
                .apiStatus(20000)
                .httpStatus(HttpStatus.OK)
                .build();
    }

    @Operation(
            summary = "사용자의 동네 수정",
            tags = "members",
            description = "사용자의 메인, 서브 동네를 수정할 수 있다."
    )
    @LoginCheck
    @PatchMapping
    public BasicResponse updateTown(@LoginValue long userId,
                                    @RequestBody TownRequest townRequest) {

        if (townRequest.getMainTownId() == null) {
            throw new IllegalArgumentException("필수 지역 정보 없음");
        }

        townService.update(userId, townRequest);

        return BasicResponse.builder()
                .success(true)
                .message("사용자의 동네 수정")
                .apiStatus(20000)
                .httpStatus(HttpStatus.OK)
                .build();
    }
}
