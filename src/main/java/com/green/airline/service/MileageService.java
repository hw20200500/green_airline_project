package com.green.airline.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.repository.interfaces.MileageRepository;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.UseMileage;

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
	
	public SaveMileageDto readExtinctionMileage(String memberId) {
		SaveMileageDto extinctionMileage = mileageRepository.selectExtinctionMileage(memberId);
		return extinctionMileage;
	}
	public List<Mileage> readSaveMileageList(String memberId, Date startTime,Date endTime) {
		List<Mileage> saveList = mileageRepository.selectMileageList(memberId,startTime, endTime);
		return saveList;
		}
	public List<UseMileage> readUseMileageList(String memberId) {
		List<UseMileage> useList = mileageRepository.selectUseMileageList(memberId);
		return useList;
		}
}
