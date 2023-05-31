package com.green.airline.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.nio.channels.MembershipKey;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.nation.NationDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.dto.request.SocialJoinFormDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
@Validated
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private HttpSession session;

	@Autowired
	private AirportService airportService;

	/**
	 * @author 서영 메인 페이지
	 */
	@GetMapping("")
	public String mainPage(Model model) {
		int isMain = 1;
		model.addAttribute("isMain", isMain);

		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);

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
	 * 로그인 처리
	 */
	@PostMapping("/login")
	public String loginProc(LoginFormDto loginFormDto) {
		User principal = userService.readUserByIdAndPassword(loginFormDto);
		if (principal != null && principal.getStatus() == 0) {
			session.setAttribute(Define.PRINCIPAL, principal);
			if (principal.getUserRole().equals("관리자")) {
				return "redirect:/manager/dashboard";
			}
		}

		if (principal.getStatus() == 1) {
			throw new CustomRestfullException("탈퇴한 회원입니다.", HttpStatus.BAD_REQUEST);
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
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		Member response = userService.readMemberById(principal.getId());
		return response;
	}

	// 일반 회원 로그인 페이지
	@GetMapping("/join")
	public String joinPage(Model model) {
		ArrayList<String> countryNm = nationalityApi();

		model.addAttribute("countryNm", countryNm);

		return "/user/join";
	}

	// 카카오 로그인 페이지
//	@GetMapping("/socialJoin")
//	public String apiJoinPage(@RequestParam(name = "id") String id, @RequestParam(defaultValue = "none") String email,
//			@RequestParam(defaultValue = "none") String gender, Model model) {
//
//		ArrayList<String> countryNm = nationalityApi();
//
//		model.addAttribute("countryNm", countryNm);
//		model.addAttribute("id", id);
//		model.addAttribute("email", email);
//		model.addAttribute("gender", gender);
//		return "redirect:/";
//	}

	// 회원가입 (join.jsp에 회원가입 버튼으로 회원가입하는 경우 무조건 여기로 옴)
	@PostMapping("/joinProc")
	public String joinProc(@Validated JoinFormDto joinFormDto, Errors errors, Model model) {
		// 인증검사
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
			ArrayList<String> countryNm = nationalityApi();
			model.addAttribute("countryNm", countryNm);
			// 에러가 발생했을 경우
			return "/user/join";
		}

		userService.createMember(joinFormDto);

		return "redirect:/login";
	}

	@GetMapping("/apiSocialJoin")
	public String apiSocialJoinPage(@RequestParam(name = "id") String id,
			@RequestParam(defaultValue = "none") String email, @RequestParam(defaultValue = "none") String gender,
			Model model) {

		ArrayList<String> countryNm = nationalityApi();
		model.addAttribute("countryNm", countryNm);

		model.addAttribute("id", id);
		model.addAttribute("email", email);
		model.addAttribute("gender", gender);
		return "/user/socialJoin";
	}

	// validation 처리가 안됨
	// 이거를 타게 하면 된다.
	@PostMapping("/apiSocialJoinProc")
	public String apiSocialJoinProc(@Validated SocialJoinFormDto socialJoinFormDto, Errors errors, Model model) {

		if (errors.hasErrors()) {
			// 회원가입 실패시 입력 데이터 유지
			model.addAttribute("socialJoinFormDto", socialJoinFormDto);

			// 회원가입 실패시 message 값들을 모델에 매핑해서 View로 전달
			Map<String, String> validateResult = userService.validateHandler(errors);

			// map.keySet() 모든 key값을 갖고 온다.
			// 그 갖고 온 키로 반복문을 통해 키와 에러 메세지로 매핑
			for (String key : validateResult.keySet()) {

				// ex) model.addAttribute("valid_id", "아이디는 필수 입력사항입니다.")
				model.addAttribute(key, validateResult.get(key));
			}
			ArrayList<String> countryNm = nationalityApi();
			model.addAttribute("countryNm", countryNm);
			// 에러가 발생했을 경우
			return "/user/socialJoin";
		}

		System.out.println("1111111111111111" + socialJoinFormDto);
		// !@@!!!!!!!!@!@!@@!@!@!@!!@@!@!@!@update 처리해주기
		userService.updateMemberById(socialJoinFormDto.getId(), null);
		System.out.println("2222222222222" + socialJoinFormDto);
		// 로그인이 된 채로 redirect가 되지 않음
		return "redirect:/";
	}

	// 국적 api
	public ArrayList<String> nationalityApi() {
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
		return countryNm;
	}

	// 회원 정보 수정 페이지 ) 비밀번호 확인 페이지
	@GetMapping("/userPwCheck")
	public String userPwCheckPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		User user = userService.readUserById(principal.getId());

		model.addAttribute("principal", principal);

		return "/user/userPwCheck";
	}

	@PostMapping("/userPwCheck")
	public String userPwCheckProc(LoginFormDto loginFormDto) {
		// principal과 갖고 온 패스워드 같나 확인하기
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		String id = principal.getId();
		User user = userService.readUserById(id);

		// 쿼리문 하나 더 만들어서 User로 받자
		// loginFormDto에서 받은 값이랑 비교해서 가져와야 함
		System.out.println("user" + user.getPassword());
		System.out.println("principal" + principal.getPassword());
		System.out.println("loginFormDto" + loginFormDto.getPassword());

		if (principal != null) {
			if (principal.getPassword() != user.getPassword()) {
				throw new CustomRestfullException("비밀번호가 일치하지 않습니다.", HttpStatus.BAD_REQUEST);
			}
		}

		return "redirect:/userUpdate";
	}

	// 회원 정보 수정 페이지
	@GetMapping("/userUpdate")
	public String userUpdatePage(Member member, Errors errors, Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		Member meberById = userService.readMemberById(principal.getId());

		model.addAttribute("principal", principal);
		model.addAttribute("meberById", meberById);

		ArrayList<String> countryNm = nationalityApi();
		model.addAttribute("countryNm", countryNm);

		return "/user/userUpdate";
	}

	@PostMapping("/userUpdate")
	public String userUpdateProc(@RequestParam String id, Member member, Model model) {
		User principal = userService.readUserById(id);
		userService.updateMemberById(principal.getId(), member);

		// todo 마이페이지로 이동
		return "redirect:/";
	}

	// 회원 탈퇴
	@GetMapping("/userWithdraw")
	public String userWithdrawPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		// Todo member 정보내려주기
		Member member = userService.readById(principal.getId());
		model.addAttribute("member", member);

		if (principal.getStatus() == 1) {
			throw new CustomRestfullException("", null);
		}

		model.addAttribute("principal", principal);

		return "/user/userWithdraw";
	}

	// 회원 탈퇴 상태 변경 0 : 회원 / 1 : 탈퇴 회원
	@PostMapping("/userWithdraw")
	public String userWithdrawProc() {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		userService.updateUserByStatus(principal.getId(), 1);
		session.invalidate();

		return "redirect:/";
	}

	// 비밀번호 변경 페이지
	@GetMapping("/confirmPw")
	public String confirmPwPage() {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		userService.readUserById(principal.getId());

		return "/user/confirmPw";
	}

	@PostMapping("/confirmPw")
	public String confirmPwProc() {

		return "";
	}

}