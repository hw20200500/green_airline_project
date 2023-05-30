package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.repository.interfaces.MileageRepository;
import com.green.airline.repository.interfaces.ProductRepository;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.UseMileage;

@Service
public class MileageService {

	@Autowired
	private MileageRepository mileageRepository;
	@Autowired
	private ProductRepository productRepository;
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
	public List<Mileage> readSaveMileageList(String memberId, String startTime,
			String endTime, String isAllSearch,String isUpSearch,String isUseSearch,String isExpireSearch) {
		List<Mileage> saveList = mileageRepository.selectMileageList(memberId,startTime,
				endTime,isAllSearch,isUpSearch,isUseSearch,isExpireSearch);
		return saveList;
		}
	public List<UseMileage> readUseMileageList(String memberId) {
		List<UseMileage> useList = mileageRepository.selectUseMileageList(memberId);
		return useList;
		}
		/*
		 * public SaveMileageDto insertMileage( ) { SaveMileageDto saveMileageDto =
		 * mileageRepository.insertMileage(); return saveMileageDto; }
		 */
	
	public void readNowMileage(String memberId, int price ,int productId){
		int usemileage = price;// 결제 할 마일리지
		List<Mileage> mileageList = mileageRepository.selectNowMileage(memberId);
		Mileage mileageId = mileageRepository.selectMileageByMemberId(memberId);
		for (Mileage mileage : mileageList) {
			if(mileage.getBalance() >= usemileage) {
			int updatemileage = mileage.getBalance() - usemileage;
			// update 해줘야함
			mileage.setBalance(updatemileage);
			mileage.setMileageFromBalance(usemileage);
			mileage.setDateFormExpiration(mileage.getExpirationDate());
			mileage.setMemberId(memberId);
			mileage.setProductId(productId);
			mileageRepository.insertUseDataList(mileage);
			mileageRepository.updateBalance(mileage);
			
			usemileage = 0;
			break;
			}else {
				usemileage = usemileage - mileage.getBalance();
				mileage.setMileageFromBalance(mileage.getBalance());
				mileage.setDateFormExpiration(mileage.getExpirationDate());
				mileage.setMemberId(memberId);
				mileage.setProductId(productId);
				mileage.setBalance(0);
				mileageRepository.insertUseDataList(mileage);
				mileageRepository.updateBalance(mileage);
			}
		}
	}
}
