package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;
import lombok.Data;

@Data
public class InFlightMealResponseDto {

	private Integer id;
	private String ticketId;
	private String ifmName;
	private String ifmdName;
	private String ifmDescription;
	private String ifmdDescription;
	private String iconImage;
	private String detailImage;
	private Integer mealId;
	private Integer amount; 
	private String name;
	private String description;
	private String memberId;
	private Integer portId;
	private Timestamp departureDate;
	private Timestamp arrivalDate;
	private Integer airplaneId;
	private Integer routeId;
	private Timestamp reservedDate;
	private Integer seatCount;
	private String seatGradeName;
	private String image;
	private String departure;
	private String destination;
	private String rmAmount;
	
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
