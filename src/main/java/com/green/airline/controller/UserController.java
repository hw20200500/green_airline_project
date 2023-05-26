package com.green.airline.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Member;
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
	public String logoutProc(HttpServletRequest request) {

// 		매개변수 : HttpServletRequest request
//		Cookie[] cookies = request.getCookies();
//
//		ArrayList<Cookie> cookiesList = new ArrayList<>(Arrays.asList(cookies));
//		cookiesList.stream().forEach((cookie) -> {
//			System.out.println(cookie);
//			cookie.setMaxAge(0);
//		});

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
	
	@GetMapping("/join")
	public String joinPage() {
		// Todo
		// 데이터베이스에서 국적 가져오기
		return "/user/join";
	}
	
	@PostMapping("/joinProc")
	public String joinProc(Member member) {
		userService.createMember(member);
		return "redirect:/";
	}

}
