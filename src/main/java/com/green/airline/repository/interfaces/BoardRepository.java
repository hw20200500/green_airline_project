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
	public int insertByBoard(Board board);
	// 게시물 상세 보기 클릭 시 조회수 증가
	public Board findByBoardDetail(Integer id);
	// 게시물 조회 수 증가
	public void updateByViewCount(Integer viewCount);
}
