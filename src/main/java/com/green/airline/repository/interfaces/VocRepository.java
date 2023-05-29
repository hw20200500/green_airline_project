package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.response.VocInfoDto;
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
	
	// voc 게시글 정보 + 그에 해당하는 답변 정보
	public List<VocInfoDto> selectByMemberId(String memberId);
	
	public VocInfoDto selectById(Integer id);
	
	public Integer deleteById(Integer id);
	
}
