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
	public int insertBySocialDto(Long id, String email, String gender);
	
}
