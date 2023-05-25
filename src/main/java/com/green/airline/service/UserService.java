package com.green.airline.service;

import javax.servlet.http.HttpSession;

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
import com.green.airline.utils.Define;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private MemberRepository memberRepository;

	@Autowired
	private HttpSession session;

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

	// 회원가입
	public void createMember(Member member) {
		int result = memberRepository.insertMember(member);

		if (result == 1) {
			System.out.println("회원가입 성공");
		}
	}

	public SocialDto readBySocialUserInfo(String id) {
		SocialDto socialMember = memberRepository.selectBySocialUserInfo(id);

		return socialMember;
	}

	public void createByUser(SocialDto socialDto) {
		if (socialDto.getKakaoAccount().getEmail() == null) {
			socialDto.getKakaoAccount().setEmail("");
		}
		
		if (socialDto.getKakaoAccount().getGender() == null) {
			socialDto.getKakaoAccount().setGender("");
		} else {
			if ("male".equals(socialDto.getKakaoAccount().getGender())) {
				socialDto.getKakaoAccount().setGender("M");
			} else {
				socialDto.getKakaoAccount().setGender("F");
			}
		}

		// Todo userRole '소셜 회원'로 바꾸도록
		// update 처리하기
//		userRepository.updateUserByUserRole(socialDto.getId(), userRole);

		// member_tb에 저장
		int result = memberRepository.insertBySocialDto(socialDto.getId(), socialDto.getProperties().getNickname(),
				socialDto.getKakaoAccount().getEmail(), socialDto.getKakaoAccount().getGender());

		// user_tb에 저장
		int result2 = userRepository.insertByUser(socialDto.getId(), greenKey, Define.USERROLE_SOCIAL);

		if (result == 1 && result2 == 1) {
			System.out.println("insert 성공");
		}

	}

	public User readSocialDtoById(String id) {
		// 123123123123 <-- 카카오 던지거

		// 본인 데이터 베이스에 조회
		User userEntity = userRepository.selectSocialDtoById(id);
		return userEntity;
	}
	

}
