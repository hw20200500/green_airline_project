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
import org.springframework.web.servlet.ModelAndView;

import com.green.airline.dto.BoardListDto;
import com.green.airline.repository.interfaces.BoardRepository;
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
		System.out.println(boardList);
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
	public String boardWirteProc(BoardListDto boardListDto) {

		boardService.insertBoard(boardListDto);

		return "redirect:/board/list";
	}

	// 추천여행지 상세 보기
	@GetMapping("/detail/{id}")
	public BoardListDto boardDetail(@PathVariable Integer id, Model model) {
		
		System.out.println("컨트롤러 진입");
		
		BoardListDto boardDto = boardService.boardListDetail(id);
		model.addAttribute("boardDto" + boardDto);
		
		System.out.println("boardDto : " + boardDto);
		
		return boardService.boardListDetail(id);
	}

}
