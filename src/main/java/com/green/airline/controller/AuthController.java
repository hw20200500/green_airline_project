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
import org.springframework.ui.Model;
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

		// 서비스에서 회원가입여부 확인 - select -> null -> 회원가입 처리
		User principal = userService.readSocialDtoById(res.getId()); // <-- 서비스에서 회원가입여부 확인
		// principal이 null이 나올 경우 회원가입이 안된 상태
		if (principal == null) {
			// return 회원가입 페이지
			String id = res.getId();
			String email = res.getKakaoAccount().getEmail();
			String gender = res.getKakaoAccount().getGender();

			// email은 없고
			if (email == null) {
				// gender도 없고
				if (gender == null) {
					return "redirect:/apiJoin?id=" + id;
				}
				// gender는 있고
				return "redirect:/apiJoin?id=" + id + "&gender=" + gender;
				// gender만 없고
			} else if (gender == null) {
				return "redirect:/apiJoin?id=" + id + "&email=" + email;
			}

			// email, gender, id 셋 다 있는 경우 여기까지 내려옴
			// 회원가입 처리
			userService.createByUser(res);
			// 로그인 처리(session에 값 담기) -> 위 principal에서는 null이 나왔기 때문에 
			// session에 값을 담아주려면 다시 서비스를 불러서 조회해야함
			User principal2 = userService.readSocialDtoById(res.getId());
			session.setAttribute(Define.PRINCIPAL, principal2);
			
			// 메인으로
			return "redirect:/";

		} else {
			// 위 principal이 null이 아닐 경우 로그인 처리를 위한 session에 값 담기
			// 로그인 처리
			session.setAttribute(Define.PRINCIPAL, principal);
		}

		return "redirect:/";
	}

	@GetMapping("/apiJoin")
	public String apiJoinPage(@RequestParam(name = "id") String id, @RequestParam(defaultValue = "none") String email,
			@RequestParam(defaultValue = "none") String gender) {
		if (gender.equals("male")) {
			gender = "M";
		} else if (gender.equals("female")) {
			gender = "F"; 
		}

		// redirect => 새로운 request response 객체를 생성해서 요청을 던지는 녀석
		return "redirect:/socialJoin?id=" + id + "&email=" + email + "&gender=" + gender;
	}

	// 사용자 정보 받아오기
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
