package com.green.airline.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResponseDto<T> {

	private int statusCode;
	private int code;
	private String message;
	private String resultCode;
	private T data;
	
}
