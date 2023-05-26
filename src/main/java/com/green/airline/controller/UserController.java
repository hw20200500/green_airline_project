package com.green.airline.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.green.airline.dto.nation.NationDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
@Validated
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
		}
		return "redirect:/";
	}

	@GetMapping("/logout")
	public String logoutProc(HttpServletRequest request) {

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
	public String joinPage(Model model) {
		RestTemplate restTemplate = new RestTemplate();
		URI uri = null;

		try {
			uri = new URI(
					"http://apis.data.go.kr/1262000/CountryCodeService2/getCountryCodeList2?serviceKey=Cuo5MmMb2QEiC58RNfbyKZ3q7MF%2F5mvNSC%2FXcSI%2F9mkEK8Blx2zD5dULoP9UK0MaSi049JL%2BUmo7K%2FHXgEH9dQ%3D%3D&numOfRows=300&pageNo=1");
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		ResponseEntity<NationDto> response = restTemplate.getForEntity(uri, NationDto.class);

		ArrayList<String> countryNm = new ArrayList<>();

		for (int i = 0; i < response.getBody().getData().size(); i++) {
			countryNm.add(response.getBody().getData().get(i).getCountryNm());
		}

		model.addAttribute("countryNm", countryNm);

		return "/user/join";
	}

	@GetMapping("/socialJoin")
	public String apiJoinPage(@RequestParam(name = "id") String id, @RequestParam(defaultValue = "none") String email,
			@RequestParam(defaultValue = "none") String gender, Model model) {
		model.addAttribute("id", id);
		model.addAttribute("email", email);
		model.addAttribute("gender", gender);
		return "/user/join";
	}

	// 회원가입 (join.jsp에 회원가입 버튼으로 회원가입하는 경우 무조건 여기로 옴)
	@PostMapping("/joinProc")
	public String joinProc(@Validated JoinFormDto joinFormDto, Errors errors, Model model) {
		// 인증검사

//		if() {
//			
//		}
		
		// post 요청시 넘어온 user 입력값에서 Validation에 걸리는 경우
		if (errors.hasErrors()) {
			// 회원가입 실패시 입력 데이터 유지
			model.addAttribute("joinFormDto", joinFormDto);

			// 회원가입 실패시 message 값들을 모델에 매핑해서 View로 전달
			Map<String, String> validateResult = userService.validateHandler(errors);

			// map.keySet() 모든 key값을 갖고 온다.
			// 그 갖고 온 키로 반복문을 통해 키와 에러 메세지로 매핑 
			for (String key : validateResult.keySet()) {
				
				// ex) model.addAttribute("valid_id", "아이디는 필수 입력사항입니다.")
				model.addAttribute(key, validateResult.get(key));
			}

			return "/join";
		}

		userService.createMember(joinFormDto);

		return "/login";
	}

}
