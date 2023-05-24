package com.green.airline.repository.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 티켓 결제 내역
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TicketPayment {

	private String tid;
	private String ticketId1;
	private String ticketId2;
	private Long amount1;
	private Long amount2;
	private Integer status1;
	private Integer status2;
	
}
