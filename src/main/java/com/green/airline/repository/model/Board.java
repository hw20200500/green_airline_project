package com.green.airline.repository.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import com.green.airline.utils.NumberUtil;
import com.green.airline.utils.TimestampUtil;

import lombok.Data;

@Data
public class Board {

	private Integer id;
	private String title;
	private String content;
	private String userId;
	private Integer viewCount = 0;
	private Timestamp createdAt;
	private Integer heartCount = 0;
	private double average;

	private MultipartFile file;

	// 원래 이미지 명
	private String originName;
	// 실제 업로드 된 이미지 명
	private String fileName;
	
	public String formatDate() {
		return TimestampUtil.dateToString(createdAt);
	}
	
	public String numberFormat() {
		return NumberUtil.numberFormat(viewCount);
	}
	
	// 썸네일 이미지 경로
	public String thumbnailImage() {
		return fileName == null ? "/uploadImage/a.png" : "/uploadImage/" + fileName;
	}

}