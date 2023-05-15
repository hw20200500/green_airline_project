package com.green.airline.repository.model;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class Board {

	private int id;
	private String title;
	private String content;
	private String userId;
	private int viewCount;
	private Timestamp createdAt;

	public String formatDate() {

		return TimestampUtil.dateToString(createdAt);
	}

}
