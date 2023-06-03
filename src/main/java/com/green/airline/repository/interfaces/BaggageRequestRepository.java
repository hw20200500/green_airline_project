package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.request.BaggageReqRequestDto;
import com.green.airline.dto.response.BaggageReqResponseDto;
import com.green.airline.repository.model.BaggageRequest;

@Mapper
public interface BaggageRequestRepository {

	// 수하물 신청
	int updateBaggageReq(BaggageReqRequestDto baggageReqRequest);
	
	// 수하물 신청 모달에 출력할 내용들
	List<BaggageReqResponseDto> selectBaggageReqByMemberId(String memberId);
	
	// 노선에 따른 좌석 수 갖고 오기 (갯수)
	// 근데 이거 sql문이 여러 개 나
//	BaggageReqResponse selectBaggageReqBySeatCount(String memberId, String departureDate);
	
	List<BaggageReqResponseDto> selectBaggageReqGroupBySection();
	
	// 신청 취소 삭제
	int deleteBaggageReqById(Integer id);
	
	// 수하물 신청 내역 조회 amount가 0이 아닐 때 신청 내역이 없습니다. 출력
	List<BaggageReqResponseDto> selectBaggageReqByMemberIdAndAmount(String memberId);
	
}
