package com.green.airline.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResponseDTO<T> {

	private int statusCode;
	private String code;
	private String message;
	private String resultCode;
	private T data;
	
}
