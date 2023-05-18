package com.green.airline.repository.model;

import java.sql.Date;

import com.green.airline.utils.NumberUtil;

import lombok.Data;

@Data
public class Mileage {

	private int balance;
	private int useMileage;
	private int saveMileage;
	private Date mileageDate;
	private String description;
	private String memberId;
	public String balanceNumber() {
		return  NumberUtil.numberFormat(balance);
		
	}
}
