package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.dto.response.FaqResponseDto;
import com.green.airline.repository.model.FaqCategory;
import com.green.airline.service.FaqService;
import com.green.airline.utils.PagingObj;

@Controller
@RequestMapping("/faq")
public class FaqController {

	@Autowired
	private FaqService faqService;

	// faq 페이지
	@GetMapping("/faqList")
	public String faqListPage(Model model,
			@RequestParam(name = "categoryId", defaultValue = "1", required = false) Integer categoryId) {
		List<FaqResponseDto> faqResponseDtos = faqService.readFaqByCategoryId(categoryId);
		List<FaqCategory> categories = faqService.readFaqCategory();
		
		model.addAttribute("faqResponseDtos", faqResponseDtos);
		model.addAttribute("categories", categories);
		return "/faq/faqList";
	}

	// faq 검색 기능
	@GetMapping("/faqSearch")
	public String faqSearch(@RequestParam String keyword, Model model) {
		List<FaqResponseDto> faqResponseDtos = faqService.readFaqByKeyword(keyword);

		List<FaqCategory> categories = faqService.readFaqCategory();

		model.addAttribute("faqResponseDtos", faqResponseDtos);
		model.addAttribute("categories", categories);

		return "/faq/faqList";
	}
	
	@GetMapping("/faqDelete")
	public String faqDelete(@RequestParam Integer id) {
		faqService.deleteFaqById(id);
		return "redirect:/faq/faqList";
	}

}
