package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.interfaces.InFlightServiceRepository;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightMealDetail;
import com.green.airline.repository.model.InFlightService;

@Service
public class InFlightSvService {

	@Autowired
	private InFlightServiceRepository inFlightServiceRepository;

	public List<InFlightService> readInFlightService() {
		List<InFlightService> inFlightServices = inFlightServiceRepository.selectInFlightService();

		return inFlightServices;
	}

	public List<InFlightService> readInFlightServiceByName(String keyword) {
		keyword = "%" + keyword + "%";
		List<InFlightService> inFlightServices = inFlightServiceRepository.selectInFlightServiceByName(keyword);
		return inFlightServices;
	}

	public List<InFlightMealResponseDto> readInFlightMeal(String type) {
		List<InFlightMealResponseDto> inFlightMeals = inFlightServiceRepository.selectInFlightMeal(type);
		return inFlightMeals;
	}

	public List<InFlightMealResponseDto> readInFlightAllMeal() {
		List<InFlightMealResponseDto> inFlightMeal = inFlightServiceRepository.selectInFlightDetailMeal();
		return inFlightMeal;
	}

	public List<InFlightMeal> readInFlightMealCategory() {
		List<InFlightMeal> inFlightMeals = inFlightServiceRepository.selectInFlightMealCategory();
		return inFlightMeals;
	}

	// 기내식 신청 테이블 조회하고 값 userId 넣기
	@Transactional
	public void createInFlightMealRequest(String memberId, String name, Integer amount) {
		// memberId로 가장 최근에 구매한 ticketId 가져오기
		InFlightMealResponseDto inFlightMealRequestDto = inFlightServiceRepository
				.selectInFlightMealRequestByUserId(memberId);
		
		// name을 검색해서 mealId 가져오기
		InFlightMealDetail inFlightMealDetailEntity = inFlightServiceRepository.selectInFlightMealDetailByName(name);
		// if문 사용해서 먼저 in flight meal request tb에서 특별식 신청 수량 조회 해서 티켓에 있는 인원수랑 비교해서 그거보다 많으면 insert 처리 막기
		// if(ticketEntity.seatCount < request meal tb에서 나온 특별식 신청 수량(좀 어려울지도?)) {// 오류 발생 + 예외처리} else {밑에 로직 처리}
		int result = inFlightServiceRepository.insertInFlightMealRequest(amount, inFlightMealDetailEntity.getMealId(), inFlightMealRequestDto.getTicketId()); 
		if(result != 1) {
			System.out.println("실패");
		}
	}
	
	// 특별 기내식 신청 전체 조회 기능 
	// memberId 기반 운항 예약 번호를 가져와 
//	public List<InFlightMealResponseDto> readInFlightMealRequest(String memberId) {
//		List<InFlightMealResponseDto> inFlightMealResponseDtos = inFlightServiceRepository.selectInFlightMealRequestByMemberId(memberId);
//		
//		return inFlightMealResponseDtos;
//	}
	
	public List<InFlightMealResponseDto> readInFlightMealSchedule(){
		List<InFlightMealResponseDto> inFlightMealResponseDtos = inFlightServiceRepository.selectInFlightScheduleByMemberId();

		return inFlightMealResponseDtos;
	}
}
