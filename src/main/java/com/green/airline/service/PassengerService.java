package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.PassengerRepository;
import com.green.airline.repository.model.Passenger;

/**
 * @author 서영
 *
 */
@Service
public class PassengerService {
	
	@Autowired
	private PassengerRepository passengerRepository;

	/**
	 * @return 해당 티켓의 탑승객 정보
	 */
	public List<Passenger> readByTicketId(String ticketId) {
		List<Passenger> entityList = passengerRepository.selectByTicketId(ticketId);
		
		return entityList;
	}
	
}
