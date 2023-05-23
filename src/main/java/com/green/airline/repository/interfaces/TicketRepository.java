package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Ticket;

@Mapper
public interface TicketRepository {

	/**
	 * @author 서영
	 * id로 티켓 조회
	 */
	public Ticket selectById(Integer id);
	
	/**
	 * @author 서영
	 * 티켓 생성
	 */
	public Integer insert(Ticket ticket);
	
	
}
