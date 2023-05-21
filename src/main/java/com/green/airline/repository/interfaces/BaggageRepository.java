package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.CarryOnLiquids;

@Mapper
public interface BaggageRepository {
	
	// 운송 제한 품목의 휴대 반입 액체류 안내 나라 이름 갖고 오기
	List<CarryOnLiquids> selectLiquids();

	// 운송 제한 품목의 휴대 반입 액체류 안내
	CarryOnLiquids selectLiquidsByName(String name);
	

}
