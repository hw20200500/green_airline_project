package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.TicketPrice;

@Mapper
public interface TicketPriceRepository {

	public TicketPrice selectByHours(Integer flightHours);
	
}
