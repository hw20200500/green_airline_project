package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

/**
 * @author 서영
 * 고객의 말씀 게시글 관련 정보
 */
@Data
public class VocInfoDto {

	private Integer id;
	private String phoneNumber;
	private String email;
	private String type;
	private Integer categoryId;
	private String categoryName;
	private String title;
	private String content;
	private String memberId;
	private String ticketId;
	private Timestamp createdAt;
	private int vocCount;
	
	// 답변
	private Integer answerId;
	private String answerContent;
	private Timestamp answerCreatedAt;
	private int answerCount;
	
	public String formatCreatedAt() {
		return TimestampUtil.dateTimeToString(createdAt);
	}
	
}
