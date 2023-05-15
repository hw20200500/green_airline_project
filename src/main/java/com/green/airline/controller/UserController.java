package com.green.airline.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.green.airline.dto.LoginFormDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.User;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private HttpSession session;
	
	/**
	 * @author 서영
	 * 메인 페이지
	 */
	@GetMapping("")
	public String mainPage(Model model) {
		int isMain = 1;
		model.addAttribute("isMain", isMain);
		return "/mainPage";
	}
	
	/**
	 * @author 서영
	 * 로그인 페이지
	 */
	@GetMapping("/login")
	public String loginPage() {
		return "/user/login";
	}
	
	/**
	 * todo : 비밀번호인코더 처리
	 * @return
	 */
	@PostMapping("/login")
	public String loginProc(LoginFormDto loginFormDto) {
		User principal = userService.readUserByIdAndPassword(loginFormDto);
		if (principal != null) {
			session.setAttribute(Define.PRINCIPAL, principal);
		} else {
			throw new CustomRestfullException("아이디 또는 비밀번호가 틀렸습니다.", HttpStatus.BAD_REQUEST);
		}
		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logoutProc() {
		session.invalidate();
		return "redirect:/";
	}
	
	
	
	
}
