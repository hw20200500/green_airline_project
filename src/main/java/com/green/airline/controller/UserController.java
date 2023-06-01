package com.green.airline.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.nation.NationDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.dto.request.SocialJoinFormDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.MileageService;
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
	private MileageService mileageService;
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

	 * todo : 비밀번호인코더 처리
	 * 
	 * @return

	 */
	@PostMapping("/login")
	public String loginProc(LoginFormDto loginFormDto) {
		System.out.println("loginFormDto : " + loginFormDto);
		User principal = userService.readUserByIdAndPassword(loginFormDto);
		
		if (principal != null) {
			session.setAttribute(Define.PRINCIPAL, principal);
			if (principal.getUserRole().equals("관리자")) {
				return "redirect:/manager/dashboard";
			}
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


	// 일반 회원 로그인 페이지
	@GetMapping("/join")
	public String joinPage(Model model) {
		ArrayList<String> countryNm = nationalityApi();

		model.addAttribute("countryNm", countryNm);

		return "/user/join";
	}

	// 카카오 로그인 페이지
	@GetMapping("/socialJoin")
	public String apiJoinPage(@RequestParam(name = "id") String id, @RequestParam(defaultValue = "none") String email,
			@RequestParam(defaultValue = "none") String gender, Model model) {

		ArrayList<String> countryNm = nationalityApi();

		model.addAttribute("countryNm", countryNm);
		model.addAttribute("id", id);
		model.addAttribute("email", email);
		model.addAttribute("gender", gender);
		return "/user/socialJoin";
	}

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
	public String apiSocialJoinPage(Model model) {

		ArrayList<String> countryNm = nationalityApi();
		model.addAttribute("countryNm", countryNm);
		return "/user/socialJoin";
	}

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


		userService.createSocialMember(socialJoinFormDto);
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
	
	// 회원 정보 수정 페이지
	@GetMapping("/userUpdate")
	public String userUpdatePage() {
		// Todo
		// !!!!!! 회원 탈퇴 여부 상태값 컬럼 수정하기 !!!!!!!
		// principal을 잘 활용하자 ~ 
		return "/user/userUpdate";
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
	
	/**
	 * 정다운
	 * 마이페이지
	 * @return
	 */
	@GetMapping("/userMain")
	public String userMainPage(Model model) {
		User user = (User) session.getAttribute(Define.PRINCIPAL);
		String memberId = user.getId();
		Date date = new Date();
		long time = date.getTime();
		Timestamp ts = new Timestamp(time);
		Calendar cal = Calendar.getInstance();
		cal.setTime(ts);
		cal.add(Calendar.DATE, 30);
		ts.setTime(cal.getTime().getTime());
		
		
		// 현재 마일리지 조회
		SaveMileageDto sumNowMileage = mileageService.readSaveMileage(memberId);
		Mileage mileage = mileageService.readExprirationBalanceByMemberId(memberId,ts);
		Mileage mileage2 = mileageService.readSaveBalanceByMemberId(memberId,ts);
		Member member = userService.readMemberById(memberId);
		List<Mileage> mileages = mileageService.readMileageTbOrderByMileageDateByMemberId(memberId);
		model.addAttribute("sumNowMileage", sumNowMileage);
		model.addAttribute("mileage", mileage);
		model.addAttribute("mileage2", mileage2);
		model.addAttribute("member", member);
		model.addAttribute("mileages", mileages);
		System.out.println("mileages : " + mileages);
		return "/myPage/myMainPage";
	}
	
}

