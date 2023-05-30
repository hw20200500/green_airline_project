package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.response.MonthlySalesForChartDto;
import com.green.airline.repository.interfaces.TicketPaymentRepository;

/**
 * @author 서영
 *
 */
@Service
public class TicketPaymentService {

	@Autowired
	private TicketPaymentRepository ticketPaymentRepository;
	
	/**
	 * @return 최근 1년간 월간 매출액
	 */
	public List<MonthlySalesForChartDto> readMonthlySales() {
		return ticketPaymentRepository.selectSalesGroupByDate();
	}
	
}
