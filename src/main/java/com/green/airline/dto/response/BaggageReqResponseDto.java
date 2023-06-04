package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class BaggageReqResponseDto {

	private Integer id;
	private String section;
	private String gradeId;
	private String freeAllowance;
	private Integer broId;
	private Integer routeId;
	private Integer baggageId;
	private Integer breId;
	private Integer amount;
	private String memberId;
	private Timestamp departureDate;
	private String ticketId;
	private String departure;
	private String destination;
	private Integer seatCount;
	private String seatGradeName;

	public String departureDateFormat() {
		return TimestampUtil.dateTimeToString(departureDate);
	}
}
