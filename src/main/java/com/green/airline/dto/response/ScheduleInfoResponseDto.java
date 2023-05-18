package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.NumberUtil;
import com.green.airline.utils.TimestampUtil;

import lombok.Data;


/**
 * @author 서영
 * 운항스케줄 관련 정보 Dto
 */
@Data
public class ScheduleInfoResponseDto {

	private Integer id;
	// 출발 날짜/시간
	private Timestamp departureDate;
	private String strDepartureDate;
	// 도착 날짜/시간
	private Timestamp arrivalDate;
	private String strArrivalDate;
	// 출발 국가/공항
	private String departureRegion;
	private String departureAirport;
	// 도착 국가/공항
	private String destinationRegion;
	private String destinationAirport;
	// 운항시간
	private String flightTime;
	// 비행기 이름
	private String airplaneName;
	
	// 이코노미 총 좌석 수
	private Integer ecTotalCount;
	// 이코노미 잔여 좌석 수
	private Integer ecCurCount;
	// 이코노미 좌석 가격
	private Long ecPrice;
	private String strEcPrice;
	
	// 비즈니스 총 좌석 수
	private Integer buTotalCount;
	// 비즈니스 잔여 좌석 수
	private Integer buCurCount;
	// 비즈니스 좌석 가격
	private Long buPrice;
	private String strBuPrice;
	
	// 퍼스트 총 좌석 수
	private Integer fiTotalCount;
	// 퍼스트 잔여 좌석 수
	private Integer fiCurCount;
	// 퍼스트 좌석 가격
	private Long fiPrice;
	private String strFiPrice;
	
	// 날짜 세팅
	public void formatDate() {
		strDepartureDate = TimestampUtil.timeToString(departureDate);
		strArrivalDate = TimestampUtil.timeToString(arrivalDate);
	}
	
	public void formatMoney() {
		strEcPrice = NumberUtil.numberFormat(ecPrice);
		strBuPrice = NumberUtil.numberFormat(buPrice);
		strFiPrice = NumberUtil.numberFormat(fiPrice);
	}
	
}
