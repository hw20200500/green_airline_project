package com.green.airline.dto.request;

import java.util.ArrayList;
import java.util.List;

import com.green.airline.dto.response.TicketDto;
import com.green.airline.repository.model.Ticket;

import lombok.Data;

/**
 * @author 서영
 * 좌석 선택 전, 스케줄id, 좌석 수(성인/소아/유아), 좌석 등급을 받는 Dto
 * 
 */
@Data
public class TicketOptionDto {
	// input으로 받아오는 값
	// 여정순서_scheduleId_seatGrade_ageType1_ageType2_ageType3
	// 왕복 시 1, 2 둘다 사용 (편도는 1만 사용)
	private String schedule1;
	private String schedule2;
	
	// 값 세팅
	public List<TicketDto> setVariables() {
		List<TicketDto> resultList = new ArrayList<>();
		
		String[] arr = schedule1.split("_");
		Integer ageType1 = Integer.parseInt(arr[3]);
		Integer ageType2 = Integer.parseInt(arr[4]);
		Integer ageType3 = Integer.parseInt(arr[5]);
		Integer scheduleId1 = Integer.parseInt(arr[1]);
		String seatGrade1 = arr[2];
		TicketDto ticket1 = new TicketDto(ageType1, ageType2, ageType3, seatGrade1, scheduleId1);
		resultList.add(ticket1);
		
		// 왕복이라면
		if (!schedule2.equals("0")) {
			String[] arr2 = schedule2.split("_");
			Integer scheduleId2 = Integer.parseInt(arr2[1]);
			String seatGrade2 = arr2[2];
			TicketDto ticket2 = new TicketDto(ageType1, ageType2, ageType3, seatGrade2, scheduleId2);
			resultList.add(ticket2);
		}
		return resultList;
	}
	
}
