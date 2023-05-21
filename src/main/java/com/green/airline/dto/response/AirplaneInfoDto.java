package com.green.airline.dto.response;

import lombok.Data;

/**
 * @author 서영
 * 항공기 정보에서 사용할 Dto
 * 항공기 id/이름, 좌석 등급별 개수
 */
@Data
public class AirplaneInfoDto {

	private Integer id;
	private String name;
	private String grade;
	private Integer seatCount;
	
}
