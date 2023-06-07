package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Airport;

/**
 * @author 서영
 *
 */
@Mapper
public interface AirportRepository {

	public List<Airport> selectAll();
	
	// 자동 완성에 사용할 공항 리스트
	public List<Airport> selectByLikeName(String searchName);
	
	// 공항 위치 정보 - 지역만
	public List<Airport> selectRegion();
	
	// 공항 위치 정보 - 지역에 해당하는 공항만
	public List<Airport> selectByRegion(String region);
	
}