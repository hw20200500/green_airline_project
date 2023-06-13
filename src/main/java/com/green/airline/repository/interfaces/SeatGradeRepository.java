package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.SeatGrade;

/**
 * @author 서영
 *
 */
@Mapper
public interface SeatGradeRepository {
	
	public SeatGrade selectByName(String name);
	
}