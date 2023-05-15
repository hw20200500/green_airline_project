package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.BoardListDto;
import com.green.airline.repository.interfaces.BoardRepository;
import com.green.airline.repository.model.Board;

@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	/**
	 * @author 치승
	 * 추천 여행지 게시글 전체 보기
	 */	
	@Transactional
	public List<Board> boardList() {
		
		List<Board> list = boardRepository.findByBoardList();

		return list;
	}

	/**
	 * @author 치승
	 * 추천 여행지 게시글 작성하기
	 */	
	public void insertBoard(BoardListDto boardListDto) {

		Board board = new Board();

		board.setTitle(boardListDto.getTitle());
		board.setUserId(boardListDto.getUserId());
		board.setContent(boardListDto.getContent());
		board.setViewCount(boardListDto.getViewCount());

		int result = boardRepository.insertBoard(board);
		if(result != 1) {
			// 예외처리
		}

	}

}