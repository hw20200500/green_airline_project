package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class InFlightMealResponseDto {

	private int id;
	private Integer ticket_id;
	private String ifmName;
	private String ifmdName;
	private String ifmDescription;
	private String ifmdDescription;
	private String image;
	private int mealId;
	private Integer amount;
	private Integer ticketId;
	private String name;
	private String description;
	private String memberId;
	private Integer portId;
	private Timestamp departureDate;
	private Timestamp arrivalDate;
	private Integer airplaneId;
	private Integer routeId;
	private Timestamp reservedDate;
	
	public String arrivalDateFormat() {
		return TimestampUtil.dateTimeToString(arrivalDate);
	}
	
	public String departureDateFormat() {
		return TimestampUtil.dateTimeToString(departureDate);
	}
	
	public String reservedDateFormat() {
		return TimestampUtil.dateTimeToString(reservedDate);
	}
	
}
