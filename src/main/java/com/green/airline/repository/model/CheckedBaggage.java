package com.green.airline.repository.model;

import lombok.Data;

@Data
public class CheckedBaggage {

	private Integer id;
	private String section;
	private String gradeId;
	private String freeAllowance;
	
}
