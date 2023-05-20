package com.green.airline.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.repository.model.CarryOnLiquids;
import com.green.airline.service.BaggageService;

@RestController
public class BaggageApiController {

	@Autowired
	private BaggageService baggageService;

	// 운송 제한 품목의 휴대 반입 액체류 안내
	@GetMapping("/limitLiquids")
	public CarryOnLiquids limitLiquids(@RequestParam String name) {
		CarryOnLiquids carryOnLiquids = baggageService.readLiquidsByName(name);
		System.out.println(name);
		return carryOnLiquids;
	}

}
