package com.green.airline.repository.model;

import java.sql.Date;

import com.green.airline.utils.NumberUtil;

import lombok.Data;

@Data
public class Mileage {


	private Date useDate;
	private int useMileage;
	private String description;
	private Date saveDate;
	private Date expirationDate;
	private int saveMileage;
	private int balance;
	private String memberId;
	public String balanceNumber() {
		return  NumberUtil.numberFormat(balance);
		
	}
}

