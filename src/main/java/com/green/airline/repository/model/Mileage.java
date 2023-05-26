package com.green.airline.repository.model;

import java.sql.Timestamp;

import com.green.airline.utils.NumberUtil;

import lombok.Data;

@Data
public class Mileage {

	private int id;
	private Timestamp useDate;
	private int useMileage;
	private String description;
	private Timestamp saveDate;
	private Timestamp expirationDate;
	private int saveMileage;
	private int balance;
	private String memberId;
	private String ticketId;
	public String balanceNumber() {
		return  NumberUtil.numberFormat(balance);
		
	}
}

