package com.green.airline.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 서영
 * request용으로도 사용됨
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TicketDto {

	private String id;
	private Integer airplaneId;
	private Integer airplaneId2;
	
	private Integer adultCount;
	private Integer childCount;
	private Integer infantCount;
	
	private String seatGrade;
	private Integer scheduleId;
	private String[] seatNames;
	private Long price;
	
	private String seatGrade2;
	private Integer scheduleId2;
	private String[] seatNames2;
	private Long price2;
	
	// 결제 시
	private Integer totalAmount;
	private Integer quantity;
	private String tid; // 결제고유번호
	
	// 탑승객 정보 (연령타입_성별_이름_생년월일)
	private String[] passengerInfos;
	
	public TicketDto(Integer adultCount, Integer childCount, Integer infantCount, String seatGrade,
			Integer scheduleId) {
		this.adultCount = adultCount;
		this.childCount = childCount;
		this.infantCount = infantCount;
		this.seatGrade = seatGrade;
		this.scheduleId = scheduleId;
	}
	
}
