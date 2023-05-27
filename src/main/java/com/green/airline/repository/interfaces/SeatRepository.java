package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.AirplaneInfoDto;
import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.dto.response.SeatStatusResponseDto;

/**
 * @author 서영
 *
 */
@Mapper
public interface SeatRepository {

	// 특정 좌석 정보 확인
	public SeatInfoResponseDto selectSeatInfoByNameAndScheduleId(@Param("seatName") String seatName, @Param("scheduleId") Integer scheduleId);
	
	// 해당 스케줄에 운항하는 비행기의 좌석 리스트 (등급에 따라)
	public List<SeatStatusResponseDto> selectSeatListByScheduleIdAndGrade(@Param("scheduleId") Integer scheduleId, @Param("grade") String grade);
	
	// 해당 비행기의 좌석 등급별 좌석 개수
	public List<AirplaneInfoDto> selectByAirplaneId(Integer airplaneId);
	
}
