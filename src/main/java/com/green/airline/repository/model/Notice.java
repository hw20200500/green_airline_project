package com.green.airline.repository.model;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class Notice {

<<<<<<< HEAD
	private Integer id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private Integer viewCount;
	private Integer categoryId;
=======
	private int id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private int categoryId;
>>>>>>> feature/board
	
	public String dateFormat() {
		return TimestampUtil.dateTimeToString(createdAt);
	}
}
