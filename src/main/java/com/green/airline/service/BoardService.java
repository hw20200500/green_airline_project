package com.green.airline.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.green.airline.dto.BoardHeartDto;
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
	public void insertBoard(Board board) {

		board.setTitle(board.getTitle());
		board.setUserId(board.getUserId());
		board.setContent(board.getContent());
		board.setViewCount(board.getViewCount());

		int result = boardRepository.insertByBoard(board);
		if (result != 1) {
			// todo 예외처리
		}

	}

	// 추천 여행지 게시글 상세보기
	public BoardHeartDto boardListDetail(Integer id) {

		BoardHeartDto board = boardRepository.findByBoardDetail(id);

		return board;
	}

	// 게시글 상세보기 시 조회수 증가
	public boolean viewCountCookie(Integer id, HttpServletRequest request, HttpServletResponse response) {

		Cookie oldCookie = null;

		Cookie[] cookies = request.getCookies();
		// 쿠키 초기화 00시로 설정
		// 현재 하루의 종료 시간, YYYY-MM-DDT23:59:59.9999999
		LocalDateTime todayEndTime = LocalDate.now().atTime(LocalTime.MAX);
		// 현재 시간, YYYY-MM-DDT19:39:10.936
		LocalDateTime currentTime = LocalDateTime.now();
		// 하루 종료 시간을 시간초로 변환
		long todayEndSecond = todayEndTime.toEpochSecond(ZoneOffset.UTC);
		// 현재 시간을 시간초로 변환
		long currentSecond = currentTime.toEpochSecond(ZoneOffset.UTC);

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				// newMember 쿠키가 있으면 배열에 쿠키 넣기
				if (cookie.getName().equals("newMember")) {
					oldCookie = cookie;
				}
			}
		}
		
		if (oldCookie != null) {
			// 쿠키 값에 게시글 번호 없으면 조회수 증가
			if (!oldCookie.getValue().contains("[" + id + "]")) {
				boardRepository.updateByViewCount(id);
				oldCookie.setValue(oldCookie.getValue() + "[" + id + "]");
				// 모든 경로에서 접근 가능
				oldCookie.setPath("/");
				// 하루 종료시간 - 현재 시간
				oldCookie.setMaxAge((int) (todayEndSecond - currentSecond));
				response.addCookie(oldCookie);
				return true;
			}
			// 쿠키가 없으면 새 쿠키 생성, 조회수 증가
		} else {
			boardRepository.updateByViewCount(id);
			Cookie newCookie = new Cookie("newMember", "[" + id + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge((int) (todayEndSecond - currentSecond));
			response.addCookie(newCookie);
			return true;
		}

		return false;
	}
	
	// 좋아요 추가, 취소
	public BoardHeartDto giveLikeHeart(Model model, Integer id) {
		
		BoardHeartDto boardHeartDto;
		
		
		return null;
	}

}








