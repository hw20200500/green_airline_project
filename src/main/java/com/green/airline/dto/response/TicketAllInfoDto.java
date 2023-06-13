package com.green.airline.dto.response;

import java.sql.Timestamp;
import java.util.Date;

import com.green.airline.utils.NumberUtil;
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
	private Long amount;
	private Integer status;
	private Integer reqStatus;
	private Integer scheduleType;
	private Integer paymentType;
	
	
	// 출발일이 현재보다 이전이라면 || 이미 환불되었다면 false -> 환불 신청 불가능
	// 출발일이 현재보다 이후라면 true -> 환불 신청 가능
	public boolean checkRefundable() {
		Timestamp now = new Timestamp(System.currentTimeMillis());
		
		if (departureDate.before(now) || status == 2) {
			return false;
		} else {
			return true;
		}
			
	}
	
	public String formatAmount() {
		return NumberUtil.numberFormat(amount);
	}



	public String formatDepartureDate() {
		return TimestampUtil.dateToString(departureDate);
	}
	
	public String formatDepartureDate2() {
		return TimestampUtil.dateTimeToString(departureDate);
	}
	
	public String formatArrivalDate() {
		return TimestampUtil.dateTimeToString(arrivalDate);
	}
	public String formatArrivalDate2() {
		return TimestampUtil.dateToString(arrivalDate);
	}
	
	public String formatReservedDate() {
		return TimestampUtil.dateTimeToString(reservedDate);		
	}
	
}
