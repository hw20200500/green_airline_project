package com.green.airline.dto.response;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class RouteResponseDto {

	private String destination;
	private String departure;
	private String flightTime;
	private Timestamp departureDate;
	private Timestamp arrivalDate;
	
}
