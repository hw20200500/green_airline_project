package com.green.airline.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 서영
 * 문의 게시판 관련
 */
@Controller
@RequestMapping("/ask")
public class AskController {

	/**
	 * @return 문의 게시글 작성 페이지
	 */
	@GetMapping("/write")
	public String askWritePage() {
		
		return "";
	}
	
}
