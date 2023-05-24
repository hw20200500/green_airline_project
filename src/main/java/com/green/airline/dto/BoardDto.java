package com.green.airline.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class BoardDto {

	private Integer id;
	private String title;
	private String content;
	private String userId;
	private Integer viewCount = 0;
	private Timestamp createdAt;
	private Integer heartCount = 0;
	private boolean statement;

	private MultipartFile file;

	// 원래 이미지 명
	private String originalFileName;
	// 실제 업로드 된 이미지 명
	private String uploadFileName;

	public String formatDate() {
		return TimestampUtil.dateToString(createdAt);
	}

}
