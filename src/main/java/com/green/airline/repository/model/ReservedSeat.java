package com.green.airline.repository.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 예약 좌석
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservedSeat {

	private Integer scheduleId;
	private String seatName;
	private String ticketId;
	
}
