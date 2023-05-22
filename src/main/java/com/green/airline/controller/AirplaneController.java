package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.green.airline.dto.response.AirplaneInfoDto;
import com.green.airline.repository.model.Airplane;
import com.green.airline.service.AirplaneService;
import com.green.airline.service.SeatService;

/**
 * @author 서영
 * 비행기 관련
 *
 */
@Controller
@RequestMapping("/airplane")
public class AirplaneController {
	
	@Autowired
	private SeatService seatService;
	
	@Autowired
	private AirplaneService airplaneService;

	@GetMapping("/info/{id}")
	public String airplaneSeatPage(Model model, @PathVariable Integer id) {
		model.addAttribute("id", id);
		
		// 콤보박스에 사용할 모든 비행기 리스트
		List<Airplane> airplaneList = airplaneService.readAll();
		model.addAttribute("airplaneList", airplaneList);
		
		List<AirplaneInfoDto> responseList = seatService.readSeatCountByAirplaneId(id);
		model.addAttribute("airplaneName", responseList.get(0).getName());
		
		Integer totalSeatCount = 0;
		
		for (AirplaneInfoDto a : responseList) {
			totalSeatCount += a.getSeatCount();
			if (a.getGrade().equals("이코노미")) {
				model.addAttribute("economy", a.getSeatCount());
			} else if (a.getGrade().equals("비즈니스")) {
				model.addAttribute("business", a.getSeatCount());
			} else {
				model.addAttribute("first", a.getSeatCount());
			}
		}
		model.addAttribute("totalSeatCount", totalSeatCount);
		
		return "/ticket/airplaneInfo";
	}
	
}
