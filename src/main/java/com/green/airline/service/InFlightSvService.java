package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.request.InFlightMealRequestDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.interfaces.InFlightServiceRepository;
import com.green.airline.repository.model.InFlightMeal;
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
	public InFlightMealRequestDto readInFlightMealRequestByUserId(Integer memberId) {
		InFlightMealRequestDto inFlightMealRequestDto = inFlightServiceRepository
				.selectInFlightMealRequestByUserId(memberId);
		System.out.println(inFlightMealRequestDto);
		int result = inFlightServiceRepository.insertInFlightMealRequest();
		System.out.println(result);
		return inFlightMealRequestDto;
	}
}
