<<<<<<< HEAD
package com.green.airline.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.green.airline.dto.kakao.KakaoAccount;
import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.enums.UserRole;
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

	// 회원가입 (join.jsp에 회원가입 버튼으로 회원가입하는 경우 무조건 여기로 옴)
	public void createMember(JoinFormDto joinFormDto) {
		int result = memberRepository.insertMember(joinFormDto);
		int result2 = 0;
		if(joinFormDto.getPassword() == null) {
			// 소셜 회원가입 (email, gender, id 중 하나라도 동의하지 않은 경우)
			result2 = userRepository.insertByUser(joinFormDto.getId(), greenKey, UserRole.SOCIAL);
		} else {
			result2 = userRepository.insertByUser(joinFormDto.getId(), joinFormDto.getPassword(), UserRole.DEFAULT);
		}
		if (result == 1 && result2 == 1) {
			System.out.println("회원가입 성공");
		}
	}

	public SocialDto readBySocialUserInfo(String id) {
		SocialDto socialMember = memberRepository.selectBySocialUserInfo(id);

		return socialMember;
	}

	// 소셜회원 회원가입 (email, gender, id 모두 동의한 경우, 회원가입 페이지를 거치지 않고 카카오 로그인 동의하기 누르자마자 회원가입이 된 경우)
	public void createByUser(SocialDto socialDto) {

		if ("male".equals(socialDto.getKakaoAccount().getGender())) {
			socialDto.getKakaoAccount().setGender("M");
		} else {
			socialDto.getKakaoAccount().setGender("F");
		}

		// member_tb에 저장
		int result = memberRepository.insertBySocialDto(socialDto.getId(), socialDto.getProperties().getNickname(),
				socialDto.getKakaoAccount().getEmail(), socialDto.getKakaoAccount().getGender());

		// user_tb에 저장
		int result2 = userRepository.insertByUser(socialDto.getId(), greenKey, UserRole.SOCIAL);
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
=======
package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.LoginFormDto;
import com.green.airline.repository.interfaces.UserRepository;
import com.green.airline.repository.model.User;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	public User readUserByIdAndPassword(LoginFormDto loginFormDto) {
		User userEntity = userRepository.selectByIdAndPassword(loginFormDto);
		return userEntity;
	}
	
}
>>>>>>> feature/board
