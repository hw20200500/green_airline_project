package com.green.airline.dto.kakao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 서영
 * 환불 요청 관련
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CancelAvailableAmountDto {

	private Integer total;
	private Integer taxFree;
	private Integer vat;
	private Integer point;
	private Integer discount;
	private Integer greenDeposit;
}
