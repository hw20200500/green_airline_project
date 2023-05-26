package com.green.airline.repository.interfaces;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.Ticket;
import com.green.airline.repository.model.UseMileage;

@Mapper
public interface MileageRepository {

	
    public SaveMileageDto selectSaveMileage(String memberId);
	
    public SaveMileageDto selectExtinctionMileage(String memberId);
	public UseMileageDto selectUseMileage(String memberId);
	public List<Mileage> selectMileageList(@Param("memberId")String memberId,@Param("startTime")String startTime,
			@Param("endTime")String endTime,@Param("isAllSearch") String isAllSearch,@Param("isUpSearch")String isUpSearch,
			@Param("isUseSearch")String isUseSearch,@Param("isExpireSearch")String isExpireSearch);
	public List<UseMileage> selectUseMileageList(String memberId);
	public int insertMileage(SaveMileageDto saveMileageDto);
	public List<Mileage> selectNowMileage(String memberId);
	public int updateBalance(Mileage mileage);
	// Repository에서 파라미터 여러 개 쓸 때는 @Param 꼭 써야 되는 거 기억
}
