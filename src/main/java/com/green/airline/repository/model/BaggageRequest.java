package com.green.airline.repository.model;

import lombok.Data;

@Data	
public class BaggageRequest {

	private Integer id;
	private Integer amount;
	private String ticketId;
	private String memberId;
	
}
