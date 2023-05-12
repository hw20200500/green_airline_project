package com.green.airline.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.service.SeatService;

/**
 * @author 서영
 * 티켓 예매 관련 컨트롤러
 */
@Controller
@RequestMapping("/ticket")
public class TicketController {

	@Autowired
	private SeatService seatService;
	
	
	/**
	 * @return 좌석 선택 페이지
	 */
	@GetMapping("/selectSeat")
	public String selectSeatPage(Model model) {
		// 선택할 좌석 수
		model.addAttribute("seatCount", 3);
		
		// 현재 항공 일정 id
		model.addAttribute("scheduleId", 1);
		
		return "/ticket/selectSeat";
	}
	
	
	/**
	 * AJAX 통신용
	 * @return 선택한 좌석의 정보
	 */
	@GetMapping("/selectedSeatData")
	@ResponseBody
	public SeatInfoResponseDto selectedSeatData(@RequestParam String seatName, @RequestParam Integer scheduleId) {
		System.out.println(seatName);
		System.out.println(scheduleId);
		System.out.println("-------");
		
		SeatInfoResponseDto responseDto = seatService.readSeatInfoByNameAndScheduleId(seatName, scheduleId);
		
		return responseDto;
	}
	
	
}
