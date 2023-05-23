package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.request.BaggageReqRequest;
import com.green.airline.dto.response.BaggageReqResponse;
import com.green.airline.repository.model.BaggageRequest;

@Mapper
public interface BaggageRequestRepository {

	// 수하물 신청
	int insertBaggageReq(BaggageReqRequest baggageReqRequest);
	
	// 수하물 신청 모달에 출력할 내용들
	List<BaggageReqResponse> selectBaggageReqByMemberId(String memberId);
	
	// 노선에 따른 좌석 수 갖고 오기 (갯수)
	// 근데 이거 sql문이 여러 개 나
//	BaggageReqResponse selectBaggageReqBySeatCount(String memberId, String departureDate);
	
	List<BaggageReqResponse> selectBaggageReqGroupBySection();
	
}
