package com.green.airline.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.airline.service.GifticonService;

@Controller
@RequestMapping("/gifticon")
public class GifticonCtroller {

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
			@RequestParam("name") String[] name,@RequestParam("brand") String[] brand) {
		gifticonService.deleteGifticonBygifticonId(gifticonId);
		gifticonService.createRevokeGifticon(amount, brand, name);
		return "redirect:/gifticon/list";
		
	}
}
