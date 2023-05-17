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

		int result = boardRepository.insertByBoard(board);
		if (result != 1) {
			// todo 예외처리
		}

	}

	// 추천 여행지 게시글 상세보기
	public Board boardListDetail(Integer id) {

		Board board = boardRepository.findByBoardDetail(id);

		return board;
	}

	public void viewCountCookie(Integer id, HttpServletRequest request, HttpServletResponse response) {

		Board board = new Board();
		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;
		boolean isCookie = false;

		for (int i = 0; cookies != null && i < cookies.length; i++) {
			// newMember 쿠키가 있으면 배열에 쿠키 넣기
			if (!cookies[i].getName().equals("newMember")) {
				cookie = cookies[i];

				// 게시글 번호가 쿠키에 포함되어있지 않으면 조회수 증가
				if (!cookie.getValue().contains("[" + id + "]")) {
					boardRepository.updateByViewCount(id);
					cookie.setValue(cookie.getValue() + "[" + id + "]");
				}
				isCookie = true;
				break;
			}
		}

		// 쿠키가 없으면 새 쿠키 생성, 조회수 증가
		if (!isCookie) {
			boardRepository.updateByViewCount(board.getViewCount());
			cookie = new Cookie("newMember", "[" + id + "]");
		}

		// 쿠키 초기화 00시로 설정
		// 현재 하루의 종료 시간, YYYY-MM-DDT23:59:59.9999999
		LocalDateTime todayEndTime = LocalDate.now().atTime(LocalTime.MAX);
		// 현재 시간, YYYY-MM-DDT19:39:10.936
		LocalDateTime currentTime = LocalDateTime.now();
		// 하루 종료 시간을 시간초로 변환
		long todayEndSecond = todayEndTime.toEpochSecond(ZoneOffset.UTC);
		// 현재 시간을 시간초로 변환
		long currentSecond = currentTime.toEpochSecond(ZoneOffset.UTC);
		// 모든 경로에서 접근 가능
		cookie.setPath("/");

		// 하루 종료시간 - 현재 시간
		cookie.setMaxAge((int) (todayEndSecond - currentSecond));

		response.addCookie(cookie);

	}

}