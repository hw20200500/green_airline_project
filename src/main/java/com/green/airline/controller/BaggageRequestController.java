package com.green.airline.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/baggageReq")
public class BaggageRequestController {

	@GetMapping("/baggageRequest")
	public String baggageReqPage() {
		
		return "/baggage/baggageReq";
	}
	
}
