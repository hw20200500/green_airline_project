package com.green.airline.controller;

import java.net.URI;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.green.airline.dto.OAuthToken;
import com.green.airline.dto.SocialDto;
import com.green.airline.repository.model.User;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
public class AuthController {

	@Value("${green.key}")
	private String greenKey;
	@Autowired
	private HttpSession session;
	@Autowired
	private UserService userService;

	@GetMapping("/auth/kakao/callback")
	@ResponseBody
	public SocialDto kakaoCallbackCode(@RequestParam String code) throws JsonProcessingException {
		// code :
		// 1CoW7KlQ7rCl4vdQBN6ZqTu6c_0yJwlEyEt2l9ZAhwX5bTAKL2j-sthO9gkvdPZNxTBXcQopyWAAAAGITCXUEQ
//		System.out.println("code : " + code);

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "ce88cf20b78f9552fe8f49e224822cf8");
		params.add("redirect_uri", "http://localhost:80/auth/kakao/callback");
		params.add("code", code);

		URI uri = UriComponentsBuilder.fromUriString("https://kauth.kakao.com").path("/oauth").path("/token").encode()
				.build().toUri();

		HttpEntity<MultiValueMap<String, String>> kakaoReqEntity = new HttpEntity<>(params, headers);

		ResponseEntity<OAuthToken> responseToken = restTemplate.exchange(uri, HttpMethod.POST, kakaoReqEntity,
				OAuthToken.class);
		System.out.println(responseToken);

//		SocialMemberInfoDto userInfo = requestKakaoUserInfo(responseToken.getBody().getAccessToken());

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		SocialDto res = requestKakaoUserInfo(responseToken.getBody().getAccessToken());
		// 서비스 호출 () ㅏ {}. id
		SocialDto selectNickname = userService.readBySocialUserInfo(res.getKakaoAccount().getProfile().getNickname());
		System.out.println(res.getKakaoAccount().getGender());
		System.out.println(res.getKakaoAccount().getProfile().getNickname());
//		System.out.println(selectNickname);
		
		// 서비스에서 회원가입여부 확인 - select -> null -> 회원가입 처리
		// 로그인 처리 세션 생성
//		System.out.println("userInfo : " + userInfo);
//		SocialMemberInfoDto memberInfoDto = userService.readBySocialUserInfo(userInfo.getId());

		if (principal == null) {
			// 회원 가입 처리
		} else {
			// 로그인 처리
		}

		return res;
	}

	// 카카오 자원 서버에서 데이터를 받음

	// Todo
	// 우리 서버에 추가해야 할 작업 사항

	// 세션 처리해야 함 - > 회원가입이 되어 있어야 한다.
	// user_tb, member_tb -> id, password, email, gender

	// select 확인 후
	// 최초 사용자면 회원가입 처리 (중복된 이름이 생길 수 있음)
	// 그게 아니라면 로그인 처리

	// 최초 소셜 접근 사용자는 카카오 닉네임으로 username 저장
	// DB에서는 password (필수) <-- 임의값으로 DB에 저장해야 함.

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

}
