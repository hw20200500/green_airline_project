package com.green.airline.repository.model;

import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;

import lombok.Data;

/**
 * @author 서영
 * 고객의 말씀 답변
 */
@Data
public class VocAnswer {

	private Integer id;
	@NotBlank
	private String content;
	private Timestamp createdAt;
	private Integer vocId;
	
}
