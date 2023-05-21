package com.green.airline.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.response.AirplaneInfoDto;
import com.green.airline.dto.response.ScheduleInfoResponseDto;
import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.dto.response.SeatPriceDto;
import com.green.airline.dto.response.SeatStatusResponseDto;
import com.green.airline.repository.interfaces.ReservedSeatRepository;
import com.green.airline.repository.interfaces.ScheduleRepository;
import com.green.airline.repository.interfaces.SeatGradeRepository;
import com.green.airline.repository.interfaces.SeatRepository;
import com.green.airline.repository.interfaces.TicketPriceRepository;
import com.green.airline.repository.model.ReservedSeat;
import com.green.airline.repository.model.Seat;
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
	
	@Autowired
	private ReservedSeatRepository reservedSeatRepository;
	
	@Autowired
	private ScheduleRepository scheduleRepository;

	
	/**
	 * @return 해당 스케줄에서 좌석 등급별 기본 가격 정보
	 */
	public SeatPriceDto readSeatPriceByScheduleId(Integer scheduleId) {
		// 스케줄 정보
		ScheduleInfoResponseDto scheduleDto = scheduleRepository.selectDtoByScheduleId(scheduleId);
		
		// 운항시간 중 시간만 가져오기
		Integer hours = Integer.parseInt(scheduleDto.getFlightTime().split("시간")[0]);
		
		// 이코노미 기준 좌석 가격
		Long economyPrice = ticketPriceRepository.selectByHours(hours).getPrice();
		
		// 좌석 등급에 따른 가격 배수
		Integer businessPriceMultiple = seatGradeRepository.selectByName("비즈니스").getPriceMultiple();
		Integer firstPriceMultiple = seatGradeRepository.selectByName("퍼스트").getPriceMultiple();
		
		SeatPriceDto resultDto = new SeatPriceDto();
		resultDto.setEconomyPrice(economyPrice);
		resultDto.setBusinessPrice(businessPriceMultiple * economyPrice);
		resultDto.setFirstPrice(firstPriceMultiple * economyPrice);
		return resultDto;
	}
	
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
	
	/**
	 * @return 해당 스케줄에 운항하는 비행기의 좌석 리스트 (등급에 따라)
	 */
	public List<SeatStatusResponseDto> readSeatListByScheduleIdAndGrade(Integer scheduleId, String grade) {
		
		List<SeatStatusResponseDto> seatEntityList = seatRepository.selectSeatListByScheduleIdAndGrade(scheduleId, grade);
		
		// 예약된 좌석
		List<ReservedSeat> reservedSeatEntityList = reservedSeatRepository.selectByScheduleId(scheduleId);
		List<String> reservedSeatNameList = new ArrayList<>();
		reservedSeatEntityList.forEach(rs -> {
			reservedSeatNameList.add(rs.getSeatName());
		});
		
		for (SeatStatusResponseDto s : seatEntityList) {
			// 이미 예약된 좌석이라면
			if (reservedSeatNameList.contains(s.getName())) {
				s.setStatus(true);
			} else {
				s.setStatus(false);
			}
		}
		return seatEntityList;
	}
	
	/**
	 * @return 해당 비행기의 좌석 등급별 좌석 개수 + 비행기 이름
	 */
	public List<AirplaneInfoDto> readSeatCountByAirplaneId(Integer airplaneId) {
		List<AirplaneInfoDto> dtoList = seatRepository.selectByAirplaneId(airplaneId);
		return dtoList;
	}
	
}
