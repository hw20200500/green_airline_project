package com.green.airline.repository.model;

import lombok.Data;

@Data	
public class BaggageRequest {

	private Integer id;
	private Integer amount;
	private Integer weight;
	private Integer price;
	private Integer brId;
	private String memberId;
	
}
