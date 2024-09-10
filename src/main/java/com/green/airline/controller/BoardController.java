package com.green.airline.controller;
import javax.servlet.ServletContext;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.green.airline.dto.BoardDto;
import com.green.airline.dto.BoardUpdateDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.interfaces.BoardRepository;
import com.green.airline.repository.model.Board;
import com.green.airline.repository.model.LoveHeart;
import com.green.airline.repository.model.User;
import com.green.airline.service.BoardService;
import com.green.airline.utils.Define;

/**
 * @author 치승 추천 여행지 게시글
 */

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
    private ServletContext context;
	@Autowired
	private BoardService boardService;

	@Autowired
	private HttpSession session;

	@Autowired
	private BoardRepository boardRepository;

	// 게시글 전체 보기
	@GetMapping("/list/{page}")
	public String boardListAllPage(Model model, @PathVariable Integer page) {

		// 일반 게시물 (전체)
		List<Board> allBoardList = boardService.readByBoardList();

		// 페이지 개수
		Integer pageCount = (int) Math.ceil(allBoardList.size() / 9.0);
		model.addAttribute("pageCount", pageCount);

		// 현재 페이지에 따라 인덱스 계산
		Integer index = (page - 1) * 9;

		// 보여줄 게시글 (페이징)
		List<Board> boardList = boardService.readBoardListLimit(index, 9);

		// 추천 게시물
		List<Board> popularBoard = boardService.readPopularBoardList();

		if (boardList.isEmpty()) {
			model.addAttribute("boardList", null);
			model.addAttribute("popularBoard", null);
		} else {
			model.addAttribute("boardList", boardList);
			model.addAttribute("popularBoard", popularBoard);
		}

		return "/board/recommendBoard";
	}

	// 게시글 작성하기
	@GetMapping("/insert")
	public String boardWritePage() {

		return "/board/boardWrite";
	}

	// 게시글 작성하기
	@PostMapping("/insert")
	public String boardWirtePage(BoardDto boardDto) {

		if (boardDto.getTitle() == null || boardDto.getTitle().isEmpty()) {
			throw new CustomRestfullException("제목을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}
		if (boardDto.getContent() == null || boardDto.getContent().isEmpty()) {
			throw new CustomRestfullException("내용을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}

		MultipartFile file = boardDto.getFile();

		if (!file.isEmpty()) {
			// 파일 사이즈 체크
			if (file.getSize() > Define.MAX_FILE_SIZE) {
				throw new CustomRestfullException("파일 크기는 20MB이상 줄 수 없습니다.", HttpStatus.BAD_REQUEST);
			}

			try {
				// 파일 저장 기능
				String saveDirectory = context.getRealPath(Define.UPLOAD_DIRECTORY);

				File dir = new File(saveDirectory);

				// 파일이 있는지 없는지 확인
				if (dir.exists() == false) {
					// 폴더가 없으면 폴더 생성
					dir.mkdirs();
				}

				UUID uuid = UUID.randomUUID();
				String fileName = uuid + "_" + file.getOriginalFilename();

				// 전체 경로 지정
				String uploadPath = context.getRealPath(Define.UPLOAD_DIRECTORY) + File.separator + fileName;

				File destination = new File(uploadPath);

				file.transferTo(destination);
				System.out.println("upload file:"+file);
				System.out.println("file destination:"+destination);

				boardDto.setOriginName(file.getOriginalFilename());
				boardDto.setFileName("/uploadImage/" + fileName);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		boardService.insertByBoard(boardDto);

		return "redirect:/board/list/1";
	}

	// 게시글 수정하기
	@GetMapping("/update/{id}")
	public String updateByBoardPage(@PathVariable Integer id, Model model) {

		BoardDto boardDto = boardService.readByBoardListDetail(id);
		model.addAttribute("boardDto", boardDto);

		return "/board/updateBoard";
	}

	// 게시글 수정하기
	@PostMapping("/update/{id}")
	public String updateByBoardPage(@PathVariable("id") Integer id, BoardUpdateDto boardUpdateDto) {

		if (boardUpdateDto.getTitle() == null || boardUpdateDto.getTitle().isEmpty()) {
			throw new CustomRestfullException("제목을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}
		if (boardUpdateDto.getContent() == null || boardUpdateDto.getContent().isEmpty()) {
			throw new CustomRestfullException("내용을 입력해주세요.", HttpStatus.BAD_REQUEST);
		}

		MultipartFile file = boardUpdateDto.getFile();

		if (!file.isEmpty()) {
			// 파일 사이즈 체크
			if (file.getSize() > Define.MAX_FILE_SIZE) {
				throw new CustomRestfullException("파일 크기는 20MB이상 줄 수 없습니다.", HttpStatus.BAD_REQUEST);
			}

			try {
				// 파일 저장 기능
				String saveDirectory = context.getRealPath(Define.UPLOAD_DIRECTORY);

				File dir = new File(saveDirectory);

				// 파일이 있는지 없는지 확인
				if (dir.exists() == false) {
					// 폴더가 없으면 폴더 생성
					dir.mkdirs();
				}

				UUID uuid = UUID.randomUUID();
				String fileName = uuid + "_" + file.getOriginalFilename();

				// 전체 경로 지정
				String uploadPath = context.getRealPath(Define.UPLOAD_DIRECTORY) + File.separator + fileName;

				File destination = new File(uploadPath);

				file.transferTo(destination);

				boardUpdateDto.setOriginName(file.getOriginalFilename());
				if (file.getOriginalFilename() == null) {
					boardService.updateByBoardJustThumbnail(id, boardUpdateDto);
				} else {
					boardUpdateDto.setFileName("/uploadImage/" + fileName);
					boardService.updateByBoard(id, boardUpdateDto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "redirect:/board/list/1";
	}

	// 게시글 삭제하기
	@GetMapping("/delete/{id}")
	public String deleteByBoardPage(@PathVariable("id") Integer id) {

		boardService.deleteByBoard(id);

		return "redirect:/board/list/1";
	}

	// 추천여행지 상세 보기
	@ResponseBody
	@GetMapping("/detail/{id}")
	public BoardDto boardDetailProc(@PathVariable Integer id, HttpServletRequest request,
			HttpServletResponse response) {

		// 좋아요 수 조회
		BoardDto loveHeart = boardService.selectLoveHeart(id);
		System.out.println("@@@@@@@@@@@@@@@@@@@");
		System.out.println("fileName : " + loveHeart.getFileName());
		System.out.println("@@@@@@@@@@@@@@@@@@@");
		// 쿠키 추가, 조회수 증가
		boolean viewUp = boardService.updateViewCountCookie(id, request, response);

		// 모달창 띄웠을 때 조회수 증가한 화면 보여주기
		if (viewUp) {
			loveHeart.setViewCount(loveHeart.getViewCount() + 1);
		}

		// 게시물 찜 목록에 현재 로그인 되어있는 id가 있는지 확인
		User user = (User) session.getAttribute(Define.PRINCIPAL);
		if (user != null) {
			List<LoveHeart> list = boardRepository.selectByBoardIdAndLikeUser(id, user.getId());
			// 찜을 누른 유저인지 판별
			if (list.isEmpty() || list == null) {
				loveHeart.setStatement(false);
			} else {
				loveHeart.setStatement(true);
			}
		}

		return loveHeart;
	}


	// 좋아요 버튼 클릭
	@ResponseBody
	@PostMapping("/detail/{id}")
	public Integer loveHeartButtonProc(@PathVariable Integer id, HttpServletRequest request) {

		boardService.updateHeartInDecrease(id); // true, false 반환

		// 좋아요 수 다시 세팅
		Integer heartCount = boardService.selectLoveHeart(id).getHeartCount();

		return heartCount;
	}
	/*@ResponseBody
	@GetMapping("/download/{boardId}")
	public String fileDownload(@PathVariable Integer boardId) {

		BoardDto boardDto = boardRepository.selectByBoardDetail(boardId);
		return Define.UPLOAD_DIRECTORY + boardDto.getFileName().substring(12);

	}*/
	@GetMapping("/download")
	public ResponseEntity<FileSystemResource> fileDownload(@RequestParam("fileName") String fileName)
			throws UnsupportedEncodingException {
		fileName=fileName.replace("/uploadImage", "/images/upload");
		String filePath = context.getRealPath(fileName);
		System.out.println("filePath::"+filePath);
		FileSystemResource file = new FileSystemResource(filePath);

		HttpHeaders headers = new HttpHeaders();
		String encodedFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); // 파일에 한글있으면 확장자 깨지던 것 해결
		headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"");
		headers.add(HttpHeaders.CONTENT_TYPE, "application/octet-stream");

		return new ResponseEntity<>(new FileSystemResource(filePath), headers, HttpStatus.OK);
	}
}
