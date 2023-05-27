package com.green.airline.dto.request;

import lombok.Data;

/**
 * @author 서영
 * 환불 신청 시 사용하는 Dto
 */
@Data
public class RefundDto {

	private String tid;
	private String ticketId;
	private Long paymentAmount;
	private Integer ticketType;
	private Integer scheduleType;
	private Integer adultCount;
	private Integer childCount;
	// 출발일까지 남은 일자
	private Integer dayCount;
	
}
