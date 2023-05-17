package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightService;
import com.green.airline.repository.model.User;
import com.green.airline.service.InFlightSvService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/inFlightService")
public class InFlightServiceController {

	@Autowired
	private InFlightSvService inFlightSvService;
	
	@Autowired
	private HttpSession session;

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

	// // 기내식 페이지
//	@GetMapping("/inFlightList")
//	public String inFlightMealPage() {
//		
//		
//		return "/in_flight/inFlightMeal";
//	}
	
	// 특별 기내식 신청 페이지
	@GetMapping("/specialMealReq")
	public String specialMealReqProc(@RequestParam String name, @RequestParam Integer amount) {
		User principal = (User)session.getAttribute(Define.PRINCIPAL);
		// todo
		// 특별 기내식 상세 조회 기능 갖고 와야 함 
		// myInfo에 찍어줘야 함 (특별 기내식 신청 내역 페이지를 하나 만들던가 해야 함.)
		inFlightSvService.createInFlightMealRequest(principal.getId(), name, amount);
		return "/in_flight/inFlightServiceSpecial";
	}

}
