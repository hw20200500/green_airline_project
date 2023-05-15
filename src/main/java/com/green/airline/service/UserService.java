package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.LoginFormDto;
import com.green.airline.repository.interfaces.UserRepository;
import com.green.airline.repository.model.User;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	public User readUserByIdAndPassword(LoginFormDto loginFormDto) {
		User userEntity = userRepository.selectByIdAndPassword(loginFormDto);
		return userEntity;
	}
	
}
