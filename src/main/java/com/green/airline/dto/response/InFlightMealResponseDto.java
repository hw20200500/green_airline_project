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
	private Integer amount;
	private Integer ticketId;
	private String name;
	private String description;
	private String memberId;
	private Integer portId;
	
}
