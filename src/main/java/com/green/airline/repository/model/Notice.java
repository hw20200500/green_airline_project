package com.green.airline.repository.model;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class Notice {

	private Integer id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private Integer categoryId;
	
	public String dateFormat() {
		return TimestampUtil.dateTimeToString(createdAt);
	}
}
