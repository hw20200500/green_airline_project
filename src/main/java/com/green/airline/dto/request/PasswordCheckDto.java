package com.green.airline.dto.request;

import lombok.Data;

@Data
public class PasswordCheckDto {

	private String id;
	private String password;
	private String type;
	
	private String newPassword;
	private String newPasswordCheck;
	
}
