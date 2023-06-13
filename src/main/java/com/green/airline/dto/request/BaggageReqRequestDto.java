package com.green.airline.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class BaggageReqRequestDto {

	private Integer id;
	private Integer amount;
	private String ticketId;
	private String memberId;
	
	@Data
	@AllArgsConstructor
	public static class InsertBaggageReqDto {
		private Integer amount;
		private String ticketId;
		private String memberId;
	}
	
}
