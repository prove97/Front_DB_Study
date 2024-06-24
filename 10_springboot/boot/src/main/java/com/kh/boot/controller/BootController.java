package com.kh.boot.controller;

import com.kh.boot.domain.dto.BoardRequest;
import com.kh.boot.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/board")
public class BootController {
//    @GetMapping("/dummy")
//    public String dummy(){
//        log.info("dummy 성공");
//        return "ok";
//    }
//
//    @GetMapping("/member")
//    public String getMember(@RequestParam(value="memberKey", defaultValue = "111") String memberKey,
//                            @RequestParam(value="age") int age){
//        log.info("memberKey는 {}", memberKey);
//        log.info("age {}", age);
//        return "ok";
//    }

    private final BoardService boardService;

    //ResponseEntity : Http응답을 코드를 나타내는 클래스이다.
    @PostMapping
    public ResponseEntity<Boolean> create(BoardRequest.CreateDTO request) throws Exception{
        
        //Board 객체를 생성하기 위함
        //userId, pwd, title, contents
        boolean isCreated = boardService.create(request);
        
        return new ResponseEntity<>(isCreated, HttpStatus.OK);
    }

    @GetMapping
    public void getBoardList(){

    }


}


