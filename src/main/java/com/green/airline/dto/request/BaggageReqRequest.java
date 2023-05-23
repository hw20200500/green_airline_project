package com.green.airline.dto.request;

import lombok.Data;

@Data
public class BaggageReqRequest {

	private Integer amount;
	private Integer weight;
	private Integer brId;
	private String memberId;
	
}
