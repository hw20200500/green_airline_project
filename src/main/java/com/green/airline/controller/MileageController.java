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
	
	@GetMapping("/selectAll")
	public String mileageAll(String memberId,Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		memberId = principal.getId();
		SaveMileageDto saveMileage = mileageService.readSaveMileage(memberId);
		UseMileageDto useMileage = mileageService.readUseMileage(memberId);
		
		System.out.println("memberId : " + memberId);
		 model.addAttribute("saveMileage",saveMileage);
		 model.addAttribute("useMileage",useMileage);
		 System.out.println("saveMileage : " + saveMileage);
			System.out.println("useMileage : " + useMileage);
		return "/myPage/mileage";
	}
}
