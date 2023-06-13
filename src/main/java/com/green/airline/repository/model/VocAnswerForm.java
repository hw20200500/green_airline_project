package com.green.airline.repository.model;

import lombok.Data;

/**
 * @author 서영
 * 고객의 말씀 답변 양식
 */
@Data
public class VocAnswerForm {

	private Integer id;
	private String type;
	private String content;
	
}
