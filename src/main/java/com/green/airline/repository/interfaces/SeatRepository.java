package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.SeatInfoResponseDto;

@Mapper
public interface SeatRepository {

	// 특정 좌석 정보 확인
	public SeatInfoResponseDto selectSeatInfoByNameAndScheduleId(@Param("seatName") String seatName, @Param("scheduleId") Integer scheduleId);
	
}
