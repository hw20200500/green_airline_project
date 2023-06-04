package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.request.InFlightReqRequestDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.SpecialMealResponseDto;
import com.green.airline.enums.MealDetail;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightMealDetail;
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
	public String inFlightServiceSearchPage(Model model) {

		List<InFlightService> inFlightServices = inFlightSvService.readInFlightService();
		model.addAttribute("inFlightServices", inFlightServices);

		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);

		return "/in_flight/inFlightSvSearch";
	}

//	@PostMapping("/inFlightServiceSearch")
//	public String inFlightServiceSearch(Model model, @RequestBody String keyword) {
//		List<InFlightService> inFlightServices = inFlightSvService.readInFlightServiceByName(keyword);
//		model.addAttribute("inFlightServices", inFlightServices);
//
//		return "/in_flight/inFlightSearch";
//	}

	// inFlightServiceSpecialSearch?name=값
	@GetMapping("/inFlightServiceSpecialSearch")
	public String inFlightServiceSearch2(@RequestParam String name) {
		return "/in_flight/inFlightServiceSpecial";
	}

	// 특별 기내식 페이지
	@GetMapping("/inFlightServiceSpecial")
	public String inFlightServiceSpecialPage(Model model,
			@RequestParam(name = "name", defaultValue = "유아식 및 아동식", required = false) String name) {

		List<InFlightMealResponseDto> inFlightMeals = inFlightSvService.readInFlightMealByName(name);
		model.addAttribute("inFlightMeals", inFlightMeals);

		List<InFlightMeal> flightMeals = inFlightSvService.readInFlightMealCategory();
		model.addAttribute("flightMeals", flightMeals);

		List<InFlightMealDetail> babyMeal = inFlightSvService.readInFlightMealByMealId(MealDetail.BABYMEAL);
		List<InFlightMealDetail> veganMeal = inFlightSvService.readInFlightMealByMealId(MealDetail.VEGANMEAL);
		List<InFlightMealDetail> religionMeal = inFlightSvService.readInFlightMealByMealId(MealDetail.RELIGIONMEAL);
		List<InFlightMealDetail> etcMeal = inFlightSvService.readInFlightMealByMealId(MealDetail.ETCMEAL);
		List<InFlightMealDetail> lowfatMeal = inFlightSvService.readInFlightMealByMealId(MealDetail.LOWFATMEAL);
		System.out.println(babyMeal);

		model.addAttribute("babyMeal", babyMeal);
		model.addAttribute("veganMeal", veganMeal);
		model.addAttribute("religionMeal", religionMeal);
		model.addAttribute("etcMeal", etcMeal);
		model.addAttribute("lowfatMeal", lowfatMeal);

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		if (principal == null) {
			model.addAttribute("inFlightServiceResponseDtos", null);
		} else {
			List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
					.readInFlightMealSchedule(principal.getId());
			model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);
		}

		return "/in_flight/inFlightServiceSpecial";
	}

	// 기내 서비스 페이지
	@GetMapping("/list")
	public String inFlightServiceListPage(Model model) {
		List<InFlightService> inFlightServices = inFlightSvService.readInFlightService();
		model.addAttribute("inFlightServices", inFlightServices);

		return "/in_flight/inFlightService";
	}

	// 특별 기내식 신청 내역 페이지
	@GetMapping("/myServiceReq")
	public String myServiceReqPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		List<SpecialMealResponseDto> specialMealResponseDtos = inFlightSvService
				.readRequestMealByMemberId(principal.getId());
		List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
				.readInFlightMealSchedule(principal.getId());

		model.addAttribute("specialMealResponseDtos", specialMealResponseDtos);
		model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);

		return "/in_flight/myServiceReq";
	}

	// 특별 기내식 신청 내역 페이지 (수정 및 삭제)
	@PostMapping("/myReqServiceDelete")
	public String myReqServiceDeleteProc(@RequestParam Integer id) {
		inFlightSvService.deleteRequestMealById(id);
		return "redirect:/inFlightService/myServiceReq";
	}
}
