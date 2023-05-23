package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.repository.model.BaggageMiss;
import com.green.airline.repository.model.CarryOnLiquids;
import com.green.airline.repository.model.CheckedBaggage;
import com.green.airline.service.BaggageService;

@RestController
public class BaggageApiController {

	@Autowired
	private BaggageService baggageService;

	// 운송 제한 품목의 휴대 반입 액체류 안내
	@GetMapping("/limitLiquids")
	public CarryOnLiquids limitLiquids(@RequestParam String name) {
		CarryOnLiquids carryOnLiquids = baggageService.readLiquidsByName(name);
		return carryOnLiquids;
	}

	// 위탁 수하물 중 구간 선택에 따른 무료 수하물 허용량
	@GetMapping("/freeBaggage")
	public List<CheckedBaggage> freeBaggage(@RequestParam String section) {
		List<CheckedBaggage> baggages = baggageService.readCheckedBaggageBySection(section);
		return baggages;
	}

	@GetMapping("/baggageMiss")
	public List<BaggageMiss> baggageMiss(@RequestParam String name) {
		List<BaggageMiss> baggageMisses = baggageService.readBaggageMissByName(name);
		return baggageMisses;
	}

}
