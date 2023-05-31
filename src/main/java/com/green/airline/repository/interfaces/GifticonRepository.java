package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.dto.GifticonDto;

import lombok.val;

@Mapper
public interface GifticonRepository {

	public List<GifticonDto> selectGifticonList(@Param("id")String id,@Param("startTime")String startTime,@Param("endTime")String endTime,@Param("radio")String radio);
	public int deleteGifticonBygifticonId(@Param("gifticonId")String[] gifticonId);
	public int insertRevokeGifticon(@Param("amount")String amount,@Param("brand")String brand,@Param("name")String name);
	public GifticonDto selectGifticonLimit();
	// 기프티콘 상태값 업데이트
	public int updateGifticonStatus(@Param("gifticonId")String gifticonId);
	public int updateGifticonStatusChange2(@Param("gifticonId")String gifticonId);
}
