package com.green.airline.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.dto.response.SeatStatusResponseDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.service.AirportService;
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
	
	@Autowired
	private AirportService airportService;
	
	/**
	 * @return 항공권 옵션 선택 페이지
	 */
	@GetMapping("/selectOption")
	public String selectTicketOptionPage(Model model) {
		
		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);
		
		return "/ticket/selectOption";
	}
	
	/**
	 * @return 좌석 선택 페이지
	 */
	@GetMapping("/selectSeat/{scheduleId}")
	public String selectSeatPage(Model model, @PathVariable Integer scheduleId) {
		// 선택할 좌석 수
		model.addAttribute("seatCount", 3);
		
		// 현재 항공 일정 id
		model.addAttribute("scheduleId", scheduleId);
		
		// 해당 스케줄에 운항하는 비행기의 이코노미 좌석 리스트 (예약 여부 포함)
		List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(scheduleId, "이코노미");
		model.addAttribute("economyList", eSeatList);
		
		// 해당 스케줄에 운항하는 비행기의 비즈니스 좌석 리스트 (예약 여부 포함)
		List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(scheduleId, "비즈니스");
		model.addAttribute("businessList", bSeatList);
		
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
