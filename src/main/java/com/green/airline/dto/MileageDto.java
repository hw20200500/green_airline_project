package com.green.airline.dto;

import java.sql.Date;

import com.green.airline.utils.NumberUtil;

import lombok.Data;

@Data
public class MileageDto {

	private int balance;
	private int useMileage;
	private int saveMileage;
	private Date mileageDate;
	private String description;
	private String memberId;
	
}
