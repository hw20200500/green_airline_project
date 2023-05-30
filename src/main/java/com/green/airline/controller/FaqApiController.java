package com.green.airline.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.dto.response.FaqResponseDto;
import com.green.airline.repository.model.Faq;
import com.green.airline.service.FaqService;

@RestController
public class FaqApiController {

	@Autowired
	private FaqService faqService;

	@GetMapping("/faqDelete")
	public String faqDelete(@RequestParam Integer id) {
		faqService.deleteFaqById(id);
		return "redirect:/faq/faqList";
	}

	@GetMapping("/faqUpdate")
	public FaqResponseDto faqUpdate(@RequestParam Integer id) {
		FaqResponseDto faqResponseDto = faqService.readFaqById(id);
		faqService.updateFaqById(id, faqResponseDto);
		return faqResponseDto;
	}

}
