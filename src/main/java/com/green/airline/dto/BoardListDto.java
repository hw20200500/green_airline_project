package com.green.airline.dto;

import lombok.Data;

@Data
public class BoardListDto {
	
	private int id;
	private String title;
	private String content;
	private String userId;
	private Integer viewCount;

}
