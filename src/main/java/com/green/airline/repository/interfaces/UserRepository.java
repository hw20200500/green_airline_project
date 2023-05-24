package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.repository.model.User;

@Mapper
public interface UserRepository {

	public User selectByIdAndPassword(LoginFormDto loginFormDto);

	public int insertBySocialDto(@Param("id") String id, @Param("password") String password);

}
