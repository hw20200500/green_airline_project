package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.BaggageRepository;
import com.green.airline.repository.model.CarryOnLiquids;

@Service
public class BaggageService {

	@Autowired
	private BaggageRepository baggageRepository;
	
	public List<CarryOnLiquids> readLiquids(){
		List<CarryOnLiquids> carryOnLiquids = baggageRepository.selectLiquids();
		return carryOnLiquids;
	}

	// 운송 제한 품목의 휴대 반입 액체류 안내 -> BaggageApiController
	public CarryOnLiquids readLiquidsByName(String name) {
		CarryOnLiquids carryOnLiquidsEntity = baggageRepository.selectLiquidsByName(name);

		return carryOnLiquidsEntity;
	}

}
