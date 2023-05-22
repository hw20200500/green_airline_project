package com.green.airline.dto.request;

import lombok.Data;

/**
 * @author 서영
 * 결제에 필요한 데이터 담기
 */
@Data
public class PaymentDto {

	// 수량 (왕복 : 2 / 편도 : 1)
	private String quantity;
	// 총액
	private String totalAmount;
}
