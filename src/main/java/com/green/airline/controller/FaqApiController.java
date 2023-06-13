package com.green.airline.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.dto.response.FaqResponseDto;
import com.green.airline.service.FaqService;

@RestController
public class FaqApiController {

	@Autowired
	private FaqService faqService;

	@GetMapping("/faqDelete")
	// 체크된 값을 배열로 넘기기 때문에 매개변수에 배열로 받아야 함
	public List<Integer> faqDelete(@RequestParam List<Integer> id) {
		System.out.println(id);
		id.stream().forEach(e -> {
			faqService.deleteFaqById(e);
		});
		
		// id를 넘겨서 노드를 삭제하는데 사용
		return id;
	}

	@PostMapping("/faqUpdate")
	public FaqResponseDto faqUpdate(@RequestBody FaqResponseDto faqResponseDto) {
		System.out.println(faqResponseDto);
		faqService.updateFaqById(faqResponseDto.getId(), faqResponseDto);
		return faqResponseDto;
	}

}
