package com.green.airline.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.GifticonDto;
import com.green.airline.repository.interfaces.GifticonRepository;
import com.green.airline.repository.interfaces.MileageRepository;
import com.green.airline.repository.model.Mileage;

@Service
public class GifticonService {

	@Autowired
	private GifticonRepository gifticonRepository;
	@Autowired
	private MileageRepository mileageRepository;
	public List<GifticonDto> readGifticonListById(String memberId,String startTime,String endTime,String radio){
		List<GifticonDto> gifticonDtos = gifticonRepository.selectGifticonList(memberId,startTime,endTime,radio);
		return gifticonDtos; 
	}
	public List<GifticonDto> readGifticonListByIdForManager(String memberId,String startTime,String endTime,String radio){
		List<GifticonDto> gifticonDtos = gifticonRepository.selectGifticonListForManager(memberId,startTime,endTime,radio);
		return gifticonDtos; 
	}
	public int createRevokeGifticon(String gifticonId) {
		int result = gifticonRepository.insertRevokeGifticon(gifticonId);
		return result;
	}
	
	public void updateMileageAndGifticonStatus(String memberId, String gifticonId) {
		// 기프티콘 상태값 업데이트
		List<Mileage> mileage = mileageRepository.selectUseDataListTb(memberId,gifticonId);

		for (Mileage m : mileage) {
			int id = m.getBuyMileageId();
			// 해당 적립 내역의 유효기간 가져오기
			Timestamp expirationDate = mileageRepository.selectById(id).getExpirationDate();
			
			// 환불된 마일리지를 적립 내역으로 남김
			Mileage refundMiles = Mileage.builder()
					.saveMileage(m.getMileageFromBalance())
					.balance(m.getMileageFromBalance())
					.description("기프티콘 환불")
					.expirationDate(expirationDate)
					.memberId(memberId)
					.build();
			mileageRepository.insertRefundMiles(refundMiles);
		}
		
		gifticonRepository.updateGifticonStatus(gifticonId);
	}
	
	// 기프티콘 구매 수량 확인 마이페이지 적용
	public GifticonDto readGifticonCount(String memberId) {
		GifticonDto count = gifticonRepository.selectGifticonCount(memberId);
		return count;
	}
}
