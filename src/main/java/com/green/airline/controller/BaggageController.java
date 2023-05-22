package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.green.airline.repository.model.BaggageMiss;
import com.green.airline.repository.model.CarryOnLiquids;
import com.green.airline.repository.model.CheckedBaggage;
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

	@GetMapping("/carryBaggage")
	public String carryBaggagePage() {

		return "/baggage/carryBaggage";
	}

	// 위탁 수하물 -> 수하물 규정 페이지
	@GetMapping("/checkedBaggage")
	public String checkedBaggagePage(Model model) {
		List<CheckedBaggage> baggage = baggageService.readCheckedBaggage();
		model.addAttribute("baggage", baggage);

		List<CheckedBaggage> checkedBaggages = baggageService.readCheckedBaggageBySection(baggage.get(0).getSection());
		model.addAttribute("checkedBaggages", checkedBaggages);

		return "/baggage/checkedBaggage";
	}

	// 위탁 수하물 -> 환승 수하물 페이지
	@GetMapping("/transitBaggage")
	public String transitBaggagePage() {
		return "/baggage/transitBaggage";
	}

	// 수하물 유실 페이지
	@GetMapping("/baggageMiss")
	public String baggageMissPage(Model model, String name) {
		List<BaggageMiss> baggageMisses = baggageService.readBaggageMiss();
		model.addAttribute("baggageMisses", baggageMisses);

		List<BaggageMiss> baggageList = baggageService.readBaggageMissByName(name);
		model.addAttribute("baggageList", baggageList);

		return "/baggage/baggageMiss";
	}

}
