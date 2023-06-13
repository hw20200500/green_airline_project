package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.dto.request.InFlightReqRequestDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.InFlightServiceResponseDto;
import com.green.airline.dto.response.ResponseDto;
import com.green.airline.dto.response.RouteResponseDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.Route;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.service.RouteService;
import com.green.airline.utils.Define;

@RestController
public class InFlightServiceApiController {

	@Autowired
	private InFlightSvService inFlightSvService;

	@Autowired
	private AirportService airportService;

	@Autowired
	private RouteService routeService;

	@Autowired
	private HttpSession session;

	// 특별 기내식 페이지
	@GetMapping("/changeCategory")
	public List<InFlightMealResponseDto> inFlightServiceSpecialPage(
			@RequestParam(name = "name", defaultValue = "유아식 및 아동식", required = false) String name) {
		List<InFlightMealResponseDto> inFlightMeals = inFlightSvService.readInFlightMealByName(name);

		return inFlightMeals;
	}

//	@GetMapping("/setMaxCount")
//	public InFlightMealResponseDto setMaxCount(@RequestParam String departureDate) {
//		User principal = (User) session.getAttribute(Define.PRINCIPAL);
//		// 좌석 수를 동적으로 갖고 오려고
//		InFlightMealResponseDto flightMealResponseDto = inFlightSvService
//				.readInFlightRequestForSeatCount(principal.getId(), departureDate);
//
//		return flightMealResponseDto;
//	}

	// 공항 리스트 자동 완성
	@GetMapping("/search")
	public List<Airport> searchAirportData(@RequestParam String name) {
		List<Airport> reqList = airportService.readByLikeName(name);
		return reqList;
	}

	// 공항 리스트
	@GetMapping("/list")
	public List<Airport> airportByRegionData(@RequestParam String region) {
		List<Airport> reqList = airportService.readByRegion(region);
		return reqList;
	}

	// 노선 정보 갖고 오기
	@GetMapping("/searchRoute")
	public List<InFlightServiceResponseDto> searchRoute(@RequestParam String destination, @RequestParam String departure) {
		List<InFlightServiceResponseDto> reqRouteList = routeService.readByDestAndDepa(destination, departure);
		return reqRouteList;
	}
	
	// 특별 기내식 신청 페이지
	@PostMapping("/specialMealReq")
	public ResponseDto<?> specialMealReqPage(Model model, @RequestBody InFlightReqRequestDto inFlightReqRequestDto) {
		System.out.println(inFlightReqRequestDto);
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		// todo
		// 특별 기내식 상세 조회 기능 갖고 와야 함
		// myInfo에 찍어줘야 함 (특별 기내식 신청 내역 페이지를 하나 만들던가 해야 함.)
		inFlightReqRequestDto.setMemberId(principal.getId());
		int result = inFlightSvService.createInFlightMealRequest(inFlightReqRequestDto);
		if(result == 0) {
			ResponseDto<Object> failMsg = ResponseDto.builder()
					.statusCode(HttpStatus.BAD_REQUEST.value())
					.message("신청 실패")
					.build();
			System.out.println(failMsg);
			return failMsg;
		} else {
			ResponseDto<Object> successMsg = ResponseDto
					.builder()
					.statusCode(HttpStatus.OK.value())
					.message("신청 완료되었습니다.").build();
			System.out.println(successMsg);
			return successMsg;
		}
	}

}
