package com.green.airline.repository.model;

import lombok.Data;

// 예약 좌석
@Data
public class ReservedSeat {

	private Integer scheduleId;
	private String seatName;
	private Integer ticketId;
	
}
