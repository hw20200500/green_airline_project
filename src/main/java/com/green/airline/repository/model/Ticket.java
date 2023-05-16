package com.green.airline.repository.model;

import java.sql.Timestamp;

import lombok.Data;

// 예약된 티켓
@Data
public class Ticket {

	private Integer id;
	private Integer seatCount;
	private String memberId;
	private Integer scheduleId;
	private Timestamp reservedDate;
	
}
