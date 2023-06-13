package com.green.airline.dto.response;

import lombok.Data;

/**
 * @author 서영
 * 특정 연도의 월간 매출액
 */
@Data
public class MonthlySalesForChartDto {

	private Integer year;
	private Integer month;
	private Long sales;
	
}
