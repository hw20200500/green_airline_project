package com.green.airline.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardUpdateDto {

	private Integer id;
	private String title;
	private String content;

	private MultipartFile file;

	// 원래 이미지 명
	private String originName;
	// 실제 업로드 된 이미지 명
	private String fileName;

}
