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
	 * @return 최근 11개월간 월간 매출액 (이번 달 제외)
	 */
	public List<MonthlySalesForChartDto> readMonthlySales(String date) {
		return ticketPaymentRepository.selectSalesGroupByDate(date);
	}
	
	/**
	 * @return 특정 월의 매출액
	 */
	public MonthlySalesForChartDto readSalesByThisMonth(Integer year, Integer month) {
		return ticketPaymentRepository.selectSalesByThisMonth(year, month);
	}
	
	
	
}
