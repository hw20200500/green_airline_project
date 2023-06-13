package com.green.airline.repository.model;

import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class Voc {

	private Integer id;
	@NotBlank
	private String phoneNumber;
	@NotBlank
	private String email;
	private String type;
	@NotBlank
	private String title;
	@NotBlank
	private String content;
	private Integer categoryId;
	private String memberId;
	private String ticketId;
	private Timestamp createdAt;
	
}
