package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.repository.model.Route;

@Mapper
public interface RouteRepository {

	// 기내 서비스 조회에 사용할 도착지, 출발지 조회 기능
	public Route selectByDestAndDepa(
			@Param("destination") String destination,@Param("departure") String departure);
	
}
