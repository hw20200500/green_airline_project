package com.green.airline.dto;

import java.sql.Timestamp;

import javax.servlet.http.HttpSession;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class BoardDto {
	
	private HttpSession session;
	
	private Integer id;
	private String title;
	private String content;
	private String userId;
	private Integer viewCount = 0;
	private Timestamp createdAt;
	private Integer heartCount = 0;
	private boolean statement;

	public String formatDate() {
		return TimestampUtil.dateToString(createdAt);
	}

}
