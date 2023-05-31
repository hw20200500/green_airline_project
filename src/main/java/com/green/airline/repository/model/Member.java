package com.green.airline.repository.model;

import java.sql.Date;

import lombok.Data;

// 회원
@Data
public class Member {

	private String id;
	private String korName;
	private String engName;
	private Date birthDate;
	private String gender;
	private String phoneNumber;
	private String email;
	private String address;
	private String nationality;
	private String grade;

	private String postcode;
	private String detailAddress;
	
}
