package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

/**
 * @author 서영
 * 해당 티켓에 대한 결제 정보를 포함한 모든 정보를 담을 Dto
 */
@Data
public class TicketAllInfoDto {

	private String id;
	private Integer adultCount;
	private Integer childCount;
	private Integer infantCount;
	private String seatGrade;
	private String memberId;
	private Timestamp reservedDate;
	private Timestamp departureDate;
	private Timestamp arrivalDate;
	private String departure;
	private String destination;
	private String flightTime;
	private String airplaneName;
	private String tid;
	private Integer amount;
	private Integer status;
	private Integer reqStatus;
	
	public String formatDepartureDate() {
		return TimestampUtil.dateToString(departureDate).replaceAll("-", ".");
	}
	
	public String formatReservedDate() {
		return TimestampUtil.dateTimeToString(reservedDate).replaceAll("-", ".");		
	}
	
}
