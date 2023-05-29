package com.green.airline.dto.response;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class FaqResponseDto {

	private Integer id;
	private String title;
	private String content;
	private Integer viewCount;
	private Timestamp createdAt;
	private Integer categoryId;
	private String name;

}
