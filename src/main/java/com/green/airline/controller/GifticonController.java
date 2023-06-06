package com.green.airline.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.repository.model.User;
import com.green.airline.service.GifticonService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/gifticon")
public class GifticonController {

	@Autowired
	private HttpSession session;
	@Autowired
	private GifticonService gifticonService;
	
	@GetMapping("/list")
	public String gifticonList() {
		
		return "/myPage/gifticonListPage";
		
	}
	
	@PostMapping("/deleteGifticonById")
	public String deleteGifticon(@RequestParam("gifticonId") String[] gifticonId,@RequestParam("productId") String[] productId,@RequestParam("amount") String[] amount,
			@RequestParam("name") String[] name,@RequestParam("brand") String[] brand, String memberId) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		memberId = principal.getId();
		for (int i = 0; i < gifticonId.length; i++) {
			gifticonService.createRevokeGifticon(gifticonId[i]);
			gifticonService.updateMileageAndGifticonStatus(memberId, gifticonId[i]);
		}
		
		
		return "redirect:/gifticon/list";
		
	}
}
