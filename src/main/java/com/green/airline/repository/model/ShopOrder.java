package com.green.airline.repository.model;

import lombok.Data;

@Data
public class ShopOrder {

	private int id;
	private int amount;
	private int productId;
	private String memberId;
	
}
