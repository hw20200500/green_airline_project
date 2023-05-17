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

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.InFlightServiceResponseDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightService;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/inFlightService")
public class InFlightServiceController {

	@Autowired
	private InFlightSvService inFlightSvService;
	@Autowired
	private AirportService airportService;

	@Autowired
	private HttpSession session;

	// 기내 서비스 페이지
	@GetMapping("/list")
	public String inFlightServiceListPage(Model model) {
		List<InFlightService> inFlightServices = inFlightSvService.readInFlightService();
		model.addAttribute("inFlightServices", inFlightServices);

		List<Airport> airportList = airportService.readAll();
		model.addAttribute("airportList", airportList);

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
		return "/in_flight/inFlightServiceSpecial";
	}

	// 특별 기내식 페이지
	@GetMapping("/inFlightServiceSpecial")
	public String inFlightServiceSpecialPage(Model model,
			@RequestParam(name = "name", defaultValue = "유아식 및 아동식", required = false) String name) {

		System.out.println("name : " + name);
		List<InFlightMealResponseDto> inFlightMeals = inFlightSvService.readInFlightMeal(name);
		model.addAttribute("inFlightMeals", inFlightMeals);

		List<InFlightMeal> flightMeals = inFlightSvService.readInFlightMealCategory();
		model.addAttribute("flightMeals", flightMeals);

		List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
				.readInFlightMealSchedule();
		model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);

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
	public String specialMealReqProc(Model model, String memberId, @RequestParam String name,
			@RequestParam Integer amount) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		// todo
		// 특별 기내식 상세 조회 기능 갖고 와야 함
		// myInfo에 찍어줘야 함 (특별 기내식 신청 내역 페이지를 하나 만들던가 해야 함.)
		inFlightSvService.createInFlightMealRequest(principal.getId(), name, amount);

		// 한 사람이 여러개의 예약번호를 가질 수 있으니까 콤보 박스로 선택할 수 있도록
		// 예약 번호를 갖고 와서 아직 여행을 가지 않은 것만 콤보 박스로 나오게 하고
		// 노선도 보여주기

		// 필요한 테이블
		// 기본 테이블 -> request_meal_tb
		// ticket_tb의 id를 가져와야 함 (예약 번호)

		// 여행가지 않은 것만 갖고 오는 건 어떻게 함 ?
		// 대안 1. service에서 resved_date와 현재 날짜를 비교하여 갖고 온다.

		return "/in_flight/inFlightServiceSpecial";
	}

}
