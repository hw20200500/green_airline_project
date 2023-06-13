package com.green.airline.dto.kakao;

import lombok.Data;

@Data
public class PayApproveDto {

	private String aid;
	private String tid;
	private AmountDto amount;
	
}
