package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;

@Mapper
public interface UserRepository {

	public User selectByIdAndPassword(LoginFormDto loginFormDto);
	
	public int updateUserPwById(@Param("password")String password, @Param("userId")String userId);
	public User selectById(String id);
	public int updateGradeByMemberId(@Param("memberId")String memberId,@Param("grade")String grade);
}
