package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.response.FaqResponseDto;
import com.green.airline.repository.model.FaqCategory;

@Mapper
public interface FaqRepository {

	// faq 카테고리 조회
	List<FaqCategory> selectFaqCategory();

	// id기반 faq 조회
	List<FaqResponseDto> selectFaqByCategoryId(Integer categoryId);
	
	// 검색 기능
	List<FaqResponseDto> selectFaqByKeyword(String keyword);
	
}
