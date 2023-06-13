package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class NoticeResponseDto {

	private int id;
	private String title;
	private String content;
	private Timestamp createdAt;
	private int categoryId;
	private String name;
	private int ncId;
	
	public String dateFormat() {
		return TimestampUtil.dateTimeToString(createdAt);
	}
	
	// 날짜만 보이게
	public String dateFormatType2() {
		return TimestampUtil.dateToString(createdAt);
	}
}
