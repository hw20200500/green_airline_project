package com.green.airline.repository.interfaces;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.ScheduleInfoResponseDto;
import com.green.airline.repository.model.Schedule;

/**
 * @author 서영
 */
@Mapper
public interface ScheduleRepository {

	// 항공권 옵션에 따른 운항 스케줄 조회
	public List<ScheduleInfoResponseDto> selectByAirportAndDepartureDate(@Param("departure") String departure, @Param("destination") String destination, @Param("flightDate") Date flightDate);
	
	// id로 운항 스케줄 + 노선 조회
	public ScheduleInfoResponseDto selectDtoByScheduleId(Integer scheduleId);
	
	// id로 운항 스케줄만 조회
	public Schedule selectByScheduleId(Integer scheduleId);
}
