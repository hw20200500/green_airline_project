package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.dto.GifticonDto;
import com.green.airline.repository.model.User;
import com.green.airline.service.GifticonService;
import com.green.airline.utils.Define;

@RestController
public class GifticonApiController {

	@Autowired
	private HttpSession session;
	@Autowired
	private GifticonService gifticonService;

	@GetMapping("/api/gifticonList")
	public List<GifticonDto> gifticonList( Model model,@RequestParam String startTime,@RequestParam String endTime,@RequestParam String radio) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		String memberId = principal.getId();
		List<GifticonDto> gifticonDtos = gifticonService.readGifticonListById(memberId,startTime,endTime,radio);
		model.addAttribute("gifticonDtos",gifticonDtos);
		return gifticonDtos;
	}
	@GetMapping("/api/managerGifticonList")
	public List<GifticonDto> managerGifticonList( Model model,@RequestParam String startTime,@RequestParam String endTime,@RequestParam String radio,@RequestParam String memberId) {
		
		List<GifticonDto> gifticonDtos = gifticonService.readGifticonListByIdForManager(memberId,startTime,endTime,radio);
		return gifticonDtos;
	}
}
