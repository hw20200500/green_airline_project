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
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.request.NoticeRequestDto;
import com.green.airline.dto.response.NoticeResponseDto;
import com.green.airline.repository.model.Notice;
import com.green.airline.repository.model.NoticeCategory;
import com.green.airline.service.NoticeService;
import com.green.airline.service.XssSanitizerService;
import com.green.airline.utils.PagingObj;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
    private XssSanitizerService xssSanitizerService;

	@Autowired
	private NoticeService noticeService;

	// 관리자 측 공지사항 작성 페이지
	@GetMapping("/write")
	public String noticeInsertPage(NoticeCategory noticeCategory, Model model) {
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);

		return "/notice/write";
	}

	// 관리자 측 공지사항 작성 기능
	@PostMapping("/noticeInsert")
	public String noticeInsert(Notice notice) {
		noticeService.createdNotice(notice);
		try {
            // Step 1: src 속성의 위험한 값이 있는지 검증
            xssSanitizerService.sanitizeHtmlContent(notice.getContent());
            
            // Step 2: 정상적인 경우 HTML 그대로 저장 (예시)
            // postService.save(postContent);
            
        } catch (IllegalArgumentException e) {
            // Step 3: 위험한 src 값이 있는 경우 alert 창 출력
            return "<html><body>" +
                   "<script>" +
                   "alert('" + e.getMessage() + "');" +
                   "window.history.back();" + // 이전 페이지로 돌아가도록 설정
                   "</script>" +
                   "</body></html>";
        }
		return "redirect:/notice/noticeList";
	}

	// 공지사항 페이지
	@GetMapping("/noticeList")
	public String noticePage(Model model,
			@RequestParam(name = "nowPage", defaultValue = "1", required = false) String nowPage,
			@RequestParam(name = "cntPerPage", defaultValue = "10", required = false) String cntPerPage) {
		// 총 게시글 개수 가져오기
		int total = noticeService.readNoticeCount();
		PagingObj obj = new PagingObj(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		model.addAttribute("paging", obj);
		List<NoticeResponseDto> noticeList = noticeService.readNotice(obj);
		model.addAttribute("noticeList", noticeList);
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("category", 1);

		return "/notice/noticeList";
	}

	@GetMapping("/noticeSearch")
	public String noticeSearch(String keyword,
			@RequestParam(name = "nowPage", defaultValue = "1", required = false) String nowPage,
			@RequestParam(name = "cntPerPage", defaultValue = "10", required = false) String cntPerPage, Model model) {
		int total = 0;
		if (keyword.equals("")) {
			total = noticeService.readNoticeCount();
		} else {
			total = noticeService.readNoticeByKeywordCount(keyword);
		}
		PagingObj obj = new PagingObj(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		List<NoticeResponseDto> noticeList = noticeService.readNoticeByTitle(obj, keyword);

		model.addAttribute("paging", obj);
		model.addAttribute("noticeList", noticeList);
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);

		return "/notice/noticeList";
	}

	// 공지사항 카테고리별 출력
	@GetMapping("/noticeCategory/{categoryId}")
	public String noticeCategory(@PathVariable int categoryId, Model model,
			@RequestParam(name = "nowPage", defaultValue = "1", required = false) String nowPage,
			@RequestParam(name = "cntPerPage", defaultValue = "10", required = false) String cntPerPage) {

		int total = 0;
		if (categoryId == 1) {
			total = noticeService.readNoticeCount();
		} else {
			total = noticeService.readNoticeByCategoryIdCount(categoryId);
		}

		PagingObj obj = new PagingObj(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", obj);
		List<NoticeResponseDto> noticeList = noticeService.readNoticeByCategoryId(obj, categoryId);
		model.addAttribute("noticeList", noticeList);
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("category", categoryId);

		return "/notice/noticeList";
	}

	// id기반 공지사항 상세글 조회
	@GetMapping("/noticeDetail/{id}")
	public String noticeDetailPage(@PathVariable Integer id, Model model) {
		NoticeResponseDto noticeList = noticeService.readNoticeById(id);
		System.out.println("id : " + id);
		System.out.println("notcieList : " + noticeList);
		model.addAttribute("noticeList", noticeList);

		return "/notice/noticeDetail";
	}

	@GetMapping("/noticeDelete")
	public String noticeDelete(@RequestParam Integer id) {
		noticeService.deleteNoticeById(id);
		return "redirect:/notice/noticeList";
	}

	@GetMapping("/noticeUpdate")
	public String noticeUpdate(@RequestParam Integer id, Model model) {
		NoticeResponseDto noticeResponseDto = noticeService.readNoticeById(id);
		List<NoticeCategory> categoryList = noticeService.readNoticeCategory();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("id", id);
		model.addAttribute("noticeResponseDto", noticeResponseDto);
		return "/notice/noticeUpdate";
	}

	@PostMapping("/noticeUpdate")
	public String noticeUpdateProc(Notice notice, Model model) {
		noticeService.updateNoticeById(notice);
		return "redirect:/notice/noticeList";
	}

}
