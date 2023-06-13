package com.green.airline.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		Long usemileage = (long) price;// 결제 할 마일리지
		List<Mileage> mileageList = mileageRepository.selectNowMileage(memberId);
		Mileage mileageId = mileageRepository.selectMileageByMemberId(memberId);
		GifticonDto gifticonDto = gifticonRepository.selectGifticonLimit();
		for (Mileage mileage : mileageList) {
			if(mileage.getBalance() >= usemileage) {
			Long updatemileage = mileage.getBalance() - usemileage;
			// update 해줘야함
			mileage.setBalance(updatemileage);
			mileage.setMileageFromBalance(usemileage);
			mileage.setDateFormExpiration(mileage.getExpirationDate());
			mileage.setGifticonId(gifticonDto.getId());
			mileage.setMemberId(memberId);
			mileage.setProductId(productId);
			mileageRepository.insertUseDataList(mileage);
			mileageRepository.updateBalance(mileage);
			
			usemileage = (long) 0;
			break;
			}else {
				usemileage = usemileage - mileage.getBalance();
				mileage.setMileageFromBalance(mileage.getBalance());
				mileage.setDateFormExpiration(mileage.getExpirationDate());
				mileage.setGifticonId(gifticonDto.getId());
				mileage.setMemberId(memberId);
				mileage.setProductId(productId);
				mileage.setBalance((long) 0);
				mileageRepository.insertUseDataList(mileage);
				mileageRepository.updateBalance(mileage);
			}
		}
	}
	
	/**
	 * @author 서영
	 * 마일리지 티켓 결제
	 */
	@Transactional
	public void createUseMilesDataByTicket(String memberId, Long price, String ticketId) {
		// 결제할 마일리지
		Long useMileage = price;
		// 유효 기간이 남은 적립 마일리지 목록
		List<Mileage> mileageList = mileageRepository.selectNowMileage(memberId);
		
		// 마일리지 사용 내역 추가
		Mileage useMiles = Mileage.builder()
							.useMileage(useMileage)
							.description("항공권 예매")
							.memberId(memberId)
							.ticketId(ticketId)
							.build();
		mileageRepository.insertUseMileageByTicket(useMiles);
		
		for (Mileage m : mileageList) {
			// 해당 내역의 잔여 마일리지가 결제할 마일리지보다 많거나 서로 같다면
			if (m.getBalance() >= useMileage) {
				Long updateMileage = m.getBalance() - useMileage;

				m.setBalance(updateMileage);
				m.setMileageFromBalance(useMileage);
				m.setDateFormExpiration(m.getExpirationDate());
				m.setTicketId(ticketId);
				
				// 마일리지 차감
				mileageRepository.updateBalance(m);
				
				// 마일리지 사용 내역 상세 추가
				UseMileage useMilesDetail = new UseMileage(useMileage, m.getId(), ticketId);
				mileageRepository.insertUseMileageDetailByTicket(useMilesDetail);
				
				useMileage = (long) 0;
				break;
				
			// 해당 내역의 잔여 마일리지가 결제할 마일리지보다 적다면 (다음 반복으로 넘어감)
			} else {
				useMileage = useMileage - m.getBalance();
				
				// 마일리지 사용 내역 상세 추가
				UseMileage useMilesDetail = new UseMileage(m.getBalance(), m.getId(), ticketId);
				
				m.setMileageFromBalance(m.getBalance());
				m.setDateFormExpiration(m.getExpirationDate());
				m.setTicketId(ticketId);
				m.setBalance((long) 0);
				
				// 마일리지 차감
				mileageRepository.updateBalance(m);
				
				mileageRepository.insertUseMileageDetailByTicket(useMilesDetail);
			}
		}
	}
	
	/**
	 * @author 서영
	 * 티켓 마일리지 결제 환불 처리
	 */
	@Transactional
	public void updateUseMilesDataStatus(String memberId, Long fee, Long refundAmount, String ticketId) {
		// refundAmount : 수수료를 제외하고, 환불해주어야 하는 총 마일리지
		
		// 환불 수수료를 사용 내역으로 남김
		Mileage useMiles = Mileage.builder()
							.useMileage(fee)
							.description("항공권 환불 수수료")
							.memberId(memberId)
							.ticketId(ticketId)
							.build();
		mileageRepository.insertUseMileageByTicket(useMiles);
		
		// 마일리지 상세 사용 내역 가져오기
		List<UseMileage> useMilesDetailList = mileageRepository.selectUseMileageDataDetailByTicketId(ticketId);
		// mileageFromBalance : 해당 적립 내역에서 사용한 마일리지
		
		// 유효기간이 적은 마일리지부터 돌려줌
		for (UseMileage u : useMilesDetailList) {
			// 환불 잔여 마일리지보다 해당 적립 내역에 돌려주어야 하는 마일리지가 적거나 서로 같다면 (다음 반복 진행)
			if (refundAmount >= u.getMileageFromBalance()) {
				// 환불 잔여 마일리지 차감
				refundAmount -= u.getMileageFromBalance();
				
				// 해당 내역으로 마일리지 적립 내역 추가
				// 유효기간이 기존 마일리지와 동일해야 하며,
				
				// 해당 적립 내역의 유효기간 가져오기
				Timestamp expirationDate = mileageRepository.selectById(u.getBuyMileageId()).getExpirationDate();
				
				// 환불된 마일리지를 적립 내역으로 남김
				Mileage refundMiles = Mileage.builder()
									.saveMileage(u.getMileageFromBalance())
									.balance(u.getMileageFromBalance())
									.description("항공권 환불")
									.expirationDate(expirationDate)
									.memberId(memberId)
									.ticketId(ticketId)
									.build();
				mileageRepository.insertRefundMiles(refundMiles);
				
			// 환불 잔여 마일리지보다 해당 적립 내역에 돌려주어야 하는 마일리지가 크다면
			// 환불 수수료가 부과되었다는 의미 (반복 종료)
			} else {
				
				// 해당 적립 내역의 유효기간 가져오기
				Timestamp expirationDate = mileageRepository.selectById(u.getBuyMileageId()).getExpirationDate();
				
				// 환불된 마일리지를 적립 내역으로 남김
				Mileage refundMiles = Mileage.builder()
									.saveMileage(refundAmount)
									.balance(refundAmount)
									.description("항공권 환불")
									.expirationDate(expirationDate)
									.memberId(memberId)
									.ticketId(ticketId)
									.build();
				mileageRepository.insertRefundMiles(refundMiles);
				
				// 환불 잔여 마일리지 차감
				refundAmount = (long) 0;
				
				break;
			}
		}
	}
	
	
	
}
