package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.green.airline.dto.response.BaggageReqResponseDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.CarryOnLiquids;
import com.green.airline.repository.model.CheckedBaggage;
import com.green.airline.repository.model.User;
import com.green.airline.service.BaggageRequestService;
import com.green.airline.service.BaggageService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.service.TicketService;
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
	@Autowired
	private TicketService ticketService;

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
		System.out.println("baggage: "+baggage);
		model.addAttribute("baggage", baggage);

		List<CheckedBaggage> checkedBaggages = baggageService.readCheckedBaggageBySection(baggage.get(0).getSection());
		model.addAttribute("checkedBaggages", checkedBaggages);

		List<BaggageReqResponseDto> baggageGroupBySection = baggageRequestService.readBaggageReqGroupBySection();
		model.addAttribute("baggageGroupBySection", baggageGroupBySection);

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		if (principal == null) {
			System.out.println("principal null");
			model.addAttribute("baggageReqResponses", null); // 로그인이 안되어 있을 시 데이터 출력이 안되도록 하기 위해 --> 인증처리(인터셉터)
			model.addAttribute("inFlightServiceResponseDtos", null); // 좌석 수에 따라 수량을 가져오기 위해

		} else {
			System.out.println("principal not null:"+principal.getId());
			List<InFlightMealResponseDto> inFlightServiceResponseDtos = baggageRequestService
					.readBaggageReqPossibleTicket(principal.getId());
			System.out.println("baggageList : "+inFlightServiceResponseDtos);
			model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);
			
		}

		return "/baggage/checkedBaggage";
	}

	// 위탁 수하물 -> 환승 수하물 페이지
	@GetMapping("/transitBaggage")
	public String transitBaggagePage() {
		return "/baggage/transitBaggage";
	}

	// 위탁 수하물 신청 내역 페이지 (수정 및 삭제)
	@GetMapping("/myBaggageReq")
	public String myBaggageReqPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		// Todo
		// 위탁 수하물 신청 정보 갖고 오기
		List<BaggageReqResponseDto> baggageReqResponses = baggageRequestService
				.readBaggageReqByMemberIdAndAmount(principal.getId());
		List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
				.readInFlightMealSchedule(principal.getId());
		model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);
		model.addAttribute("baggageReqResponses", baggageReqResponses);

		return "/baggage/myBaggageReq";
	}
	
}
