package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.green.airline.repository.model.CarryOnLiquids;
import com.green.airline.service.BaggageService;

@Controller
@RequestMapping("/baggage")
public class BaggageController {

	@Autowired
	private BaggageService baggageService;
	
	// 수하물 안내 페이지 
	@GetMapping("/guide")
	public String baggageGuidePage() {
		
		return "/baggage/baggageGuide";
	}
	
	// 운송 제한 물품 페이지
	@GetMapping("/limit")
	public String baggageLimitPage(Model model) {
		List<CarryOnLiquids> carryOnLiquids = baggageService.readLiquids();
		model.addAttribute("carryOnLiquids", carryOnLiquids);
		return "/baggage/transportLimit";
	}
	
}
