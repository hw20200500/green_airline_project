package com.green.airline.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.green.airline.dto.response.MonthlySalesForChartDto;
import com.green.airline.repository.model.Memo;
import com.green.airline.repository.model.User;
import com.green.airline.service.MemoService;
import com.green.airline.service.TicketPaymentService;
import com.green.airline.utils.Define;

@RequestMapping("/manager")
@Controller
public class ManagerController {
	
	@Autowired
	private TicketPaymentService ticketPaymentService;
	
	@Autowired
	private MemoService memoService;
	
	@Autowired
	private HttpSession session;
	
	/**
	 * @return 대시보드 (관리자 페이지의 메인)
	 */
	@GetMapping("/dashboard")
	public String dashboardPage(Model model) {
		
		String managerId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		
		// 최근 1년간 월간 매출액
		List<MonthlySalesForChartDto> salesList = ticketPaymentService.readMonthlySales();
		
		// JSON으로 변환
		Gson gson = new Gson();
		JsonArray jsonArray = new JsonArray();
		Iterator<MonthlySalesForChartDto> it = salesList.iterator();
		while (it.hasNext()) {
			MonthlySalesForChartDto dto = it.next();
			JsonObject object = new JsonObject();
			object.addProperty("period", dto.getYear() + "-" + dto.getMonth());
			object.addProperty("sales", dto.getSales());
			jsonArray.add(object);
		}
		
		String salesData = gson.toJson(jsonArray);
		model.addAttribute("salesData", salesData);
		
		int isMain = 1;
		model.addAttribute("isMain", isMain);
		
		// 메모 불러오기
		Memo memo = memoService.readByManagerId(managerId);
		model.addAttribute("memo", memo);
		
		return "/manager/dashboard";
	}
	
	/**
	 * 메모 갱신
	 */
	@PostMapping("/updateMemo")
	@ResponseBody
	public void updateMemoProc(@RequestBody Memo memo) {
		
		String managerId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		memo.setManagerId(managerId);
		memoService.updateMemo(memo);
	}
	
}
