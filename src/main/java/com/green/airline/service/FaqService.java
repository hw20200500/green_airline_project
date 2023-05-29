package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.response.FaqResponseDto;
import com.green.airline.repository.interfaces.FaqRepository;
import com.green.airline.repository.model.Faq;
import com.green.airline.repository.model.FaqCategory;

@Service
public class FaqService {

	@Autowired
	private FaqRepository faqRepository;

	// id 기반 자주묻는질문 조회
	public List<FaqResponseDto> readFaqByCategoryId(Integer categoryId) {
		List<FaqResponseDto> faqResponseDtos = faqRepository.selectFaqByCategoryId(categoryId);
		return faqResponseDtos;
	}

	// faq category
	public List<FaqCategory> readFaqCategory() {
		List<FaqCategory> categories = faqRepository.selectFaqCategory();
		return categories;
	}

	// faq 검색 기능
	public List<FaqResponseDto> readFaqByKeyword(String keyword) {
		keyword = "%" + keyword + "%";
		List<FaqResponseDto> faqList = faqRepository.selectFaqByKeyword(keyword);
		return faqList;
	}

}
