package com.green.airline.repository.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Mileage {

	private int balance;
	private int useMileage;
	private int saveMileage;
	private Date mileageDate;
	private String description;
	private String memberId;
}
