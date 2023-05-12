package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.request.NoticeRequestDto;
import com.green.airline.dto.response.NoticeResponseDto;
import com.green.airline.repository.model.Notice;
import com.green.airline.repository.model.NoticeCategory;

@Mapper
public interface NoticeRepository {

	// 관리자 측 공지사항 작성 기능
	int insertNotice(Notice notice);
	
	// 전체 카테고리 출력 기능
	List<NoticeCategory> selectNoticeCategory();
	
	// 전체 공지사항 출력 기능
	List<NoticeResponseDto> selectNotice();
	
	// 공지사항 검색 기능
	List<NoticeRequestDto> selectNoticeByTitle(String keyword);
	
	// 공지사항 상세 페이지 이동
	NoticeResponseDto selectNoticeById(int id);
	
	// 공지사항 카테고리별 출력 기능
	List<NoticeResponseDto> selectNoticeByCategoryId(int categoryId);
	
}
