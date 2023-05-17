package com.green.airline.repository.interfaces;

import java.util.List;

import javax.websocket.server.PathParam;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.BoardListDto;
import com.green.airline.repository.model.Board;

@Mapper
public interface BoardRepository {
	
	// 게시물 목록 전체 조회
	public List<Board> findByBoardList();
	// 게시물 쓰기
	public int insertBoard(Board board);
	// 게시물 상세 보기
	public BoardListDto findByBoardDetail(Integer id);
	// 상세보기시 조회수 증가
	public void updateBoardCount(Integer id);
}
