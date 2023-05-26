package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.enums.UserRole;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;

@Mapper
public interface UserRepository {

	public User selectByIdAndPassword(LoginFormDto loginFormDto);
	
	public User selectById(LoginFormDto loginFormDto);

	// user_tb에 넣을 값 (kakao login api에 사용)
	public int insertByUser(@Param("id") String id, @Param("password") String password,
			@Param("userRole") UserRole userRole);

	public User selectSocialDtoById(String id);

}
