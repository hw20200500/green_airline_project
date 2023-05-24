package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.service.TicketService;

// todo 삭제

@Controller
public class TestController {
	
	@Autowired
	private TicketService ticketService;

	@GetMapping("/test")
	public String test(Model model) {
		
		List<TicketAllInfoDto> ticketList = ticketService.updatePaymentStatusIsSuccess("abc");
		
		model.addAttribute("ticketList", ticketList);
		
		return "/ticket/paymentSuccess2";
	}
	
}
