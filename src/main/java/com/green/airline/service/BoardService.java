package com.green.airline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.repository.interfaces.BoardInterface;
import com.green.airline.repository.model.Board;

@Service
public class BoardService {
	
	@Autowired
	private BoardInterface boardInterface;
	
	@Transactional
	public List<Board> boardList(){
		
		List<Board> list = boardInterface.findByBoardList();
		
		return list;
	}
	
}