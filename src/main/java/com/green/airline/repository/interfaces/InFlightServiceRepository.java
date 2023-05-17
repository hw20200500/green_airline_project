package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightMealDetail;
import com.green.airline.repository.model.InFlightService;

@Mapper
public interface InFlightServiceRepository {

	// 기내 서비스 출력 기능
	List<InFlightService> selectInFlightService();

	// 기내 서비스 검색 기능
	List<InFlightService> selectInFlightServiceByName(String keyword);
	
	// 특별 기내식 조회 기능
	List<InFlightMealResponseDto> selectInFlightMeal(String name);
	
	// 특별 기내식 조회 기능
	List<InFlightMealResponseDto> selectInFlightDetailMeal();
	
	// 특별 기내식 조회 기능
	List<InFlightMeal> selectInFlightMealCategory();
	
	// memberId 기반 특별 기내식 신청 조회 기능  
	InFlightMealResponseDto selectInFlightMealRequestByUserId(String memberId);
	
	// name 기반 상세 특별 기내식 조회 기능
	InFlightMealDetail selectInFlightMealDetailByName(String name);
	
	// 특별 기내식 신청 기능 (데이터 삽입)
	int insertInFlightMealRequest(@Param("amount") Integer amount,@Param("mealId") Integer mealId,@Param("ticketId") Integer ticketId);
	
	// 특별 기내식 신청 전체 조회 기능
	List<InFlightMealResponseDto> selectInFlightMealRequestByMemberId(String memberId);
	
	// 특별 기내식을 신청한 사람의 스케줄 조회 기능
	List<InFlightMealResponseDto> selectInFlightScheduleByMemberId();
}
 