package com.green.airline.dto.response;

import lombok.Data;


/**
 * @author 서영
 * 좌석의 예약 여부를 보여주기 위함
 */
@Data
public class SeatStatusResponseDto {

	private Integer airplaneId;
	private String name;
	private String grade;
	
	private Boolean status;
	
}
