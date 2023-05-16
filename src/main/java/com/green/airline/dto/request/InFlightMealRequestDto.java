package com.green.airline.dto.request;

import lombok.Data;

@Data
public class InFlightMealRequestDto {

	private Integer id;
	private Integer amount;
	private Integer mealId;
	private Integer ticketId;
	private Integer name;
	private Integer description;
	private Integer memberId;
	
}
