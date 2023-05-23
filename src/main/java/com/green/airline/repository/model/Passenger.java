package com.green.airline.repository.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Passenger {

	private String name;
	private String gender;
	private Date birthDate;
	private Integer ticketId;
	
}
