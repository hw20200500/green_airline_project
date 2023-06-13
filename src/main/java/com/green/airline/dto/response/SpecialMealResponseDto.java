package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class SpecialMealResponseDto {

	private Integer rmId;
	private Integer rmAmount;
	private String memberId;
	private String ticketId;
	private String ifmName;
	private String departure;
	private String destination;
	private Timestamp arrivalDate;
	private Timestamp departureDate;
	private String ifmdName;
	private String name;
	
	public String arrivalDateFormat() {
		return TimestampUtil.dateTimeToString(arrivalDate);
	}
	
	public String departureDateFormat() {
		return TimestampUtil.dateTimeToString(departureDate);
	}
	
}
