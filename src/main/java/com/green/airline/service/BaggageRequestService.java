package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.request.BaggageReqRequest;
import com.green.airline.dto.response.BaggageReqResponse;
import com.green.airline.repository.interfaces.BaggageRequestRepository;

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
	public List<BaggageReqResponse> readBaggageReqByMemberId(String memberId) {
		List<BaggageReqResponse> baggageReqResponses = baggageRequestRepository.selectBaggageReqByMemberId(memberId);

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
	public void createBaggageReq(BaggageReqRequest baggageReqRequest) {
		baggageRequestRepository.insertBaggageReq(baggageReqRequest);
	}

	public List<BaggageReqResponse> readBaggageReqGroupBySection() {
		List<BaggageReqResponse> baggageReqResponses = baggageRequestRepository.selectBaggageReqGroupBySection();
		return baggageReqResponses;
	}

}
