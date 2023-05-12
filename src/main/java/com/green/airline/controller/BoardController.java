package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.green.airline.repository.model.Board;
import com.green.airline.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	// 추천여행지 전체 보기
	@GetMapping("/boardList")
	public String test(Model model) {

		List<Board> boardList = boardService.boardList();
		if (boardList.isEmpty()) {
			model.addAttribute("boardList", null);
		} else {
			model.addAttribute("boardList", boardList);
		}

		return "/board/recommendBoard";
	}

	// 추천여행지 상세 보기

	// 글쓰기 페이지
}
