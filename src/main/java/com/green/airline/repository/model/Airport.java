package com.green.airline.repository.model;

import lombok.Data;

// 공항
@Data
public class Airport {

	private Integer id;
	private String region;
	private String name;
	private double latitude;
	private double longitude;
	
}