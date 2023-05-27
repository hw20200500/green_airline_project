package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Passenger;

/**
 * @author 서영
 *
 */
@Mapper
public interface PassengerRepository {

	public Integer insert(Passenger passenger);
	
	public List<Passenger> selectByTicketId(String ticketId);
	
	public Integer deleteByTicketId(String ticketId);
}
