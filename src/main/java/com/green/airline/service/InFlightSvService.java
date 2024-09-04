package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.request.InFlightReqRequestDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.InFlightServiceResponseDto;
import com.green.airline.dto.response.SpecialMealResponseDto;
import com.green.airline.enums.MealDetail;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.interfaces.InFlightServiceRepository;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightMealDetail;
import com.green.airline.repository.model.InFlightService;
import com.green.airline.utils.PagingObj;

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

	public List<InFlightMealResponseDto> readInFlightMealByName(String name) {
		System.out.println("SvInFlightMealName: "+name);
		List<InFlightMealResponseDto> inFlightMeals = inFlightServiceRepository.selectInFlightMealByName(name);
		System.out.println("SvInFlightMeal: "+inFlightMeals);
		return inFlightMeals;
	}

	public List<InFlightMealDetail> readInFlightMealByMealId(MealDetail mealDetail) {
		List<InFlightMealDetail> details = inFlightServiceRepository.selectInFlightMealByMealId(mealDetail.getMealId());
		return details;
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
	public int createInFlightMealRequest(InFlightReqRequestDto inFlightReqRequestDto) {

		// if문 사용해서 먼저 in flight meal request tb에서 특별식 신청 수량 조회 해서 티켓에 있는 인원수랑 비교해서 그거보다
		// 많으면 insert 처리 막기
		// if(ticketEntity.seatCount < request meal tb에서 나온 특별식 신청 수량(좀 어려울지도?)) {// 오류
		// 발생 + 예외처리} else {밑에 로직 처리}
		int result1 = 0;
		int result2 = 0;
		int result3 = 0;
		int result4 = 0;
		int result5 = 0;

		if (inFlightReqRequestDto.getBabyMealId() != null) {
			inFlightReqRequestDto.setMealDetailId(inFlightReqRequestDto.getBabyMealId());
			inFlightReqRequestDto.setAmount(inFlightReqRequestDto.getBabyMealAmount());
			result1 = inFlightServiceRepository.insertInFlightMealRequest(inFlightReqRequestDto);
		}
		if (inFlightReqRequestDto.getVeganMealId() != null) {
			inFlightReqRequestDto.setMealDetailId(inFlightReqRequestDto.getVeganMealId());
			inFlightReqRequestDto.setAmount(inFlightReqRequestDto.getVeganMealAmount());
			result2 = inFlightServiceRepository.insertInFlightMealRequest(inFlightReqRequestDto);
		}
		if (inFlightReqRequestDto.getLowfatMealId() != null) {
			inFlightReqRequestDto.setMealDetailId(inFlightReqRequestDto.getLowfatMealId());
			inFlightReqRequestDto.setAmount(inFlightReqRequestDto.getLowfatMealAmount());
			result3 = inFlightServiceRepository.insertInFlightMealRequest(inFlightReqRequestDto);
		}
		if (inFlightReqRequestDto.getReligionMealId() != null) {
			inFlightReqRequestDto.setMealDetailId(inFlightReqRequestDto.getReligionMealId());
			inFlightReqRequestDto.setAmount(inFlightReqRequestDto.getReligionMealAmount());
			result4 = inFlightServiceRepository.insertInFlightMealRequest(inFlightReqRequestDto);
		}
		if (inFlightReqRequestDto.getEtcMealId() != null) {
			inFlightReqRequestDto.setMealDetailId(inFlightReqRequestDto.getEtcMealId());
			inFlightReqRequestDto.setAmount(inFlightReqRequestDto.getEtcMealAmount());
			result5 = inFlightServiceRepository.insertInFlightMealRequest(inFlightReqRequestDto);
		}

		int total = result1 + result2 + result3 + result4 + result5;
		if (total < 1) {
			// 예외처리
			throw new CustomRestfullException("입력된 값이 없습니다.", HttpStatus.BAD_REQUEST);
		}
		return total;
	}

	public List<InFlightMealResponseDto> readInFlightMealSchedule(String memberId) {
		List<InFlightMealResponseDto> inFlightMealResponseDtos = inFlightServiceRepository
				.selectInFlightScheduleByMemberId(memberId);

		return inFlightMealResponseDtos;
	}

	public InFlightMealResponseDto readInFlightRequestForSeatCount(String memberId, String departureDate) {
		InFlightMealResponseDto inFlightMealResponseDto = inFlightServiceRepository
				.selectInFlightRequestForSeatCount(memberId, departureDate);

		return inFlightMealResponseDto;
	}

	// selectAvailableServiceByFlightHours
	public List<InFlightServiceResponseDto> readAvailableServiceByFlightHours(String flightHours) {
		List<InFlightServiceResponseDto> inFlightServiceResponseDto = inFlightServiceRepository
				.selectAvailableServiceByFlightHours(flightHours);

		return inFlightServiceResponseDto;
	}

	public List<SpecialMealResponseDto> readRequestMealByMemberId(String memberId) {
		List<SpecialMealResponseDto> specialMealResponseDtos = inFlightServiceRepository
				.selectRequestMealByMemberId(memberId);
		return specialMealResponseDtos;
	}

//	public InFlightServiceResponseDto readTicketByIdAndTicketId(String memberId, String ticketId) {
//		InFlightServiceResponseDto flightServiceResponseDto = inFlightServiceRepository
//				.selectTicketByIdAndTicketId(memberId, ticketId);
//		return flightServiceResponseDto;
//	}

	public void deleteRequestMealById(Integer id) {
		int resultCnt = inFlightServiceRepository.deleteRequestMealById(id);
		if (resultCnt == 1) {
			System.out.println("삭제 성공");
		}
	}
	
	public Integer readInFlightMealCount() {
		Integer resultCount = inFlightServiceRepository.selectInFlightMealCount();
		return resultCount;
	}
	
	public List<InFlightMealResponseDto> readInFlightMealForManager(PagingObj obj){
		List<InFlightMealResponseDto> inFlightMealResponseDtos = inFlightServiceRepository.selectInFlightMealForManager(obj);
		return inFlightMealResponseDtos;
	}

}
