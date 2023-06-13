package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.repository.interfaces.ReservedSeatRepository;
import com.green.airline.repository.model.ReservedSeat;

/**
 * @author 서영
 *
 */
@Service
public class ReservedSeatService {
	
	@Autowired
	private ReservedSeatRepository reservedSeatRepository;

	@Transactional
	public List<ReservedSeat> readByTicketId(String ticketId) {
		List<ReservedSeat> entityList = reservedSeatRepository.selectByTicketId(ticketId);
		
		return entityList;
	}
	
}
