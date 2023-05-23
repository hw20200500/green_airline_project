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

import com.green.airline.dto.request.BaggageReqRequest;
import com.green.airline.dto.response.BaggageReqResponse;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.BaggageMiss;
import com.green.airline.repository.model.BaggageRequest;
import com.green.airline.repository.model.CarryOnLiquids;
import com.green.airline.repository.model.CheckedBaggage;
import com.green.airline.repository.model.InFlightService;
import com.green.airline.repository.model.User;
import com.green.airline.service.BaggageRequestService;
import com.green.airline.service.BaggageService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/baggage")
public class BaggageController {

	@Autowired
	private BaggageService baggageService;
	@Autowired
	private BaggageRequestService baggageRequestService;
	@Autowired
	private InFlightSvService inFlightSvService;
	@Autowired
	private HttpSession session;

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

		List<BaggageReqResponse> baggageGroupBySection = baggageRequestService.readBaggageReqGroupBySection();
		model.addAttribute("baggageGroupBySection", baggageGroupBySection);
		
		
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		
		if (principal == null) {
			model.addAttribute("baggageReqResponses", null); // 로그인이 안되어 있을 시 데이터 출력이 안되도록 하기 위해 --> 인증처리(인터셉터)
			model.addAttribute("isLogin", false); // 로그인이 안되어 있을 시 얼럿창을 띄워주기 위해
			model.addAttribute("inFlightServiceResponseDtos", null); // 좌석 수에 따라 수량을 가져오기 위해

		} else {
			List<BaggageReqResponse> baggageReqResponses = baggageRequestService
					.readBaggageReqByMemberId(principal.getId());
			model.addAttribute("baggageReqResponses", baggageReqResponses);
			model.addAttribute("isLogin", true);

			List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
					.readInFlightMealSchedule(principal.getId());
			model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);

		}

		return "/baggage/checkedBaggage";
	}

	// 위탁 수하물 -> 환승 수하물 페이지
	@GetMapping("/transitBaggage")
	public String transitBaggagePage() {
		return "/baggage/transitBaggage";
	}

	// 수하물 유실 페이지
	@GetMapping("/baggageMiss")
	public String baggageMissPage(Model model) {
		List<BaggageMiss> baggageMisses = baggageService.readBaggageMiss();
		model.addAttribute("baggageMisses", baggageMisses);

		return "/baggage/baggageMiss";
	}

	// MIME / application/json
	@PostMapping("/checkedBaggageProc")
	// @RequestBody 민정아 이거는 json 형식에 바디 값을 받는 파싱전략이야
	public String checkedBaggageProc(BaggageReqRequest baggageReqRequest) {
		User user = (User) session.getAttribute(Define.PRINCIPAL);
		baggageReqRequest.setMemberId(user.getId());
		baggageRequestService.createBaggageReq(baggageReqRequest);
		return "redirect:/baggage/checkedBaggage";
	}

}
