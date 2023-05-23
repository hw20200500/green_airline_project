package com.green.airline.dto;

import java.sql.Date;

import com.green.airline.utils.NumberUtil;

import lombok.Data;

@Data
public class SaveMileageDto {

	private Date saveDate;
	private Long saveMileage;
	private int balance;
	private String memberId;
	private int extinctionMileage;
}
