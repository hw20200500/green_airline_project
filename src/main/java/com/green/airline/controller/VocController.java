package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.repository.model.Voc;
import com.green.airline.repository.model.VocCategory;
import com.green.airline.service.TicketService;
import com.green.airline.service.UserService;
import com.green.airline.service.VocService;
import com.green.airline.utils.Define;

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
	public String vocWriteProc(Voc voc) {
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		voc.setMemberId(userId);
		vocService.createVoc(voc);
		
		return "redirect:/voc/list/userId";
	}
	
	/**
	 * @return 해당 사용자가 작성한 글 목록
	 */
	@GetMapping("/list/{id}")
	public String vocListByMemberIdPage(@PathVariable String id) {
		
		return "/voc/listForMember";
	}
	
}
