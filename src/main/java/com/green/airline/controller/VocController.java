package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.response.ResponseDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.VocInfoDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.repository.model.Voc;
import com.green.airline.repository.model.VocAnswer;
import com.green.airline.repository.model.VocAnswerForm;
import com.green.airline.repository.model.VocCategory;
import com.green.airline.service.TicketService;
import com.green.airline.service.UserService;
import com.green.airline.service.VocService;
import com.green.airline.utils.Define;
import com.green.airline.utils.PhoneNumberUtil;

/**
 * @author 서영
 * 고객의 말씀(VoC)
 */
@Controller
@RequestMapping("/voc")
public class VocController {
	
	@Autowired
	private HttpSession session;

	@Autowired
	private UserService userService;
	
	@Autowired
	private VocService vocService;
	
	@Autowired
	private TicketService ticketService;
	
	/**
	 * @return 문의 게시글 작성 페이지
	 */
	@GetMapping("/write")
	public String vocWritePage(Model model) {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		Member member = userService.readById(userId);
		model.addAttribute("member", member);
		
		List<VocCategory> categoryList = vocService.readCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		List<TicketAllInfoDto> ticketList = ticketService.readTicketListByMemberId(userId);
		model.addAttribute("ticketList", ticketList);
		
		return "/voc/writeVoc";
	}
	
	/**
	 * 문의 게시글 작성 처리
	 */
	@PostMapping("/write")
	public String vocWriteProc(@Valid Voc voc, BindingResult bindingResult) {
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		voc.setMemberId(userId);
		
		// 예약번호를 선택하지 않았다면
		if ("".equals(voc.getTicketId())) {
			voc.setTicketId(null);
		}
		
		if (voc.getCategoryId() == -1) {
			throw new CustomRestfullException("분야가 선택되지 않았습니다.", HttpStatus.BAD_REQUEST);
		} 
		
		// 빈 값이 있는지 확인
		if (bindingResult.hasErrors()) {
			throw new CustomRestfullException("입력되지 않은 필수 항목이 존재합니다.", HttpStatus.BAD_REQUEST);
		}
		
		// 타이틀 양옆 공백 제거
		voc.setTitle(voc.getTitle().trim());
		
		// 전화번호 형식 확인
		String phoneNumber = PhoneNumberUtil.checkPhoneNumber(voc.getPhoneNumber());
		voc.setPhoneNumber(phoneNumber);
		
		vocService.createVoc(voc);
		
		return "redirect:/voc/list/1";
	}
	
	/**
	 * @return 해당 사용자가 작성한 글 목록
	 */
	@GetMapping("/list/{page}")
	public String vocListForMemberPage(Model model, @PathVariable Integer page) {
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		// 전체 글 목록
		List<VocInfoDto> allVocList = vocService.readVocListByMemberId(userId);
		// 총 페이지 수
		int pageCount = (int) Math.ceil(allVocList.size() / 10.0);
		model.addAttribute("pageCount", pageCount);
		
		// 표시할 글 목록
		Integer index = (page - 1) * 10;
		List<VocInfoDto> vocList = vocService.readVocListByMemberIdLimit(userId, index);
		
		model.addAttribute("vocList", vocList);
		
		return "/voc/listForMember";
	}
	
	/**
	 * @return 관리자가 확인하는 글 목록 (처리되지 않은 문의)
	 */
	@GetMapping("/list/not/{page}")
	public String notProcessedvocListPage(@PathVariable Integer page, Model model) {
		
		// 전체 글 목록
		List<VocInfoDto> allVocList = vocService.readVocList(0);
		// 총 페이지 수
		int pageCount = (int) Math.ceil(allVocList.size() / 10.0);
		model.addAttribute("pageCount", pageCount);
		
		// 표시할 글 목록
		Integer index = (page - 1) * 10;
		List<VocInfoDto> vocList = vocService.readVocListLimit(index, 0, 10);
		
		model.addAttribute("vocList", vocList);
		model.addAttribute("processed", 0);
		
		return "/voc/listForManager";
	}
	
	/**
	 * @return 관리자가 확인하는 글 목록 (처리된 문의)
	 */
	@GetMapping("/list/processed/{page}")
	public String processedvocListPage(@PathVariable Integer page, Model model) {
		
		// 전체 글 목록
		List<VocInfoDto> allVocList = vocService.readVocList(1);
		// 총 페이지 수
		int pageCount = (int) Math.ceil(allVocList.size() / 10.0);
		model.addAttribute("pageCount", pageCount);
		
		// 표시할 글 목록
		Integer index = (page - 1) * 10;
		List<VocInfoDto> vocList = vocService.readVocListLimit(index, 1, 10);
		
		model.addAttribute("vocList", vocList);
		model.addAttribute("processed", 1);
		
		return "/voc/listForManager";
	}
	
	/**
	 * 상세 페이지
	 */
	@GetMapping("/detail/{id}")
	public String vocDetailPage(Model model, @PathVariable Integer id) {
		
		VocInfoDto voc = vocService.readVocById(id);
		model.addAttribute("voc", voc);
		
		Member member = userService.readById(voc.getMemberId());
		model.addAttribute("member", member);
		
		List<VocAnswerForm> formList = vocService.readFormList();
		model.addAttribute("formList", formList);
		
		return "/voc/detail";
	}
	
	/**
	 * 게시글 삭제 처리
	 */
	@DeleteMapping("/delete/{id}")
	@ResponseBody
	public ResponseDto<Integer> vocDeleteProc(@PathVariable Integer id) {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		ResponseDto<Integer> response = null;
		
		// 해당 게시글이 존재하는지 확인 + 작성자가 일치하는지 확인 + 삭제
		Integer data = vocService.deleteById(id, userId);
		
		// 삭제가 성공했다면
		if (data == 1) {
			response = new ResponseDto<Integer>(HttpStatus.OK.value(), Define.CODE_SUCCESS, "삭제 성공", Define.RESULT_CODE_SUCCESS, data);
		// 삭제가 실패했다면
		} else {
			response = new ResponseDto<Integer>(HttpStatus.OK.value(), Define.CODE_FAIL, "삭제 실패", Define.RESULT_CODE_FAIL, data);
		}
		
		return response;
	}
	
	/**
	 * @return 게시글 수정 페이지
	 */
	@GetMapping("/update/{id}")
	public String vocUpdatePage(Model model, @PathVariable Integer id) {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		
		VocInfoDto voc = vocService.readVocById(id);
		model.addAttribute("voc", voc);
		
		Member member = userService.readById(voc.getMemberId());
		model.addAttribute("member", member);
		
		List<VocCategory> categoryList = vocService.readCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		List<TicketAllInfoDto> ticketList = ticketService.readTicketListByMemberId(userId);
		model.addAttribute("ticketList", ticketList);
		
		return "/voc/updateVoc";
	}
	
	/**
	 * 게시글 수정 처리
	 */
	@PostMapping("/update/{id}")
	public String vocUpdateProc(@PathVariable Integer id, @Valid Voc voc, BindingResult bindingResult) {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		voc.setMemberId(userId);
		voc.setId(id);
		
		// 예약번호를 선택하지 않았다면
		if ("".equals(voc.getTicketId())) {
			voc.setTicketId(null);
		}
		
		if (voc.getCategoryId() == -1) {
			throw new CustomRestfullException("분야가 선택되지 않았습니다.", HttpStatus.BAD_REQUEST);
		} 
		
		// 빈 값이 있는지 확인
		if (bindingResult.hasErrors()) {
			throw new CustomRestfullException("입력되지 않은 필수 항목이 존재합니다.", HttpStatus.BAD_REQUEST);
		}
		
		// 타이틀 양옆 공백 제거
		voc.setTitle(voc.getTitle().trim());
		
		// 전화번호 형식 확인
		String phoneNumber = PhoneNumberUtil.checkPhoneNumber(voc.getPhoneNumber());
		voc.setPhoneNumber(phoneNumber);
		
		// 해당 게시글이 존재하는지 확인 + 작성자가 일치하는지 확인 + 수정
		vocService.updateById(voc, userId);
		
		return "redirect:/voc/list/1";
	}
	
	/**
	 * @param 게시글 id
	 * 답변 처리
	 */
	@PostMapping("/answer/{id}")
	public String answerProc(@PathVariable Integer id, @Valid VocAnswer vocAnswer, BindingResult bindingResult) {
		
		// 내용이 입력되어 있는지 확인
		if (bindingResult.hasErrors()) {
			throw new CustomRestfullException("답변 내용이 입력되지 않았습니다.", HttpStatus.BAD_REQUEST);
		}
		vocAnswer.setVocId(id);
		vocService.createAnswer(vocAnswer);
		
		return "redirect:/voc/detail/" + id;
	}
	
}
