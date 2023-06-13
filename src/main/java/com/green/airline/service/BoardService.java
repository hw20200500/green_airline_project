package com.green.airline.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.BoardDto;
import com.green.airline.dto.BoardUpdateDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.interfaces.BoardRepository;
import com.green.airline.repository.model.Board;
import com.green.airline.repository.model.LoveHeart;
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
	public List<Board> readByBoardList() {

		List<Board> list = boardRepository.selectByBoardList();

		return list;
	}

	// 인기 게시글 조회
	@Transactional
	public List<Board> readPopularBoardList() {
		List<Board> boardList = boardRepository.selectByBoardList();

		// 인기 게시물의 평균값을 계산하기 위한 리스트
		List<Board> popularBoardList = new ArrayList<>();

		// 게시물의 수
		double totalItemCount = boardList.size();

		for (Board board : boardList) {
			double viewCount = board.getViewCount();
			double heartCount = board.getHeartCount();

			// 평균값 계산
			double average = (viewCount + heartCount) / totalItemCount;
			board.setAverage(average);

			popularBoardList.add(board);
		}

		// 평균값이 높은 순으로 정렬
		popularBoardList.sort(Comparator.comparingDouble(Board::getAverage).reversed());

		// 상위 4개의 인기 게시물만 반환
		if (popularBoardList.size() > 4) {
			return popularBoardList.subList(0, 4);
		} else {
			return popularBoardList;
		}
	}

	// 추천 여행지 게시글 작성
	@Transactional
	public void insertByBoard(BoardDto boardDto) {

		User user = (User) session.getAttribute(Define.PRINCIPAL);
		boardDto.setUserId(user.getId());

		int result = boardRepository.insertByBoard(boardDto);

		if (result != 1) {
			throw new CustomRestfullException("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
		}
	}

	// 추천 여행지 게시글 수정
	@Transactional
	public void updateByBoard(Integer id, BoardUpdateDto boardUpdateDto) {

		int result = boardRepository.updateByBoard(id, boardUpdateDto);
		if (result != 1) {
			throw new CustomRestfullException("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
		}
	}
	
	// 추천 여행지 게시글 수정
	@Transactional
	public void updateByBoardJustThumbnail(Integer id, BoardUpdateDto boardUpdateDto) {
		
		int result = boardRepository.updateByBoardJustThumbnail(id, boardUpdateDto);
		if (result != 1) {
			throw new CustomRestfullException("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
		}
	}

	// 추천 여행지 게시글 삭제
	@Transactional
	public void deleteByBoard(Integer id) {

		boardRepository.deleteHeartByBoard(id);
		int result = boardRepository.deleteByBoard(id);
		if (result != 1) {
			throw new CustomRestfullException("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
		}
	}

	// 추천 여행지 게시글 상세보기
	@Transactional
	public BoardDto readByBoardListDetail(Integer id) {

		BoardDto board = boardRepository.selectByBoardDetail(id);

		return board;
	}

	// 게시글 상세보기 시 조회수 증가
	@Transactional
	public boolean updateViewCountCookie(Integer id, HttpServletRequest request, HttpServletResponse response) {

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
	@Transactional
	public BoardDto selectLoveHeart(Integer id) {

		BoardDto board = boardRepository.selectByBoardDetail(id);

		// 1. userId, boardId 값 들고오기
		List<LoveHeart> likeUser = boardRepository.selectByLikeUser(id);

		// 2. userId가 boardId로 사이즈 구하기
		Integer heartCount = likeUser.size();

		board.setHeartCount(heartCount);

		return board;
	}

	// 좋아요 추가, 삭제
	@Transactional
	public boolean updateHeartInDecrease(Integer id) {

		boolean registration = false;

		// 현재 로그인 되어있는 유저 아이디 정보
		User user = (User) session.getAttribute(Define.PRINCIPAL);

		// 현재 로그인 되어있는 유저 id
		String userId = user.getId();

		// 게시물 찜 목록에 현재 로그인 되어있는 id가 있는지 확인
		List<LoveHeart> list = boardRepository.selectByBoardIdAndLikeUser(id, userId);

		// 찜을 누른 유저인지 판별
		if (list.isEmpty() || list == null) {
			boardRepository.insertByHeart(id, userId);
			registration = true;
		} else {
			boardRepository.deleteByHeart(id, userId);
			registration = false;
		}

		return registration;
	}

	// 페이징용
	public List<Board> readBoardListLimit(Integer index, Integer limitCount) {
		return boardRepository.selectBoardListLimit(index, limitCount);
	}

	@Transactional
	public BoardDto readBoardCountByMemberId(String memberId) {
		BoardDto boardDto = boardRepository.selectBoardCountByMemberId(memberId);
		return boardDto;
	}

}