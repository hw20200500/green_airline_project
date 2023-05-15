package com.green.airline.repository.model;

import lombok.Data;

@Data
public class RequestMeal {

	private int id;
	private int amount;
	private int mealId;
	private int ticketId;
	
}
