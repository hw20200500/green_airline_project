package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.repository.interfaces.SeatGradeRepository;
import com.green.airline.repository.interfaces.SeatRepository;
import com.green.airline.repository.interfaces.TicketPriceRepository;
import com.green.airline.repository.model.SeatGrade;
import com.green.airline.repository.model.TicketPrice;
import com.green.airline.utils.NumberUtil;


/**
 * @author 서영
 *
 */
@Service
public class SeatService {
	
	@Autowired
	private SeatRepository seatRepository;
	
	@Autowired
	private TicketPriceRepository ticketPriceRepository;
	
	@Autowired
	private SeatGradeRepository seatGradeRepository;

	/**
	 * @return 특정 좌석 정보 (가격 포함)
	 */
	public SeatInfoResponseDto readSeatInfoByNameAndScheduleId(String seatName, Integer scheduleId) {
		// 좌석 가격을 제외한 좌석 정보가 담김
		SeatInfoResponseDto seatInfoDto = seatRepository.selectSeatInfoByNameAndScheduleId(seatName, scheduleId);
		
		// 좌석 가격 계산
		// 운항시간 중 시간만 가져오기
		Integer hours = Integer.parseInt(seatInfoDto.getFlightTime().split("시간")[0]);
		
		// 이코노미 기준 좌석 가격
		TicketPrice ticketPriceEntity = ticketPriceRepository.selectByHours(hours);
		
		// 좌석 등급에 따른 가격 배수
		SeatGrade seatGradeEntity = seatGradeRepository.selectByName(seatInfoDto.getSeatGrade());
		
		// 좌석 가격
		Long seatPrice = ticketPriceEntity.getPrice() * seatGradeEntity.getPriceMultiple();
		String price = NumberUtil.numberFormat(seatPrice);
		seatInfoDto.setSeatPrice(price);
		
		return seatInfoDto;
	}
	
}
