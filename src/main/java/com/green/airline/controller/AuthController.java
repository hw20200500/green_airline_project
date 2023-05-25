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
	@ResponseBody
	@Transactional
	public SocialDto kakaoCallbackCode(@RequestParam String code) throws JsonProcessingException {
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

		// .exchange로 요청한 값을 responseToken에 담음 / OAuthToken.class -> 응답 해줄 때 이걸로 내려달라고 요청하는 거임
		ResponseEntity<OAuthToken> responseToken = restTemplate.exchange(uri, HttpMethod.POST, kakaoReqEntity,
				OAuthToken.class);

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		SocialDto res = requestKakaoUserInfo(responseToken.getBody().getAccessToken());
		
		// 회원가입 처리 작동 확인 완료 했으니 if문 사용해서 처음 연동시에만 회원가입 처리하게 바꾸기
		// 회원가입 처리를 하지 않을 때는 로그인 처리(session에 값 담기)
		// 로그아웃 처리 해보기
		// 탈퇴처리 해보기
		// userService.createBySocialDto(res);
//		SocialDto selectNickname = userService.readBySocialUserInfo(res.getKakaoAccount().getProfile().getNickname());

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
	// user_tb -> id / member_tb -> id, password, email, gender

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
