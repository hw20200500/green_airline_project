package com.green.airline.repository.model;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class Faq {

	private Integer id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private Integer viewCount;
	private Integer categoryId;
	
	public String dateFormat() {
		return TimestampUtil.dateTimeToString(createdAt);
	}
	
}
