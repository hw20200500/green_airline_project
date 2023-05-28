package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Voc;
import com.green.airline.repository.model.VocCategory;

/**
 * @author 서영
 * 고객의 소리 관련
 */
@Mapper
public interface VocRepository {

	public List<VocCategory> selectCategoryList();
	
	public Integer insert(Voc voc);
	
}
