package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.request.BaggageReqRequestDto;
import com.green.airline.dto.response.BaggageReqResponseDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.interfaces.BaggageRequestRepository;
import com.green.airline.repository.model.BaggageRequest;
import com.green.airline.utils.PagingObj;

@Service
public class BaggageRequestService {

	@Autowired
	private BaggageRequestRepository baggageRequestRepository;

	// Todo
	// memberId, section, gradeId 무조건 갖고 와야 함. -- baggage_request_tb 를 기준 테이블로 위탁
	// 수하물, memberId 갖고 오기
	// 좌석 등급에 따른 무료 수하물 허용량을 적어줘야 할 듯 -- checked_baggage_tb, baggage_request_tb
	// where memberId
	// memberId를 갖고 와서 예약 노선 보여줘야 함. (화면)
	// 갯수, 무게 갖고 와야 함.

	// Todo2
	// 수하물 추가 해야 함.

	// 수하물 신청 모달에 출력할 내용들
	public List<BaggageReqResponseDto> readBaggageReqByMemberId(String memberId) {
		List<BaggageReqResponseDto> baggageReqResponses = baggageRequestRepository.selectBaggageReqByMemberId(memberId);

		return baggageReqResponses;
	}

//	// 노선에 따른 좌석 수 갖고 오기 (갯수) -> ApiController 탐
//	public BaggageReqResponse readBaggageReqBySeatCount(String memberId, String departureDate) {
//		// departureDate를 기준으로 한다.
//		BaggageReqResponse baggageReqResponse = baggageRequestRepository.selectBaggageReqBySeatCount(memberId,
//				departureDate);
//		return baggageReqResponse;
//	}

	// 수정 예상
	// Todo
	@Transactional
	public int updateBaggageReq(BaggageReqRequestDto baggageReqRequest) {
		int resultCnt = baggageRequestRepository.updateBaggageReq(baggageReqRequest);
		if (resultCnt == 1) {
			System.out.println("수정 성공");
		}

		return resultCnt;
	}

	public List<BaggageReqResponseDto> readBaggageReqGroupBySection() {
		List<BaggageReqResponseDto> baggageReqResponses = baggageRequestRepository.selectBaggageReqGroupBySection();
		return baggageReqResponses;
	}

	// 신청 삭제 취소
	public int deleteBaggageReqById(Integer id) {
		int resultCnt = baggageRequestRepository.deleteBaggageReqById(id);
		if (resultCnt == 1) {
			System.out.println("삭제 성공");
		}
		return resultCnt;
	}

	public List<BaggageReqResponseDto> readBaggageReqByMemberIdAndAmount(String memberId) {
		List<BaggageReqResponseDto> baggageReqResponseDtos = baggageRequestRepository
				.selectBaggageReqByMemberIdAndAmount(memberId);
		return baggageReqResponseDtos;
	}

	// 수하물 신청
	public int createBaggageReq(BaggageRequest baggageRequest) {
		int resultCnt = baggageRequestRepository.insertBaggageReq(baggageRequest);
		if (resultCnt == 1) {
			System.out.println("insert 성공");
		}
		return resultCnt;
	}

	public Integer readBaggageReqCount() {
		Integer resultCnt = baggageRequestRepository.selectBaggageReqCount();
		return resultCnt;
	}

	public List<InFlightMealResponseDto> readBaggageReqPossibleTicket(String memberId) {
		List<InFlightMealResponseDto> flightMealResponseDtos = baggageRequestRepository
				.selectBaggageReqPossibleTicket(memberId);
		return flightMealResponseDtos;
	}

	public List<InFlightMealResponseDto> readBaggageReqForManager(PagingObj obj) {
		List<InFlightMealResponseDto> inFlightMealResponseDtos = baggageRequestRepository
				.selectBaggageReqForManager(obj);
		return inFlightMealResponseDtos;
	}

}
