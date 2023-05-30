package com.green.airline.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.repository.model.User;
import com.green.airline.service.EmailService;
import com.green.airline.service.UserService;

@RestController
public class UserApiController {
	@Autowired
	private UserService userService;
	@Autowired
	private EmailService emailService;
	@GetMapping("/sendNewPw")
	public String sendNewPw(@RequestParam("email") String email) {
		String code = null;
		try {
			code = emailService.sendPwCodeMessage(email);
			System.out.println("인증코드 : " + code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		

		return code;
	}
	@GetMapping("/searchId")
	public int sendNewPw1( @RequestParam("id") String id) {
		int result = 1;
		System.out.println("id : " + id);
		User user = userService.readByid(id);
		if(user.getId() != id) {
			result = 0;
		}
		return result;
	}
}
