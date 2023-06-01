package com.green.airline.dto.response;

import lombok.Data;

/**
 * @author 서영
 * 연도/월별 개수를 구할 때 사용하는 Dto
 * 대시보드에서 사용함
 */
@Data
public class CountByYearAndMonthDto {

	private Integer year;
	private Integer month;
	private Integer count;
	
}
