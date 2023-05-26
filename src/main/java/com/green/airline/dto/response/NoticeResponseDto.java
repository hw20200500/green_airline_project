package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class NoticeResponseDto {

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
	private String name;
	
	public String dateFormat() {
		return TimestampUtil.dateTimeToString(createdAt);
	}
	
}
