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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.response.ResponseDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.VocInfoDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.repository.model.Voc;
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
		
		return "redirect:/voc/list/member";
	}
	
	/**
	 * @return 해당 사용자가 작성한 글 목록
	 */
	@GetMapping("/list/member")
	public String vocListForMemberPage(Model model) {
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		List<VocInfoDto> vocList = vocService.readVocListByMemberId(userId);
		model.addAttribute("vocList", vocList);
		
		return "/voc/listForMember";
	}
	
	/**
	 * @return 관리자가 확인하는 글 목록
	 */
	@GetMapping("/list/manager")
	public String vocListForManagerPage() {
		
		return "/voc/listForManager";
	}
	
	@GetMapping("/detail/{id}")
	public String vocDetailPage(Model model, @PathVariable Integer id) {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		Member member = userService.readById(userId);
		model.addAttribute("member", member);
		
		VocInfoDto voc = vocService.readVocById(id);
		model.addAttribute("voc", voc);
		
		return "/voc/detail";
	}
	
	@DeleteMapping("/delete/{id}")
	@ResponseBody
	public ResponseDto<Integer> vocDeleteProc(@PathVariable Integer id) {
		
		ResponseDto<Integer> response = null;
		
		// 해당 게시글이 존재하는지 확인 + 삭제
		Integer data = vocService.deleteById(id);
		
		if (data == 1) {
			response = new ResponseDto<Integer>(HttpStatus.OK.value(), "1", "삭제 성공", "success", data);
		} else {
			response = new ResponseDto<Integer>(HttpStatus.OK.value(), "0", "삭제 실패", "fail", data);
		}
		
		return response;
	}
	
}
