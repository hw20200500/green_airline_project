package com.green.airline.dto.request;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeRequestDto {

	private int id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private int categoryId;
	private String keyword;
	
}
