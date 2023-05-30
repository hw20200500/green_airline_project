package com.green.airline.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.service.EmailService;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private HttpSession session;

	/**
	 * @author 서영 메인 페이지
	 */
	@GetMapping("")
	public String mainPage(Model model) {
		int isMain = 1;
		model.addAttribute("isMain", isMain);
		return "/mainPage";
	}

	/**
	 * @author 서영 로그인 페이지
	 */
	@GetMapping("/login")
	public String loginPage() {
		return "/user/login";
	}

	/**
	 * todo : 비밀번호인코더 처리
	 * 
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

	/**
	 * 
	 * @return 로그인되어 있는 멤버의 회원 정보
	 */
	@ResponseBody
	@GetMapping("/loginMemberInfo")
	public Member loginMemberInfoData() {
		User user = (User) session.getAttribute(Define.PRINCIPAL);
		String id = user.getId();
		Member response = userService.readMemberById(id);
		return response;
	}

	@GetMapping("/userIdSearch")
	public String userIdSearchPage() {

		return "/user/userIdSearch";
	}

	@GetMapping("/userPwSearch")
	public String userPwSearchPage() {

		return "/user/userPwSearch";
	}

	
	@PostMapping("/findByUserId")
	public String findByUserId(Model model, Member member) {
		Member response = userService.readByKorNameandEmailAndBirthDate(member);
		model.addAttribute("response", response);
		return "/user/userIdSearch";
	}
	/**
	 *정다운
	 * 비밀번호 변경
	 * @return
	 */
	@PostMapping("/updatePassword")
public String updatePasswordById(String password,String userId) {
	userService.updateyPassword(password, userId);
	return "/user/login";
}
	
}
