package com.green.airline.controller;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.repository.model.Mileage;
import com.green.airline.repository.model.User;
import com.green.airline.service.MileageService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/api")
public class MileageApiController {
	@Autowired
	private MileageService mileageService;
	
	@Autowired
	private HttpSession session;
	
	@GetMapping("/selectMileageListProc")
	@ResponseBody
	public List<Mileage> MileageList(@RequestParam String searchType, Date startTime, Date endTime ,Model model) {
		System.out.println(searchType);
		System.out.println(startTime);
		System.out.println(endTime);
		
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		String memberId = principal.getId();
		List<Mileage> savemileage = mileageService.readSaveMileageList(memberId,startTime,endTime); 
		System.out.println("savemileage : " + savemileage);
		System.out.println("asd");
		model.addAttribute("savemileage",savemileage);
		return savemileage;
	}
}
