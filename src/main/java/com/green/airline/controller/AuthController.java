package com.green.airline.controller;

import java.net.URI;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.green.airline.dto.OAuthToken;
import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.repository.model.User;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
public class AuthController {

	@Autowired
	private HttpSession session;
	@Autowired
	private UserService userService;

	// Redirect URI 주소로 콜백 보냄
	@GetMapping("/auth/kakao/callback")
	@Transactional
	public String kakaoCallbackCode(@RequestParam String code) throws JsonProcessingException {
		// code :
		// 1CoW7KlQ7rCl4vdQBN6ZqTu6c_0yJwlEyEt2l9ZAhwX5bTAKL2j-sthO9gkvdPZNxTBXcQopyWAAAAGITCXUEQ
//		System.out.println("code : " + code);
		RestTemplate restTemplate = new RestTemplate();

		// 헤더 만듦
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 바디 만듦
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "ce88cf20b78f9552fe8f49e224822cf8");
		params.add("redirect_uri", "http://localhost:80/auth/kakao/callback");
		params.add("code", code);

		// 카카오 서버로 요청할 URI 만듦
		URI uri = UriComponentsBuilder.fromUriString("https://kauth.kakao.com").path("/oauth").path("/token").encode()
				.build().toUri();

		// 만들어둔 헤더와 바디 합쳐서 kakaoReqEntity 담음
		HttpEntity<MultiValueMap<String, String>> kakaoReqEntity = new HttpEntity<>(params, headers);

		// .exchange로 요청한 값을 responseToken에 담음 / OAuthToken.class -> 응답 해줄 때 이걸로 내려달라고
		// 요청하는 거임
		ResponseEntity<OAuthToken> responseToken = restTemplate.exchange(uri, HttpMethod.POST, kakaoReqEntity,
				OAuthToken.class);

		SocialDto res = requestKakaoUserInfo(responseToken.getBody().getAccessToken());

		// 회원가입 처리 작동 확인 완료 했으니 if문 사용해서 처음 연동시에만 회원가입 처리하게 바꾸기
		// 회원가입 처리를 하지 않을 때는 로그인 처리(session에 값 담기)
		// 로그아웃 처리 해보기
		// 탈퇴처리 해보기

		// 서비스에서 회원가입여부 확인 - select -> null -> 회원가입 처리
		// 로그인 처리 세션 생성
//		SocialMemberInfoDto memberInfoDto = userService.readBySocialUserInfo(userInfo.getId());

		// principal에서 id를 가져와 그 아이디를 member_tb의 WHERE 절에
		// 넣으면 해당 유저의 정보를 가져올 수 있음
//		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		// todo - del
		// res.getId() 123123123123
		User principal = userService.readSocialDtoById(res.getId());
//		System.out.println(principal);
		if (principal == null) {
			// session에 user_tb ? 에서 조회한 회원 정보가 들어감
			// 서비스 불러서 조회하기
			// session에 값 담기

			// return 회원가입 페이지
			String email = res.getKakaoAccount().getEmail();
			String gender = res.getKakaoAccount().getGender();

			// email은 없고 
			if (email == null) {
				
				// gender도 없고
				if (gender == null) {
					return "redirect:/apiJoin";
				}
				
				// gender는 있고
				return "redirect:/apiJoin?gender=" + gender;
				
				// gender만 없고
			} else if (gender == null) {
				return "redirect:/apiJoin?email=" + email;
			}
			
			// email, gender 둘 다 있고
			userService.createByUser(res);
			User principal2 = userService.readSocialDtoById(res.getId());
			session.setAttribute(Define.PRINCIPAL, principal2);
			
			return "redirect:/apiJoin?email=" + email + "&gender=" + gender;

		} else {
			session.setAttribute(Define.PRINCIPAL, principal);
		}

//		System.out.println("principal : " + principal.getId());

		// if (principal == null) {
//			// 회원 가입 처리
//
//		} else {
//			// 로그인 처리
//			User user = userService.readSocialDtoById(principal.getId());
//
//		}

		// -0000
		return "redirect:/";
	}

	@GetMapping("/apiJoin")
	public String apiJoinPage(@RequestParam(defaultValue = "none") String email, @RequestParam(defaultValue = "none") String gender) {

		return "redirect:/join";
	}

	// 사용자 정보 받아오기
	/**
	 * GET/POST /v2/user/me HTTP/1.1 Host: kapi.kakao.com Authorization: Bearer
	 * ${ACCESS_TOKEN}/KakaoAK ${APP_ADMIN_KEY} Content-type:
	 * application/x-www-form-urlencoded;charset=utf-8
	 */
	private SocialDto requestKakaoUserInfo(String oAuthToken) {
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + oAuthToken);

		// 바디 생략 get으로 보낼 거기 때문에
		HttpEntity<SocialDto> profileReqEntity = new HttpEntity<>(headers);
		ResponseEntity<SocialDto> response = restTemplate.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.GET,
				profileReqEntity, SocialDto.class);

		return response.getBody();
	}

	// 로그아웃 처리 세션에서 없애버리는 방법도 있음
	private SocialDto logoutKakaoUser(String accessToken) {

		// 매개변수 : String accessToken
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded");
		headers.add("Authorization", "Bearer " + accessToken);

		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("target_id_type", "user_id");
		params.add("taget_id", "id"); // 서비스에서 로그아웃시킬 사용자의 회원번호

		URI uri = UriComponentsBuilder.fromUriString("https://kapi.kakao.com").path("/v1").path("/user").path("/logout")
				.encode().build().toUri();

		HttpEntity<MultiValueMap<String, String>> kakaoReqEntity = new HttpEntity<>(params, headers);

		ResponseEntity<SocialDto> response = restTemplate.exchange(uri, HttpMethod.POST, kakaoReqEntity,
				SocialDto.class);

//		System.out.println(responseToken);

		return response.getBody();
	}

}
