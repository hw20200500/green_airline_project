package com.green.airline.dto.response;

import lombok.Data;

@Data
public class InFlightServiceResponseDto {

	private Integer id;
	private String name;
	private String description;
	private String keyword;
	private Integer flightHours;
	private String iconImage;
	private String detailImage;
	private String image;
	
}
