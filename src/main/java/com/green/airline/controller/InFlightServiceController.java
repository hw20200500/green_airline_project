package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.InFlightServiceResponseDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightService;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.service.RouteService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/inFlightService")
public class InFlightServiceController {

	@Autowired
	private InFlightSvService inFlightSvService;
	@Autowired
	private AirportService airportService;
	@Autowired
	private RouteService routeService;

	@Autowired
	private HttpSession session;

	// 기내 서비스 조회 페이지
	@GetMapping("/inFlightServiceSearch")
	public String inFlightServiceSearchPage(Model model, Integer flightHours) {

		List<InFlightService> inFlightServices = inFlightSvService.readInFlightService();
		model.addAttribute("inFlightServices", inFlightServices);

		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);

		return "/in_flight/inFlightSvSearch";
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

		// todo 지울 수도 있음.
//		List<InFlightServiceResponseDto> reqRouteList = routeService.readByDestAndDepa(destination, departure);
//		model.addAttribute("reqRouteList", reqRouteList);

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		if (principal == null) {
			model.addAttribute("inFlightServiceResponseDtos", null);
			model.addAttribute("isLogin", false);
		} else {
			List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
					.readInFlightMealSchedule(principal.getId());
			model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);
			model.addAttribute("isLogin", true);
		}

		return "/in_flight/inFlightServiceSpecial";
	}

	// 특별 기내식 신청 페이지
	@GetMapping("/specialMealReq")
	public String specialMealReqProc(Model model, @RequestParam String name, @RequestParam Integer amount,
			@RequestParam String departureDate) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		// todo
		// 특별 기내식 상세 조회 기능 갖고 와야 함
		// myInfo에 찍어줘야 함 (특별 기내식 신청 내역 페이지를 하나 만들던가 해야 함.)
		inFlightSvService.createInFlightMealRequest(principal.getId(), name, amount, departureDate);

		return "/in_flight/inFlightServiceSpecial";
	}

}
