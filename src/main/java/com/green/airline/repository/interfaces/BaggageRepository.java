package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.BaggageMiss;
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
	
	// 수하물 유실 name에 따른 안내와 유의사항
	List<BaggageMiss> selectBaggageMissByName(String name);
	
	// 수하물 유실 카테고리 
	List<BaggageMiss> selectBaggageMiss();
	
}
