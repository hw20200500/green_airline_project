package com.green.airline.utils;

import java.util.List;

import com.green.airline.dto.response.ScheduleInfoResponseDto;
import com.green.airline.dto.response.SeatPriceDto;
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
	
	// 좌석 가격/개수 세팅 메서드
	public static ScheduleInfoResponseDto setSeatPriceAndCount(ScheduleInfoResponseDto schedule, SeatPriceDto seatPriceDto, 
											List<SeatStatusResponseDto> eSeatList, List<SeatStatusResponseDto> bSeatList, List<SeatStatusResponseDto> fSeatList) {
		schedule.setEcPrice(seatPriceDto.getEconomyPrice());
		schedule.setBuPrice(seatPriceDto.getBusinessPrice());
		schedule.setFiPrice(seatPriceDto.getFirstPrice());
		
		// 해당 스케줄에 운항하는 비행기의 전체 이코노미 좌석 수
		Integer eTotalCount = eSeatList.size();
		schedule.setEcTotalCount(eTotalCount);
		
		// 현재 예약 가능한 이코노미 좌석 수
		Integer eCurCount = TicketUtil.currentSeatCount(eTotalCount, eSeatList);
		schedule.setEcCurCount(eCurCount);
		
		// 해당 스케줄에 운항하는 비행기의 전체 비즈니스 좌석 수
		Integer bTotalCount = bSeatList.size();
		schedule.setBuTotalCount(bTotalCount);
		
		// 현재 예약 가능한 비즈니스 좌석 수
		Integer bCurCount = TicketUtil.currentSeatCount(bTotalCount, bSeatList);
		schedule.setBuCurCount(bCurCount);
		
		// 해당 스케줄에 운항하는 비행기의 전체 퍼스트 좌석 수
		Integer fTotalCount = fSeatList.size();
		schedule.setFiTotalCount(fTotalCount);
		
		// 현재 예약 가능한 퍼스트 좌석 수
		Integer fCurCount = TicketUtil.currentSeatCount(fTotalCount, fSeatList);
		schedule.setFiCurCount(fCurCount);
		
		return schedule;
	}
	
	// 티켓 가격 Dto에 좌석 등급 넣으면 그에 해당하는 가격 반환
	public static Long seatPriceByGrade(SeatPriceDto seatPriceDto, String grade) {
		if (grade.equals("이코노미")) {
			return seatPriceDto.getEconomyPrice();
		} else if (grade.equals("비즈니스")) {
			return seatPriceDto.getBusinessPrice();
		} else {
			return seatPriceDto.getFirstPrice();
		}
	}
	
	
	
}
