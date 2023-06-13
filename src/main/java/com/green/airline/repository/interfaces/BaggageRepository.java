package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.enums.BaggageSection;
import com.green.airline.repository.model.CarryOnLiquids;
import com.green.airline.repository.model.CheckedBaggage;

@Mapper
public interface BaggageRepository {
	
	// 운송 제한 품목의 휴대 반입 액체류 안내 나라 이름 갖고 오기
	List<CarryOnLiquids> selectLiquids();

	// 운송 제한 품목의 휴대 반입 액체류 안내
	CarryOnLiquids selectLiquidsByName(String name);

	// 위탁 수하물 중 구간 선택에 따른 무료 수하물 허용량 
	List<CheckedBaggage> selectCheckedBaggageBySection(String section);

	// 위탁 수하물 카테고리 
	List<CheckedBaggage> selectCheckedBaggage();
	
	// checked_baggage_tb 조회
	CheckedBaggage selectCheckedBaggageBySectionAndGradeId(@Param("section") BaggageSection section, @Param("gradeId") String gradeId);
	
	
}
