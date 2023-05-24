package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.green.airline.dto.kakao.KakaoAccount;
import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.repository.interfaces.MemberRepository;
import com.green.airline.repository.interfaces.UserRepository;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private MemberRepository memberRepository;

	@Value("${green.key}")
	private String greenKey;

	/**
	 * @author 서영 로그인
	 */
	public User readUserByIdAndPassword(LoginFormDto loginFormDto) {
		User userEntity = userRepository.selectByIdAndPassword(loginFormDto);
		return userEntity;
	}

	/**
	 * @author 서영
	 * @return 회원 정보
	 */
	public Member readMemberById(String id) {
		Member memberEntity = memberRepository.selectById(id);
		return memberEntity;
	}

	public SocialDto readBySocialUserInfo(String id) {
		SocialDto socialMember = memberRepository.selectBySocialUserInfo(id);

		return socialMember;
	}

	public void createBySocialDto(SocialDto socialDto) {

		if (socialDto.getKakaoAccount().getGender().equals("male")) {
			socialDto.getKakaoAccount().setGender("M");
		} else if (socialDto.getKakaoAccount().getGender().equals("female")) {
			socialDto.getKakaoAccount().setGender("F");
		}

		int result = memberRepository.insertBySocialDto(socialDto.getId(), socialDto.getProperties().getNickname(),
				socialDto.getKakaoAccount().getEmail(), socialDto.getKakaoAccount().getGender());

		int result2 = userRepository.insertBySocialDto(socialDto.getId(), greenKey);

		if (result == 1 && result2 == 1) {
			System.out.println("insert 성공");
		}

	}

}
