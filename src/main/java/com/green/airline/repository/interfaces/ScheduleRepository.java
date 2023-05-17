package com.green.airline.repository.interfaces;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.ScheduleInfoResponseDto;

/**
 * @author 서영
 */
@Mapper
public interface ScheduleRepository {

	// 항공권 옵션에 따른 운항 스케줄 조회
	public List<ScheduleInfoResponseDto> selectByAirportAndDepartureDate(@Param("departure") String departure, @Param("destination") String destination, @Param("flightDate") Date flightDate);
	
	
}
