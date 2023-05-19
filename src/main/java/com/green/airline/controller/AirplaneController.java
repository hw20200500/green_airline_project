package com.green.airline.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 서영
 * 비행기 관련
 *
 */
@Controller
@RequestMapping("/airplane")
public class AirplaneController {

	@GetMapping("/{id}")
	public String airplaneSeatPage(Model model, @PathVariable Integer id) {
		model.addAttribute("id", id);
		return "/ticket/airplaneSeat";
	}
	
}
