package com.green.airline.repository.model;

import lombok.Data;

@Data
public class RequestMeal {

	private Integer id;
	private Integer amount;
	private Integer mealDetailId;
	private String ticketId;
	
}
