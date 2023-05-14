package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightService;

@Mapper
public interface InFlightServiceRepository {

	// 기내 서비스 출력 기능
	List<InFlightService> selectInFlightService();

	// 기내 서비스 검색 기능
	List<InFlightService> selectInFlightServiceByName(String keyword);
	
	// 기내식 조회 기능
	List<InFlightMeal> selectInFlightMeal();
}
