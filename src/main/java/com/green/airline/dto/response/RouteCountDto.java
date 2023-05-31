package com.green.airline.dto.response;

import lombok.Data;

/**
 * @author 서영
 * 노선 이용 탑승객 수를 담는 Dto
 * 대시보드에서 사용
 */
@Data
public class RouteCountDto {

	private String departure;
	private String destination;
	private Integer count;
	
}
