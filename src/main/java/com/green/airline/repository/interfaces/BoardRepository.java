package com.green.airline.repository.interfaces;

import java.util.List;

import javax.websocket.server.PathParam;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.BoardListDto;
import com.green.airline.repository.model.Board;

@Mapper
public interface BoardRepository {
	
	public List<Board> findByBoardList();
	
	public int insertBoard(Board board);
	
	public List<BoardListDto> findByBoardDetail(@PathParam("type") String type, @Param("userId") String userId);
	
}
