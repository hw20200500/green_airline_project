package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.request.NoticeRequestDto;
import com.green.airline.dto.response.NoticeResponseDto;
import com.green.airline.repository.interfaces.NoticeRepository;
import com.green.airline.repository.model.Notice;
import com.green.airline.repository.model.NoticeCategory;
import com.green.airline.utils.PagingObj;

@Service
public class NoticeService {

	@Autowired
	private NoticeRepository noticeRepository;

	public void createdNotice(Notice notice) {
		int result = noticeRepository.insertNotice(notice);

		if (result == 1) {
			System.out.println("notice 작성 성공");
		} else {
			System.err.println("notice 작성 실패");
		}
	}

	public List<NoticeCategory> readNoticeCategory() {
		List<NoticeCategory> noticeCategoryList = noticeRepository.selectNoticeCategory();

		return noticeCategoryList;
	}
	
	public int readNoticeCount() {
		int resultCount = noticeRepository.selectNoticeCount();
		return resultCount;
	}
	
	public int readNoticeByCategoryIdCount(Integer categoryId) {
		int resultCount = noticeRepository.selectNoticeByCategoryIdCount(categoryId);
		return resultCount;
	}

	public List<NoticeResponseDto> readNotice(PagingObj obj) {
		List<NoticeResponseDto> noticeList = noticeRepository.selectNotice(obj);
		return noticeList;
	}

	public List<NoticeResponseDto> readNoticeByTitle(PagingObj obj, String keyword) {
		keyword = "%" + keyword + "%";
		List<NoticeResponseDto> noticeResponseDtoList = noticeRepository.selectNoticeByTitle(obj, keyword);

		return noticeResponseDtoList;
	}
	
	// 페이징 처리에 사용 ) 공지사항 검색 글 총 개수 가져오기
	public int readNoticeByKeywordCount(String keyword) {
		keyword = "%" + keyword + "%";
		int resultCnt = noticeRepository.selectNoticeByKeywordCount(keyword);
		return resultCnt;
	}

	public NoticeResponseDto readNoticeById(int id) {
		NoticeResponseDto noticeResponseDto = noticeRepository.selectNoticeById(id);

		return noticeResponseDto;
	}

	public List<NoticeResponseDto> readNoticeByCategoryId(PagingObj obj, int categoryId) {
		List<NoticeResponseDto> noticeResponseDtos = noticeRepository.selectNoticeByCategoryId(obj, categoryId);

		return noticeResponseDtos;
	}

	// 관리자 측 게시글 삭제
	public void deleteNoticeById(Integer id) {
		int result = noticeRepository.deleteNoticeById(id);
		if (result == 1) {
			System.out.println("삭제 성공");
		}
	}

	// 관리자 측 게시글 수정
	public void updateNoticeById(Notice notice) {
		int result = noticeRepository.updateNoticeById(notice);
		if (result == 1) {
			System.out.println("수정 성공");
		}
	}
	
	/**
	 * @author 서영
	 * 메인페이지용 
	 */
	public List<NoticeResponseDto> readOrderByCreatedAtDescLimitN(Integer limitCount) {
		return noticeRepository.selectOrderByIdDescLimitN(limitCount);
	}

}
