package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	 * @author 서영
	 * 로그인
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
	
	/**
	 * 정다운
	 * 아이디 찾
	 * @return
	 */
	public Member readByKorNameandEmailAndBirthDate(Member member) {
		Member memberEntity = memberRepository.selectByKorNameandEmailAndBirthDate(member);
		return memberEntity;
	}
	
	
	public User readByid(String id) {
		User user = userRepository.selectById(id);
		return user;
	}
public int updateyPassword(String password,String userId) {
		int result = userRepository.updateUserPwById(password,userId);
		return result;
	}
}
