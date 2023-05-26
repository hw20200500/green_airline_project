package com.green.airline.dto.request;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeRequestDto {

<<<<<<< HEAD
	private Integer id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private Integer categoryId;
=======
	private int id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private int categoryId;
>>>>>>> feature/board
	
}
