package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Member;

@Mapper
public interface MemberRepository {

	public Member selectById(String id);
	
	public Member selectByKorNameandEmailAndBirthDate(Member member);
}
