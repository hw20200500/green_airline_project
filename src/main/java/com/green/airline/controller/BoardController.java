package com.green.airline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.dto.BoardListDto;
import com.green.airline.repository.interfaces.BoardRepository;
import com.green.airline.repository.model.Board;
import com.green.airline.service.BoardService;

/**
 * @author 치승 추천 여행지 게시글
 */

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private BoardRepository boardRepository;
	
	// 게시글 전체 보기
	@GetMapping("/board/list")
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
	@PostMapping("/board/insert")
	public String boardWirte(BoardListDto boardListDto) {

		boardService.insertBoard(boardListDto);

		return "redirect:/board/list";
	}

	// 추천여행지 상세 보기
	@GetMapping("/board/detail/{i}")
	public String boardDetail(int id, Model model) {
		
		System.out.println("컨트롤러 진입");
		List<Board> list = boardRepository.findByBoardList();
		model.addAttribute("detail", boardService.Detail(id));
		
		System.out.println(list);
		
		return "board/modalDetail";
	}

}
