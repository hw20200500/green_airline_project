package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.KakaoAccount;
import com.green.airline.dto.SocialDto;
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
		int result = memberRepository.insertBySocialDto(socialDto.getId(), socialDto.getKakaoAccount().getEmail(),
				socialDto.getKakaoAccount().getGender());

		// 파일 이름 중복 되지 않게 난수 만들어서 
		if (result == 1) {
			System.out.println("insert 성공");
		}

	}

}
