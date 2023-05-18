package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.service.AirportService;
import com.green.airline.service.InFlightSvService;

@RestController
public class RestInFlightServiceController {

	@Autowired
	private InFlightSvService inFlightSvService;

	@Autowired
	private AirportService airportService;

	// 특별 기내식 페이지
	@GetMapping("/changeCategory")
	public List<InFlightMealResponseDto> inFlightServiceSpecialPage(
			@RequestParam(name = "name", defaultValue = "유아식 및 아동식", required = false) String name) {
		List<InFlightMealResponseDto> inFlightMeals = inFlightSvService.readInFlightMeal(name);

		List<InFlightMeal> flightMeals = inFlightSvService.readInFlightMealCategory();

		return inFlightMeals;
	}

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
}
