package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;

@Mapper
public interface UserRepository {

	public User selectByIdAndPassword(LoginFormDto loginFormDto);
	
}
