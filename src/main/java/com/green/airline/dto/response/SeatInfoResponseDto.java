package com.green.airline.dto.response;

import lombok.Data;

/**
 * @author 서영
 * 선택한 좌석 정보
 */
@Data
public class SeatInfoResponseDto {

	private Integer scheduleId;
	private String flightTime;
	private Integer airplaneId;
	private String seatName;
	private String seatGrade;
	
	// 좌석 가격은 따로 계산 (포맷팅하므로 String)
	private String seatPrice;
	
	
}