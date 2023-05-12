package com.green.airline.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// todo 삭제

@Controller
public class TestController {

	@GetMapping("/")
	public String test() {
		return "/layout/main";
	}
	
	
}
