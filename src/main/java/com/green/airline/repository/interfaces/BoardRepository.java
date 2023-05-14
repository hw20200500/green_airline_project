package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.repository.model.Board;

@Mapper
public interface BoardRepository {
	
	public List<Board> findByBoardList();
	
	public int insertBoard(Board board);
	
}
