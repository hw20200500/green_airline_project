package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.repository.interfaces.MileageRepository;

@Service
public class MileageService {

	@Autowired
	private MileageRepository mileageRepository;
	
	public SaveMileageDto readSaveMileage(String memberId){
		SaveMileageDto saveMileage = mileageRepository.selectSaveMileage(memberId); 
		
		return  saveMileage;
	}
	public UseMileageDto readUseMileage(String memberId) {
		UseMileageDto useMileage = mileageRepository.selectUseMileage(memberId);
		return useMileage;
	}
}
