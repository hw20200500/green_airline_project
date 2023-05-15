package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightService;
import com.green.airline.service.InFlightSvService;

@Controller
@RequestMapping("/inFlightService")
public class InFlightServiceController {

	@Autowired
	private InFlightSvService inFlightSvService;
	
	// 기내 서비스 페이지
	@GetMapping("/list")
	public String inFlightServiceListPage(Model model) {
		List<InFlightService> inFlightServices = inFlightSvService.readInFlightService();
		model.addAttribute("inFlightServices", inFlightServices);
		
		return "/in_flight/inFlightService";
	}
	
	// 기내 서비스 조회 페이지
	@GetMapping("/inFlightServiceSearch")
	public String inFlightServiceSearchPage(Model model) {
		List<InFlightService> inFlightServices = inFlightSvService.readInFlightService();
		model.addAttribute("inFlightServices", inFlightServices);
		
		return "/in_flight/inFlightSearch";
	}
	
	@PostMapping("/inFlightServiceSearch")
	public String inFlightServiceSearch(Model model, String keyword) {
		List<InFlightService> inFlightServices = inFlightSvService.readInFlightServiceByName(keyword);
		model.addAttribute("inFlightServices", inFlightServices);
		
		return "/in_flight/inFlightSearch";
	}
	
	// inFlightServiceSpecialSearch?name=값
	@GetMapping("/inFlightServiceSpecialSearch")
	public String inFlightServiceSearch2(@RequestParam String name) {
		System.out.println(name);
		return "/in_flight/inFlightServiceSpecial";
	}
	
	// 특별 기내식 페이지
		@GetMapping("/inFlightServiceSpecial")
		public String inFlightServiceSpecialPage(Model model,
				@RequestParam(name = "name", defaultValue = "유아식 및 아동식", required = false) String name) {
			List<InFlightMealResponseDto> inFlightMeals = inFlightSvService.readInFlightMeal(name);
			model.addAttribute("inFlightMeals", inFlightMeals);

			List<InFlightMeal> flightMeals = inFlightSvService.readInFlightMealCategory();
			model.addAttribute("flightMeals", flightMeals);

			return "/in_flight/inFlightServiceSpecial";
		}
	
	//	// 기내식 페이지
//	@GetMapping("/inFlightList")
//	public String inFlightMealPage() {
//		
//		
//		return "/in_flight/inFlightMeal";
//	}
	
}
