package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.BoardListDto;
import com.green.airline.repository.interfaces.BoardRepository;
import com.green.airline.repository.model.Board;

/**
 * @author 치승 추천 여행지 게시글
 */
@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	// 추천 여행지 게시글 전체 보기
	@Transactional
	public List<Board> boardList() {

		List<Board> list = boardRepository.findByBoardList();

		return list;
	}

	// 추천 여행지 게시글 작성
	public void insertBoard(BoardListDto boardListDto) {

		Board board = new Board();

		board.setTitle(boardListDto.getTitle());
		board.setUserId(boardListDto.getUserId());
		board.setContent(boardListDto.getContent());
		board.setViewCount(boardListDto.getViewCount());

		int result = boardRepository.insertBoard(board);
		if (result != 1) {
			// todo 예외처리
		}

	}
	
	// 추천 여행지 게시글 상세보기
	public List<BoardListDto> Detail(String type, String userId) {
		
		List<BoardListDto> detail = boardRepository.findByBoardDetail(type, userId);
		
		if(detail == null) {
			// todo 예외처리
		}
		
		return detail;
	}

}