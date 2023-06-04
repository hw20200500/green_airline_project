package com.green.airline.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.GifticonDto;
import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.repository.interfaces.GifticonRepository;
import com.green.airline.repository.interfaces.MileageRepository;
import com.green.airline.repository.interfaces.ProductRepository;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.UseMileage;

/**
 * @author 정다운
 *
 */
@Service
public class MileageService {

	@Autowired
	private MileageRepository mileageRepository;
	
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired 
	private GifticonRepository gifticonRepository;
	
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
	
	public Mileage readExprirationBalanceByMemberId(String memberId,Timestamp ts) {
		
		Mileage mileage = mileageRepository.selectExprirationBalanceByMemberId(memberId,ts);
		return mileage;
	}
public Mileage readSaveBalanceByMemberId(String memberId,Timestamp ts) {
		
		Mileage mileage = mileageRepository.selectSaveBalanceByMemberId(memberId,ts);
		return mileage;
	}

public List<Mileage> readMileageTbOrderByMileageDateByMemberId(String memberId) {
	List<Mileage> mileage = mileageRepository.selectMileageTbOrderByMileageDateByMemberId(memberId);
	
	return mileage;
}
	public void readNowMileage(String memberId, int price ,int productId){
		int usemileage = price;// 결제 할 마일리지
		List<Mileage> mileageList = mileageRepository.selectNowMileage(memberId);
		Mileage mileageId = mileageRepository.selectMileageByMemberId(memberId);
		GifticonDto gifticonDto = gifticonRepository.selectGifticonLimit();
		for (Mileage mileage : mileageList) {
			if(mileage.getBalance() >= usemileage) {
			int updatemileage = mileage.getBalance() - usemileage;
			// update 해줘야함
			mileage.setBalance(updatemileage);
			mileage.setMileageFromBalance(usemileage);
			mileage.setDateFormExpiration(mileage.getExpirationDate());
			mileage.setGifticonId(gifticonDto.getId());
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
				mileage.setGifticonId(gifticonDto.getId());
				mileage.setMemberId(memberId);
				mileage.setProductId(productId);
				mileage.setBalance(0);
				mileageRepository.insertUseDataList(mileage);
				mileageRepository.updateBalance(mileage);
			}
		}
	}
	
	/**
	 * @author 서영
	 * 마일리지 티켓 결제
	 */
	public void createUseMilesDataByTicket(String memberId, int price, String ticketId) {
		// 결제할 마일리지
		int useMileage = price;
		// 유효 기간이 남은 적립 마일리지 목록
		List<Mileage> mileageList = mileageRepository.selectNowMileage(memberId);
		
		for (Mileage m : mileageList) {
			// 해당 내역의 잔여 마일리지가 결제할 마일리지보다 많거나 서로 같다면
			if (m.getBalance() >= useMileage) {
				int updateMileage = m.getBalance() - useMileage;

				m.setBalance(updateMileage);
				m.setMileageFromBalance(useMileage);
				m.setDateFormExpiration(m.getExpirationDate());
				m.setTicketId(ticketId);
				//mileageRepository.insertUseDataList(m);
				mileageRepository.updateBalance(m);
				
				useMileage = 0;
				break;
			// 해당 내역의 잔여 마일리지가 결제할 마일리지보다 적다면 (다음 반복으로 넘어감)
			} else {
				useMileage = useMileage - m.getBalance();
				
				m.setMileageFromBalance(m.getBalance());
				m.setDateFormExpiration(m.getExpirationDate());
				m.setTicketId(ticketId);
				m.setBalance(0);
				//mileageRepository.insertUseDataList(m);
				mileageRepository.updateBalance(m);
			}
		}
	}
}
