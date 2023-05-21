package com.green.airline.repository.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Passenger {

	private String name;
	private String gender;
	private Date birthDate;
	private Integer ticketId;
	
}
