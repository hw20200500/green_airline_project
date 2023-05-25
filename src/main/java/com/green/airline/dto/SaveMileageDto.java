package com.green.airline.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class SaveMileageDto {

	private Timestamp departureDate;
	private Timestamp expirationDate;
	
	private int extinctionMileage;
	private Long saveMileage;
	private int balance;
	private Timestamp insertTime;
	private String memberId;
	private String ticketId;
}
