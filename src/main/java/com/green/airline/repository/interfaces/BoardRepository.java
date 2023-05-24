package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.BoardDto;
import com.green.airline.repository.model.Board;
import com.green.airline.repository.model.LikeHeart;

@Mapper
public interface BoardRepository {
	
	// 게시물 목록 전체 조회, 좋아요 수 조회
	public List<Board> selectByBoardList();
	// 게시물 쓰기
	public int insertByBoard(BoardDto boardDto);
	// 게시물 상세 보기
	public BoardDto selectByBoardDetail(Integer id);
	// 게시물 조회 수 증가
	public void updateByViewCount(Integer id);
	// 좋아요 
	public int insertByHeart(@Param("id") Integer id, @Param("userId") String userId);
	// 좋아요 취소
	public int deleteByHeart(@Param("id") Integer id, @Param("userId") String userId);
	// 좋아요 수 조회
	public List<LikeHeart> selectByLikeUser(Integer id);
	// 게시물에 좋아요를 누른 유저 조회
	public List<LikeHeart> selectByBoardIdAndLikeUser(@Param("id") Integer id, @Param("userId") String userId);
}
