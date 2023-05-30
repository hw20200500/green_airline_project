package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.GifticonDto;
import com.green.airline.repository.interfaces.GifticonRepository;

@Service
public class GifticonService {

	@Autowired
	private GifticonRepository gifticonRepository;
	
	public List<GifticonDto> readGifticonListById(String memberId,String startTime,String endTime,String radio){
		List<GifticonDto> gifticonDtos = gifticonRepository.selectGifticonList(memberId,startTime,endTime,radio);
		return gifticonDtos; 
	}
	public int deleteGifticonBygifticonId(String[] gifticonId) {
		int result = gifticonRepository.deleteGifticonBygifticonId(gifticonId);
		return result;
	}
	public int createRevokeGifticon(String[] amount,String[] brand,String[] name) {
		int result = gifticonRepository.insertRevokeGifticon(amount, brand, name);
		return result;
	}
}
