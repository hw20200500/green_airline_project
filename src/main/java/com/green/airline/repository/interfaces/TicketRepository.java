package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.repository.model.Ticket;

@Mapper
public interface TicketRepository {

	/**
	 * @author 서영 id로 티켓 조회
	 */
	public Ticket selectById(String id);

	/**
	 * @author 서영 티켓 생성
	 */
	public Integer insert(Ticket ticket);

	/**
	 * @author 서영 티켓 삭제
	 */
	public Integer deleteById(String id);

	/**
	 * @author 서영 해당 유저가 예매한 티켓들을 최근순으로 조회 (결제 내역 추가용 간단한 정보들만)
	 */
	public List<Ticket> selectByUserIdOrderByDate(String memberId);

	/**
	 * @author 서영 해당 티켓에 대한 결제 정보를 포함한 모든 정보 반환 type : 1 -> 첫 번째 일정 type : 2 -> 두 번째
	 *         일정
	 */
	public TicketAllInfoDto selectAllInfoById(@Param("id") String id, @Param("type") Integer type);

	/**

	 * @author 서영
	 * 해당 유저의 티켓 구매 내역들을 최근순으로 조회
	 */
	public List<TicketAllInfoDto> selectTicketListByMemberId(String memberId);
	
	/**
	 * @author 서영
	 * 해당 유저의 티켓 구매 내역들을 최근순으로 조회
	 */
	public List<TicketAllInfoDto> selectTicketListByMemberIdLimit(@Param("memberId") String memberId, @Param("index") Integer index);
	
	/**
	 * @author 서영
	 * 예약날짜를 결제 성공 시점으로 갱신

	 */
	public Integer updateReservedDate(String id);

	/**
	 * @author 정다운 마일리지 신청 리스트
	 * 
	 */
	public List<TicketAllInfoDto> selectTicketList(@Param("memberId") String memberId, @Param("type") String type);
	/**
	 * @author 정다운
	 * 마일리지 신청 페이지에 티켓정보 출력
	 * @param id
	 * @return
	 */
	public TicketAllInfoDto selectByTicketId(String id);
	
	public int inserticketIdById(TicketAllInfoDto ticketAllInfoDto);
	
	/**
	 * @author 서영
	 * 모든 티켓 구매 내역들을 최근순으로 조회
	 */
	public List<TicketAllInfoDto> selectTicketListAll();
	
	/**
	 * @author 서영
	 * 모든 티켓 구매 내역들을 최근순으로 조회
	 */
	public List<TicketAllInfoDto> selectTicketListAllLimit(Integer index);
	
}
