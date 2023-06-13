package com.green.airline.repository.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User {

	private String id;
	private String password;
	private String userRole;
	private Timestamp joinAt;
	private Timestamp withdrawAt;
	private Integer status;
	
}