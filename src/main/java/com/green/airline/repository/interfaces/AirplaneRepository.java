package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Airplane;

/**
 * @author 서영
 *
 */
@Mapper
public interface AirplaneRepository {

	public List<Airplane> selectAll();
	
}
