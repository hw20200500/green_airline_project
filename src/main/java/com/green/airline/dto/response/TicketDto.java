package com.green.airline.dto.response;

import lombok.Data;

/**
 * @author 서영
 *
 */
@Data
public class TicketDto {

	private Integer id;
	private Integer adultCount;
	private Integer childCount;
	private Integer infantCount;
	private String seatGrade;
	private Integer scheduleId;
	private Integer airplaneId;
	
	public TicketDto(Integer adultCount, Integer childCount, Integer infantCount, String seatGrade,
			Integer scheduleId) {
		this.adultCount = adultCount;
		this.childCount = childCount;
		this.infantCount = infantCount;
		this.seatGrade = seatGrade;
		this.scheduleId = scheduleId;
	}
	
}
