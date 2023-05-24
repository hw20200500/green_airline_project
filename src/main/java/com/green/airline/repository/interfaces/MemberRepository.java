package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.SocialDto;
import com.green.airline.repository.model.Member;

@Mapper
public interface MemberRepository {

	public Member selectById(String id);
	
	// 카카오 로그인 api에 쓸 것
	public SocialDto selectBySocialUserInfo(String id);
	
	// 카카오 로그인 처리
	// 회원가입 --> kmg1151@naver.com
	// 카카카오 로그인 --> kmg1151@naver.com
	// 카카카오 로그인 : 김민정_9912
	
	// kmg1151@naver.com
	public int insertBySocialDto(Long id, String email, String gender);
	
}
