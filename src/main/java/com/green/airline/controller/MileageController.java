package com.green.airline.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.UseMileageDto;
import com.green.airline.repository.model.User;
import com.green.airline.service.MileageService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/mileage")
public class MileageController {

	@Autowired
	private MileageService mileageService;
	
	@Autowired
	private HttpSession session;
	
	// 매핑 이름 바꿔야함 /list 로 바꿀것
	@GetMapping("/selectAll")
	public String mileageAll(String memberId,Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		memberId = principal.getId();
		SaveMileageDto saveMileage = mileageService.readSaveMileage(memberId);
		UseMileageDto useMileage = mileageService.readUseMileage(memberId);
		SaveMileageDto extinctionMileage = mileageService.readExtinctionMileage(memberId);
		
		 model.addAttribute("saveMileage",saveMileage);
		 model.addAttribute("useMileage",useMileage);
		 model.addAttribute("extinctionMileage",extinctionMileage);
		return "/myPage/mileage";
	}
	
	@GetMapping("/request")
	public String mileageRequestPage() {
		
		return "/myPage/mileageRequest";
	}
	@GetMapping("/application")
	public String applicationList() {
		
		return "/myPage/mileageApplication";
	}
}
