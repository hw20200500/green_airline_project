package com.green.airline.repository.model;

import lombok.Data;

@Data
public class Voc {

	private Integer id;
	private String phoneNumber;
	private String email;
	private String type;
	private String title;
	private String content;
	private Integer categoryId;
	private String memberId;
	private String ticketId;
	
}
