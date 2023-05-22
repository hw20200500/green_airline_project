package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;

@Mapper
public interface MileageRepository {

	@Select("${selectSaveMileageQuery}")
    SaveMileageDto selectSaveMileage(String memberId);
	
	//public SaveMileageDto selectSaveMileage(String memberId);
	public UseMileageDto selectUseMileage(String memberId);
}
