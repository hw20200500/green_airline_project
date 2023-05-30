package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.repository.interfaces.MemberRepository;
import com.green.airline.repository.interfaces.MileageRepository;
import com.green.airline.repository.interfaces.UserRepository;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private MileageRepository mileageRepository;
	
	/**
	 * @author 서영
	 * 로그인
	 */
	public User readUserByIdAndPassword(LoginFormDto loginFormDto) {
		User userEntity = userRepository.selectByIdAndPassword(loginFormDto);
		
		// 로그인 할 때 마일리지 조회 해서 등급 결정
		String memberId = userEntity.getId();
		String grade = "";
		Long sumSaveMileage = mileageRepository.selectSumSaveMileageByMemberId(memberId);
		if(sumSaveMileage < 100000) {
			grade = "Silver";
			userRepository.updateGradeByMemberId(memberId, grade);					
		}else if(sumSaveMileage >= 100000 && sumSaveMileage <500000) {
			grade = "Gold";
			userRepository.updateGradeByMemberId(memberId, grade);
		}else if(sumSaveMileage >= 500000 && sumSaveMileage < 1000000) {
			grade = "Platinum";
			userRepository.updateGradeByMemberId(memberId, grade);
		}else if(sumSaveMileage >= 1000000) {
			grade = "Diamond";
			userRepository.updateGradeByMemberId(memberId, grade);
		}
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
