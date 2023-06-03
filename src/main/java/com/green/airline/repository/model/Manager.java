package com.green.airline.repository.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Manager {

	private String id;
	private String name;
	private String birthDate;
	private String gender;
	private String phoneNumber;
	private String email;
	
}
