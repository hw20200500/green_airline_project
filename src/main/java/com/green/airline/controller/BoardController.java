package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.BoardHeartDto;
import com.green.airline.repository.model.Board;
import com.green.airline.service.BoardService;

/**
 * @author 치승 추천 여행지 게시글
 */

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	// 게시글 전체 보기
	@GetMapping("/list")
	public String boardListAllPage(Model model) {

		List<Board> boardList = boardService.boardList();
		if (boardList.isEmpty()) {
			model.addAttribute("boardList", null);
		} else {
			model.addAttribute("boardList", boardList);
		}

		return "/board/recommendBoard";
	}

	// 게시글 작성하기
	@GetMapping("/insert")
	public String boardWrite() {
		return "/board/boardWrite";
	}

	// 게시글 작성하기
	@PostMapping("/insert")
	public String boardWirteProc(Board Board) {

		boardService.insertBoard(Board);

		return "redirect:/board/list";
	}

	// 추천여행지 상세 보기
	@ResponseBody
	@GetMapping("/detail/{id}")
	public BoardHeartDto boardDetail(@PathVariable Integer id, HttpServletRequest request, HttpServletResponse response) {
		
		BoardHeartDto boardDto = boardService.boardListDetail(id);

		boolean viewUp = boardService.viewCountCookie(id, request, response);

		// 모달창 띄웠을 때 조회수 증가한 화면 보여주기
		if (viewUp) {
			boardDto.setViewCount(boardDto.getViewCount() + 1);
		}

		return boardDto;
	}
	
}
