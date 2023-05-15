package com.green.airline.repository.model;

import lombok.Data;

// 운항시간별 티켓 가격
@Data
public class TicketPrice {

	private Integer flightHours;
	private Long price;
	
}
