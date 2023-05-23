package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Ticket;

@Mapper
public interface TicketRepository {

	/**
	 * @author 서영
	 * id로 티켓 조회
	 */
	public Ticket selectById(String id);
	
	/**
	 * @author 서영
	 * 티켓 생성
	 */
	public Integer insert(Ticket ticket);
	
	/**
	 * @author 서영
	 * 티켓 삭제
	 */
	public Integer deleteById(String id);
	
	/**
	 * @author 서영
	 * 해당 유저가 예매한 티켓들을 최근순으로 조회
	 */
	public List<Ticket> selectByUserIdOrderByDate(String memberId);
	
}
