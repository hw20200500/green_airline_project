package com.green.airline.dto.response;

import lombok.Data;

@Data
public class NoticeResponseDto {

	private int id;
	private String title;
	private String content;
	private int categoryId;
	private String name;
	
}
