package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.request.ScheduleSelectDto;
import com.green.airline.dto.response.ScheduleInfoResponseDto;

/**
 * @author 서영
 */
@Mapper
public interface ScheduleRepository {

	// 항공권 옵션에 따른 운항 스케줄 조회
	public ScheduleInfoResponseDto selectByAirportAndDepartureDate(ScheduleSelectDto scheduleSelectDto);
	
	
}
