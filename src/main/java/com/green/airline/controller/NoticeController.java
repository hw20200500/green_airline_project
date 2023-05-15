package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.dto.request.NoticeRequestDto;
import com.green.airline.dto.response.NoticeResponseDto;
import com.green.airline.repository.model.Notice;
import com.green.airline.repository.model.NoticeCategory;
import com.green.airline.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	// 관리자 측 공지사항 작성 페이지
	@GetMapping("/noticeInsert")
	public String noticeInsertPage(NoticeCategory noticeCategory, Model model) {
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);

		return "/notice/noticeInsert";
	}

	// 관리자 측 공지사항 작성 기능
	@PostMapping("/noticeInsert")
	public String noticeInsert(Notice notice) {
		noticeService.createdNotice(notice);

		return "redirect:/notice/noticeList";
	}

	// 공지사항 페이지
	@GetMapping("/noticeList")
	public String noticePage(Model model) {
		// Todo
		// 공지사항 select
		List<NoticeResponseDto> noticeList = noticeService.readNotice();
		model.addAttribute("noticeList", noticeList);
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);

		return "/notice/noticeList";
	}

	@GetMapping("/noticeSearch")
	public String noticeSearch(@RequestParam String keyword, Model model) {
		List<NoticeResponseDto> noticeList = noticeService.readNoticeByTitle(keyword);
		model.addAttribute("noticeList", noticeList);
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);

		return "/notice/noticeList";
	}

	// 공지사항 카테고리별 출력
	@GetMapping("/noticeCategory/{categoryId}")
	public String noticeCategory(@PathVariable int categoryId, Model model) {
		// todo
		// categoryId 받아오기
		List<NoticeResponseDto> noticeList = noticeService.readNoticeByCategoryId(categoryId);
		model.addAttribute("noticeList", noticeList);
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);

		return "/notice/noticeList";
	}

	@GetMapping("/noticeDetail/{id}")
	public String noticeDetailPage(@PathVariable Integer id, Model model) {
		NoticeResponseDto noticeResponseDto = noticeService.readNoticeById(id);
		model.addAttribute("noticeResponseDto", noticeResponseDto);

		return "/notice/noticeDetail";
	}

}
