package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.dto.response.SeatStatusResponseDto;
import com.green.airline.repository.model.Seat;

@Mapper
public interface SeatRepository {

	// 특정 좌석 정보 확인
	public SeatInfoResponseDto selectSeatInfoByNameAndScheduleId(@Param("seatName") String seatName, @Param("scheduleId") Integer scheduleId);
	
	// 해당 스케줄에 운항하는 비행기의 좌석 리스트 (등급에 따라)
	public List<SeatStatusResponseDto> selectSeatListByScheduleIdAndGrade(@Param("scheduleId") Integer scheduleId, @Param("grade") String grade);
	
}
