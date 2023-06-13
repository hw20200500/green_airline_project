package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.DestinationCountDto;
import com.green.airline.repository.model.Route;

@Mapper
public interface RouteRepository {

	// 기내 서비스 조회에 사용할 도착지, 출발지 조회 기능
	public Route selectByDestAndDepa(
			@Param("destination") String destination,@Param("departure") String departure);

	// 많이 이용된 노선 상위 n개 
	public List<DestinationCountDto> selectGroupByDestinationLimitN(Integer limitCount);
	
	// 위탁 수하물 노선 테이블 검색
	public Route selectById(Integer id);
	
}
