package com.green.airline.repository.model;

import java.sql.Date;

import lombok.Data;

@Data
public class UseMileage {

	private Date useDate;
	private int useMileage;
	private String description;
	private String memberId;
}
