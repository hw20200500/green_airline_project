package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.VocInfoDto;
import com.green.airline.repository.model.Voc;
import com.green.airline.repository.model.VocAnswer;
import com.green.airline.repository.model.VocAnswerForm;
import com.green.airline.repository.model.VocCategory;

/**
 * @author 서영
 * 고객의 소리 관련
 */
@Mapper
public interface VocRepository {

	public List<VocCategory> selectCategoryList();
	
	public Integer insert(Voc voc);
	
	// 회원 : voc 게시글 정보 + 그에 해당하는 답변 정보 전체
	public List<VocInfoDto> selectByMemberId(String memberId);
	
	// 회원 : voc 게시글 정보 + 그에 해당하는 답변 정보 페이징 처리용
	public List<VocInfoDto> selectByMemberIdLimit(@Param("memberId") String memberId, @Param("index") Integer index);
	
	// 관리자 : voc 게시글 정보 + 그에 해당하는 답변 정보 전체
	public List<VocInfoDto> selectAll(Integer type);
	
	// 관리자 : voc 게시글 정보 + 그에 해당하는 답변 정보 페이징 처리용
	public List<VocInfoDto> selectAllLimit(@Param("index") Integer index, @Param("type") Integer type);
	
	public VocInfoDto selectById(Integer id);
	
	public Integer deleteById(Integer id);
	
	public Integer updateById(Voc voc);
	
	// 답변 양식
	public List<VocAnswerForm> selectFormList();
	
	// 답변 처리
	public Integer insertAnswer(VocAnswer vocAnswer);
	
}
