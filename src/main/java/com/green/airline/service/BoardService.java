package com.green.airline.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.BoardDto;
import com.green.airline.repository.interfaces.BoardRepository;
import com.green.airline.repository.model.Board;
import com.green.airline.repository.model.LikeHeart;
import com.green.airline.repository.model.User;
import com.green.airline.utils.Define;

/**
 * @author 치승 추천 여행지 게시글
 */
@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	@Autowired
	private HttpSession session;

	// 추천 여행지 게시글 전체 보기
	@Transactional
	public List<Board> boardList() {

		List<Board> list = boardRepository.selectByBoardList();

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
	public BoardDto boardListDetail(Integer id) {

		BoardDto board = boardRepository.selectByBoardDetail(id);

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

	// 좋아요 조회
	public BoardDto selectLikeHeart(Integer id) {

		BoardDto board = boardRepository.selectByBoardDetail(id);

		// 1. userId, boardId 값 들고오기
		List<LikeHeart> likeUser = boardRepository.selectByLikeUser(id);

		// 2. userId가 boardId로 사이즈 구하기
		Integer heartCount = likeUser.size();

		board.setHeartCount(heartCount);

		return board;
	}

	// 좋아요 추가, 삭제
	public boolean heartInDecrease(Integer id) {

		// 좋아요 누른 유저 아이디
		List<LikeHeart> likeUser = boardRepository.selectByLikeUser(id);
		System.out.println(likeUser);

		boolean registration = false;
		int result;
		
		// 좋아요 누른 유저아이디가 없는 경우
		if (!likeUser.isEmpty()) {
			// 현재 로그인 되어있는 유저 아이디
			User user = (User) session.getAttribute(Define.PRINCIPAL);
			System.out.println(user);

			// 게시물 id
			Integer boardId = likeUser.get(0).getBoardId();
			System.out.println("1111" + boardId);

			// 현재 로그인 되어있는 유저 id
			String userId = user.getId();
			System.out.println("2222" + userId);

			// 찜을 누른 모든 유저 정보
			List<LikeHeart> list = boardRepository.selectByBoardIdAndLikeUser(boardId, userId);
			System.out.println("3333" + list);

			// 찜 누른 유저정보에서 id값만 가져오기
			String selectLikeUserId = list.get(0).getUserId().toString();
			System.out.println("4444" + selectLikeUserId);

			System.out.println(list); // 쿼리에 현재 로그인 되어있는 id가 있는지 확인

			System.out.println(selectLikeUserId);
			System.out.println(userId);

			if (userId != selectLikeUserId) {
				result = boardRepository.insertByHeart(boardId, userId);
				System.out.println("////insert" + result);
				registration = true;
			} else {
				result = boardRepository.deleteByHeart(boardId, userId);
				System.out.println("////delete" + result);
				registration = false;
			}
		}
		return registration;
	}

}
