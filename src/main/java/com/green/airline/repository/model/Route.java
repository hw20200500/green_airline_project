package com.green.airline.repository.model;

import lombok.Data;

// 노선
@Data
public class Route {

	private Integer id;
	private String departure;
	private String destination;
	private String flightTime;
	private Integer flightDistance;
	private Integer type;
	
}
