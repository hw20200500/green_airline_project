package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.dto.request.NoticeRequestDto;
import com.green.airline.dto.response.NoticeResponseDto;
import com.green.airline.repository.interfaces.NoticeRepository;
import com.green.airline.repository.model.Notice;
import com.green.airline.repository.model.NoticeCategory;

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

	public List<NoticeResponseDto> readNotice() {
		List<NoticeResponseDto> noticeList = noticeRepository.selectNotice();
		return noticeList;
	}

	public List<NoticeResponseDto> readNoticeByTitle(String keyword) {
		keyword = "%" + keyword + "%";
		List<NoticeResponseDto> noticeResponseDtoList = noticeRepository.selectNoticeByTitle(keyword);

		return noticeResponseDtoList;
	}

	public NoticeResponseDto readNoticeById(int id) {
		NoticeResponseDto noticeResponseDto = noticeRepository.selectNoticeById(id);

		return noticeResponseDto;
	}

	public List<NoticeResponseDto> readNoticeByCategoryId(int categoryId) {
		List<NoticeResponseDto> noticeResponseDtos = noticeRepository.selectNoticeByCategoryId(categoryId);

		return noticeResponseDtos;
	}

}
