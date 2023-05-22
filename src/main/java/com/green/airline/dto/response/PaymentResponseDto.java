package com.green.airline.dto.response;

import java.sql.Timestamp;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

@Data
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class) 
public class PaymentResponseDto {

	private String tid;
	private String nextRedirectPcUrl;
	private String androidAppScheme;
	private Timestamp createdAt;
	
}
