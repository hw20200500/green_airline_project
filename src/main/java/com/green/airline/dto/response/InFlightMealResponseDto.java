package com.green.airline.dto.response;

import lombok.Data;

@Data
public class InFlightMealResponseDto {

	private int id;
	private String ifmName;
	private String ifmdName;
	private String ifmDescription;
	private String ifmdDescription;
	private String image;
	private int mealId;
	
}
