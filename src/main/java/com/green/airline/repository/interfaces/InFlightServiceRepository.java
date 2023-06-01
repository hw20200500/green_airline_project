package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.InFlightServiceResponseDto;
import com.green.airline.dto.response.SpecialMealResponseDto;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightMealDetail;
import com.green.airline.repository.model.InFlightService;

@Mapper
public interface InFlightServiceRepository {

	// 기내 서비스 출력 기능
	List<InFlightService> selectInFlightService();

	// 기내 서비스 검색 기능
	List<InFlightService> selectInFlightServiceByName(String keyword);
	
	// 특별 기내식 상세 정보 name 기반 특별 기내식 조회 기능 
	List<InFlightMealResponseDto> selectInFlightMeal(String name);
	
	// 특별 기내식 조회 기능
	List<InFlightMealResponseDto> selectInFlightDetailMeal();
	
	// 특별 기내식 조회 기능
	List<InFlightMeal> selectInFlightMealCategory();
	
	// memberId 기반 특별 기내식 신청 조회 기능  
	InFlightMealResponseDto selectInFlightMealRequestByUserId(@Param("memberId") String memberId, @Param("departureDate") String departureDate);
	
	// name 기반 상세 특별 기내식 조회 기능
	InFlightMealDetail selectInFlightMealDetailByName(String name);
	
	// 특별 기내식 신청 기능 (데이터 삽입)
	int insertInFlightMealRequest(@Param("amount") Integer amount,@Param("mealId") Integer mealId,@Param("ticketId") String ticketId);
	
	// 특별 기내식 신청 전체 조회 기능
	List<InFlightMealResponseDto> selectInFlightMealRequestByMemberId(String memberId);
	
	// 특별 기내식을 신청한 사람의 스케줄 조회 기능
	List<InFlightMealResponseDto> selectInFlightScheduleByMemberId(String memberId);
	
	// 특별 기내식 신청할 때 좌석 수를 동적으로 가져가기 위해 사용
	InFlightMealResponseDto selectInFlightRequestForSeatCount(@Param("memberId") String memberId, @Param("departureDate") String departureDate);
	
	// 기내 서비스 조회시 운항 시간별 서비스 조회를 하기 위해 사용
	List<InFlightServiceResponseDto> selectAvailableServiceByFlightHours(String flightHours);
	
	// 마이페이지 특별 기내식 신청 내역 조회
	List<SpecialMealResponseDto> selectRequestMealByMemberId(String memberId);
	
	// 마이페이지 특별 기내식 신청 내역 조회 ) memberId, ticketId 기반 조회
//	InFlightServiceResponseDto selectTicketByIdAndTicketId(String memberId, String ticketId);
	
	// id 기반 기내식 신청 취소 
	int deleteRequestMealById(Integer id);
	
}
 

