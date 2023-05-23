package com.green.airline.repository.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Passenger {

	private String name;
	private String gender;
	private String birthDate;
	private String ticketId;
	
}
