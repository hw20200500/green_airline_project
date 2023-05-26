package com.green.airline.dto.kakao;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 서영
 * 환불 요청 시 반환받는 Dto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class) 
public class RefundResponseDto {

	private String aid;
	private String tid;
	private String cid;
	private String status;
	private String partnerOrderId;
	private String partnerUserId;
	private String paymentMethodType;
	private Integer quantity;
	private ApprovedCancelAmountDto approvedCancelAmount;
	private CancelAvailableAmountDto cancelAvailableAmount;
	private String createdAt;
	
}
