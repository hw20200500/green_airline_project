package com.green.airline.repository.model;

import java.sql.Timestamp;

import lombok.Data;

// 운항 일정
@Data
public class Schedule {

	private Integer id;
	private Timestamp departureDate;
	private Timestamp arrival_date;
	private Integer airplaneId;
	private Integer routeId;
	
}