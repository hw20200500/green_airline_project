package com.green.airline.repository.model;

import lombok.Data;

// 좌석
@Data
public class Seat {

	private Integer airplaneId;
	private String name;
	private String grade;
	
}