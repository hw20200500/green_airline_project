package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class BaggageReqResponse {

	private Integer id;
	private String section;
	private String gradeId;
	private String freeAllowance;
	private Integer broId;
	private Integer routeId;
	private Integer baggageId;
	private Integer breId;
	private Integer amount;
	private Integer brId;
	private String memberId;
	private Timestamp departureDate;
	private Integer ticketId;
	private String departure;
	private String destination;
	private Integer seatCount;

	public String departureDateFormat() {
		return TimestampUtil.dateTimeToString(departureDate);
	}
}
