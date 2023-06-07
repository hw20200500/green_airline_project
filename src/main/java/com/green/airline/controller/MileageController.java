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
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.User;
import com.green.airline.service.MileageService;
import com.green.airline.service.TicketService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/mileage")
public class MileageController {

	@Autowired
	private MileageService mileageService;

	@Autowired
	private TicketService ticketService;
	@Autowired
	private HttpSession session;

	// 매핑 이름 바꿔야함 /list 로 바꿀것
	@GetMapping("/selectAll")
	public String mileageAll(String memberId, Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		memberId = principal.getId();
		SaveMileageDto saveMileage = mileageService.readSaveMileage(memberId);
		UseMileageDto useMileage = mileageService.readUseMileage(memberId);
		SaveMileageDto extinctionMileage = mileageService.readExtinctionMileage(memberId);
		List<Mileage> mileages = mileageService.readMileageTbOrderByMileageDateByMemberId(memberId);
		System.out.println("saveMileage" + saveMileage);
		System.out.println("useMileage"+useMileage);
		System.out.println("extinctionMileage"+extinctionMileage);
		model.addAttribute("saveMileage", saveMileage);
		model.addAttribute("useMileage", useMileage);
		model.addAttribute("extinctionMileage", extinctionMileage);
		model.addAttribute("mileages", mileages);
		return "/myPage/mileage";
	}

	/**
	 * 정다운 마일리지 신청 페이지
	 * 
	 * @param model
	 * @param id
	 * @return
	 */
	@GetMapping("/request/{id}")
	public String mileageRequestPage(Model model, @PathVariable String id) {
		TicketAllInfoDto allInfoDto = ticketService.readByTicketId(id);
		System.out.println("controller : " + allInfoDto);
		model.addAttribute("allInfoDto", allInfoDto);
		return "/myPage/mileageRequest";
	}

	/**
	 * 정다운 마일리지 신청/미신청 리스트
	 * 
	 * @param memberId
	 * @param type
	 * @param model
	 * @return
	 */
	@GetMapping("/application")
	public String applicationList(String memberId,
			@RequestParam(name = "type", defaultValue = "0", required = false) String type, Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		memberId = principal.getId();
		List<TicketAllInfoDto> ticketList = ticketService.readTicketListBymemberId(memberId, type);
		model.addAttribute("ticketList", ticketList);
		return "/myPage/mileageApplication";
	}

	@PostMapping("/insert")
	public String updateStatus(TicketAllInfoDto ticketAllInfoDto) {
		ticketService.insertStatus(ticketAllInfoDto);
		return "redirect:/mileage/application";
	}

}
