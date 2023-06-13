package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.CountByYearAndMonthDto;
import com.green.airline.dto.response.VocCountByTypeDto;
import com.green.airline.dto.response.VocInfoDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.interfaces.VocRepository;
import com.green.airline.repository.model.Voc;
import com.green.airline.repository.model.VocAnswer;
import com.green.airline.repository.model.VocAnswerForm;
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
	 * 해당 유저가 작성한 게시글 목록 페이징용
	 */
	@Transactional
	public List<VocInfoDto> readVocListByMemberIdLimit(String memberId, Integer index) {
		return vocRepository.selectByMemberIdLimit(memberId, index);
	}
	
	/**
	 * 전체 게시글 목록
	 * type : 0 > 처리되지 않은, 1 > 처리된
	 */
	@Transactional
	public List<VocInfoDto> readVocList(Integer type) {
		return vocRepository.selectAll(type);
	}
	
	/**
	 * 전체 게시글 목록 페이징용
	 * type : 0 > 처리되지 않은, 1 > 처리된
	 */
	@Transactional
	public List<VocInfoDto> readVocListLimit(Integer index, Integer type, Integer limitCount) {
		return vocRepository.selectAllLimit(index, type, limitCount);
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
	public Integer deleteById(Integer id, String memberId) {
		
		Integer resultRowCount = 0;
		
		// 해당 게시글이 존재하는지 확인
		VocInfoDto vocEntity = vocRepository.selectById(id);
		
		if (vocEntity != null) {

			// 작성자와 현재 로그인된 사용자의 아이디가 일치한다면
			if (memberId.equals(vocEntity.getMemberId())) {
				resultRowCount = vocRepository.deleteById(id);
			} else {
				throw new CustomRestfullException("삭제 권한이 없습니다.", HttpStatus.FORBIDDEN);
			}
			
		}
		return resultRowCount;
	}
	
	/**
	 * 게시글 수정
	 */
	@Transactional
	public void updateById(Voc voc, String memberId) {
		
		// 해당 게시글이 존재하는지 확인
		VocInfoDto vocEntity = vocRepository.selectById(voc.getId());
		
		if (vocEntity != null) {

			// 작성자와 현재 로그인된 사용자의 아이디가 일치한다면
			if (memberId.equals(vocEntity.getMemberId())) {
				vocRepository.updateById(voc);
			} else {
				throw new CustomRestfullException("수정 권한이 없습니다.", HttpStatus.FORBIDDEN);
			}
			
		}
	}
	
	/**
	 * @return 답변 양식 리스트
	 */
	@Transactional
	public List<VocAnswerForm> readFormList() {
		return vocRepository.selectFormList();
	}
	
	/**
	 * 답변 작성 처리
	 */
	@Transactional
	public void createAnswer(VocAnswer vocAnswer) {
		vocRepository.insertAnswer(vocAnswer);
	}
	
	/**
	 * 해당 월에 작성된 고객의 말씀 수
	 */
	public CountByYearAndMonthDto readWriteCount(Integer year, Integer month) {
		return vocRepository.selectCountByMonth(year, month);
	}
	
	/**
	 * 해당 월에 작성된 고객의 말씀 유형별 개수
	 */
	public List<VocCountByTypeDto> readWriteCountGroupByType(Integer year, Integer month) {
		return vocRepository.selectCountByMonthGroupByType(year, month);
	}
	
	/**
	 * 지문/ 답변 카운트 수 조회
	 */
	public VocInfoDto readVocCountAndAnserCountByMemberId(String memberId) {
		return vocRepository.selectVocCountAndAnserCountByMemberId(memberId);
	}
}
