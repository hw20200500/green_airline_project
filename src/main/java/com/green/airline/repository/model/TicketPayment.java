package com.green.airline.repository.model;

import lombok.Data;

// 티켓 결제 내역
@Data
public class TicketPayment {

	private Integer ticketId;
	private Integer amount;
	private Integer useMiles;
	
}
