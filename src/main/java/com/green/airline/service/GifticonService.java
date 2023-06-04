package com.green.airline.service;

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
	public int createRevokeGifticon(String amount,String brand,String name) {
		int result = gifticonRepository.insertRevokeGifticon(amount, brand, name);
		return result;
	}
	
	public void updateMileageAndGifticonStatus(String memberId,String gifticonId) {
		// 기프티콘 상태값 업데이트
		List<Mileage> mileage = mileageRepository.selectUseDataListTb(memberId,gifticonId);
		System.out.println(mileage);
		int id;
		for (int i = 0; i < mileage.size(); i++) {
			id = mileage.get(i).getBuyMileageId();
			mileage.get(i).setBalance(mileage.get(i).getBalance()+mileage.get(i).getMileageFromBalance());
			mileageRepository.updateBalanceById(mileage.get(i),id);
		}
		gifticonRepository.updateGifticonStatus(gifticonId);
//		gifticonRepository.updateGifticonStatusChange2(gifticonId);
		
		
	}
	// 기프티콘 구매 수량 확인 마이페이지 적용
	public GifticonDto readGifticonCount(String memberId) {
		GifticonDto count = gifticonRepository.selectGifticonCount(memberId);
		return count;
	}
}
