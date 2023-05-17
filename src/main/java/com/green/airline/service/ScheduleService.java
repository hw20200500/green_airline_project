package com.green.airline.service;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.ScheduleInfoResponseDto;
import com.green.airline.repository.interfaces.ScheduleRepository;

/**
 * @author 서영
 *
 */

@Service
public class ScheduleService {

	@Autowired
	private ScheduleRepository scheduleRepository;
	
	/**
	 * 항공권 옵션에 따른 스케줄 조회
	 */
	@Transactional
	public List<ScheduleInfoResponseDto> readByAirportAndDepartureDate(String departure, String destination, Date flightDate) {
		List<ScheduleInfoResponseDto> dtoList = scheduleRepository.selectByAirportAndDepartureDate(departure, destination, flightDate);
		
		return dtoList;
	}
	
}
