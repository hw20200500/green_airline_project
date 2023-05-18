package com.green.airline.utils;

import java.util.List;

import com.green.airline.dto.response.SeatStatusResponseDto;

/**
 * @author 서영
 * Ticket 관련 메서드
 *
 */
public class TicketUtil {

	// 예약 가능한 좌석 수 구하기
	public static Integer currentSeatCount(Integer totalCount, List<SeatStatusResponseDto> seatList) {
		Integer reservedCount = 0;
		for (SeatStatusResponseDto seat : seatList) {
			// 예약된 좌석이라면
			if (seat.getStatus() == true) {
				reservedCount++;
			}
		}
		// 현재 예약 가능한 비즈니스 좌석 수
		Integer curCount = totalCount - reservedCount;
		return curCount;
	}
	
}
