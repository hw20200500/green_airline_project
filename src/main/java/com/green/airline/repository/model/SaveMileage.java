package com.green.airline.repository.model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class SaveMileage {

	private Date saveDate;
	private Timestamp expirationDate;
	private int saveMileage;
	private int balance;
	private String memberId;
}
