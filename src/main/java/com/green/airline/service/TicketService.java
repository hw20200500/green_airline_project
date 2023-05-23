package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.TicketDto;
import com.green.airline.repository.interfaces.TicketRepository;
import com.green.airline.repository.model.Ticket;

/**
 * @author 서영
 *
 */
@Service
public class TicketService {
	
	@Autowired
	private TicketRepository ticketRepository;

	/**
	 * 결제 성공 시 예약 내역을 추가하는 로직
	 */
	@Transactional
	public void createTicket(TicketDto ticketDto, String memberId) {
		
		// 예약 id 난수로 생성
		Integer ticketId = (int) Math.floor(Math.random() * 890000000 + 100000000);		
		
		// 해당 id가 이미 존재하는지 확인 (존재한다면 다시)
		Ticket searchTicket = ticketRepository.selectById(ticketId);
		
		// 이미 존재한다면 반복문으로 들어감
		while (searchTicket != null) {
			ticketId = (int) Math.floor(Math.random() * 89000000 + 10000000);
			searchTicket = ticketRepository.selectById(ticketId);
		}
		
		// 예약 내역 생성 (1번 스케줄)
		Ticket ticket1 = Ticket.builder()
						.id(ticketId)
						.adultCount(ticketDto.getAdultCount())
						.childCount(ticketDto.getChildCount())
						.infantCount(ticketDto.getInfantCount())
						.seatGrade(ticketDto.getSeatGrade())
						.memberId(memberId)
						.scheduleId(ticketDto.getScheduleId())
						.build();
		ticketRepository.insert(ticket1);
		
		// 예약 좌석 생성
		
		// 탑승객 생성
		
		// 티켓 결제 내역 생성
		
		
	}
	
}
