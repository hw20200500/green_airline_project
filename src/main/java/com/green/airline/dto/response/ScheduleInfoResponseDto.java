package com.green.airline.dto.response;

import java.sql.Timestamp;

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
	// 도착 날짜/시간
	private Timestamp arrivalDate;
	// 출발 국가/공항
	private String dapartureNation;
	private String departureAirport;
	// 도착 국가/공항
	private String destinationNation;
	private String destinationAirport;
	// 운항시간
	private String flightTime;
	// 비행기 이름
	private String airplaneName;
	
	
	
	
	
}
