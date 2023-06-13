package com.green.airline.dto.request;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeRequestDto {

	private Integer id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private Integer categoryId;
	
}
