package com.green.airline.handler.exception;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApiErrorResponse {
	private int statusCode;
	private String code;
	private String message;
	private String resultCode;
	private List<ExceptionFieldMessage> exceptionFieldMessages;
}