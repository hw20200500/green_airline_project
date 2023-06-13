package com.green.airline.repository.model;

import com.green.airline.utils.NumberUtil;

import lombok.Data;

// 회원 등급
@Data
public class MemberGrade {

	private String name;
	private double mileageRate;
	private Long rankUpMileage;
	
}