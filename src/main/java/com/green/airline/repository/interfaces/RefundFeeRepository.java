package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.repository.model.RefundFee;

@Mapper
public interface RefundFeeRepository {

	// 출발일 며칠 이전인지 + 국내선/국제선에 따라 환불 수수료 결정
	public Long selectByCriterionAndType(@Param("criterion") Integer criterion, @Param("type") Integer type);
	
	public List<RefundFee> selectByType(Integer type); 
	
}
