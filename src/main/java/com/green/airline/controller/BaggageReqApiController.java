package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.dto.response.BaggageReqResponse;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.repository.model.User;
import com.green.airline.service.BaggageRequestService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.utils.Define;

@RestController
public class BaggageReqApiController {

	@Autowired
	private BaggageRequestService baggageRequestService;
	@Autowired
	private InFlightSvService inFlightSvService;
	@Autowired
	private HttpSession session;

	@GetMapping("/baggageReq")
	public List<BaggageReqResponse> baggageReqPage() {
		/*
		 * baggageRequestService.createBaggageReq(memberId, departureDate,
		 * baggageReqRequest);
		 */
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		List<BaggageReqResponse> baggageRequests = baggageRequestService.readBaggageReqByMemberId(principal.getId());

		return baggageRequests;
	}

	// service단에서 퍼스트는 *3 해야 하고 비지니스, 이코노미는 *2 해야 함.
	// 좌석 수에 따른 수하물 개수를 동적으로 갖고 오기 위해 사용
	@GetMapping("/maxCount")
	public InFlightMealResponseDto maxCount(@RequestParam String departureDate) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		// 좌석 수를 동적으로 갖고 오려고
		InFlightMealResponseDto flightMealResponseDto = inFlightSvService
				.readInFlightRequestForSeatCount(principal.getId(), departureDate);
		return flightMealResponseDto;
	}

}
