package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.request.BaggageReqRequestDto;
import com.green.airline.dto.response.BaggageReqResponseDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.BaggageRequest;
import com.green.airline.utils.PagingObj;

@Mapper
public interface BaggageRequestRepository {

	// 수하물 신청
	int insertBaggageReq(BaggageRequest baggageRequest);

	// Todo 삭제
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

	// Todo 삭제
//	// 수하물 신청 초기값 세팅
//	int insertBaggageReq(BaggageReqRequestDto.InsertBaggageReqDto insertBaggageReqDto);

	// 위탁 수하물 신청 가능한 ticket 조회
	List<InFlightMealResponseDto> selectBaggageReqPossibleTicket(String memberId);

	// 페이징 처리) 매니저 위탁 수하물 신청 내역 조회 총 게시물 수 구하기
	Integer selectBaggageReqCount();

	// 매니저 위탁 수하물 신청 내역 조회
	List<InFlightMealResponseDto> selectBaggageReqForManager(PagingObj obj);

	/**
	 * @author 서영 티켓 취소/환불 시 신청 삭제
	 */
	Integer deleteByTicketId(String ticketId);

}
