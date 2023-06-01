package com.green.airline.repository.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class User {

	private String id;
	private String password;
	private String userRole;
	private Timestamp joinAt;
	private Timestamp withdrawAt;
	private Integer status;
	
}