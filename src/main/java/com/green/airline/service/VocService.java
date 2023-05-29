package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.VocInfoDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.interfaces.VocRepository;
import com.green.airline.repository.model.Voc;
import com.green.airline.repository.model.VocCategory;

/**
 * @author 서영
 * 고객의 말씀 관련
 */
@Service
public class VocService {

	@Autowired
	private VocRepository vocRepository;
	
	@Transactional
	public List<VocCategory> readCategoryList() {
		return vocRepository.selectCategoryList();
	}
	
	/**
	 * 문의 게시글 작성
	 */
	@Transactional
	public void createVoc(Voc voc) {
		Integer resultRowCount = vocRepository.insert(voc);
		if (resultRowCount != 1) {
			System.out.println("작성 실패");
		}
	}
	
	/**
	 * 해당 유저가 작성한 게시글 목록
	 */
	@Transactional
	public List<VocInfoDto> readVocListByMemberId(String memberId) {
		return vocRepository.selectByMemberId(memberId);
	}
	
	/**
	 * 특정 게시글 정보
	 */
	@Transactional
	public VocInfoDto readVocById(Integer id) {
		return vocRepository.selectById(id);
	}
	
	/**
	 * 게시글 삭제 
	 */
	@Transactional
	public Integer deleteById(Integer id) {
		
		Integer resultRowCount = 0;
		
		// 해당 게시글이 존재하는지 확인
		VocInfoDto vocEntity = vocRepository.selectById(id);
		
		if (vocEntity != null) {
			resultRowCount = vocRepository.deleteById(id);
		}
		
		return resultRowCount;
	}
	
}
