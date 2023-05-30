package com.green.airline.controller;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.green.airline.dto.response.MonthlySalesForChartDto;
import com.green.airline.service.TicketPaymentService;

@RequestMapping("/manager")
@Controller
public class ManagerController {
	
	@Autowired
	private TicketPaymentService ticketPaymentService;
	
	@GetMapping("/dashboard")
	public String dashboardPage(Model model) {
		
		// 최근 1년간 월간 매출액
		List<MonthlySalesForChartDto> salesList = ticketPaymentService.readMonthlySales();
		
		// JSON으로 변환
		Gson gson = new Gson();
		JsonArray jsonArray = new JsonArray();
		Iterator<MonthlySalesForChartDto> it = salesList.iterator();
		while (it.hasNext()) {
			MonthlySalesForChartDto dto = it.next();
			JsonObject object = new JsonObject();
			object.addProperty("period", dto.getYear() + "년 " + dto.getMonth() + "월");
			object.addProperty("sales", dto.getSales());
			jsonArray.add(object);
		}
		
		String salesData = gson.toJson(jsonArray);
		model.addAttribute("salesData", salesData);
		
		return "/manager/dashboard";
	}
	
	
}
