package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	
	// 관리자 측 faq 삭제 기능
	int deleteFaqById(Integer id);
	
	// 관리자 측 faq 수정 기능
	int updateFaqById(@Param("id") Integer id, @Param("faq") FaqResponseDto faq);
	
	// id기반 List faq 출력 기능 
	List<FaqResponseDto> selectFaqByIdList(Integer id);
	
	// id기반 faq 출력 기능
	FaqResponseDto selectFaqById(Integer id);
	
	/**
	 * @author 서영
	 * 모든 faq 조회
	 */
	List<FaqResponseDto> selectFaqAll();
	
}
