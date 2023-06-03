package com.green.airline.dto.request;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class ManagerFormDto {
	
	@NotBlank
	private String managerName;
	private String birthDate;
	@NotBlank
	private String gender;
	@NotBlank
	private String phoneNumber;
	@NotBlank
	private String email;
	
}
