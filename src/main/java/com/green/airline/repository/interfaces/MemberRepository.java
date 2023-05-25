package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.repository.model.Member;

@Mapper
public interface MemberRepository {

	public Member selectById(String id);

	// 카카오 로그인 api에 쓸 것
	public SocialDto selectBySocialUserInfo(String id);

	// 회원가입 처리
	public int insertMember(Member member);
	
	// 카카오 로그인 처리
	// 회원가입 --> kmg1151@naver.com
	// 카카카오 로그인 --> kmg1151@naver.com
	// 카카카오 로그인 : 김민정_9912
	
	// kmg1151@naver.com
	public int insertBySocialDto(@Param("id") String id, @Param("nickname") String nickname,
			@Param("email") String email, @Param("gender") String gender);

}
