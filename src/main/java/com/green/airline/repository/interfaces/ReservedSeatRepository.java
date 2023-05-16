package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.ReservedSeat;

@Mapper
public interface ReservedSeatRepository {

	public List<ReservedSeat> selectByScheduleId(Integer scheduleId);
	
}
