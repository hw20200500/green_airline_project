package com.green.airline.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.green.airline.dto.response.PaymentResponseDto;
import com.green.airline.dto.response.TicketDto;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	private HttpSession session;

	/**
	 * @author 서영
	 * @return 카카오페이 결제 요청 페이지
	 */
	@PostMapping("/request")
	@ResponseBody
	public String kakaoPayPage(@RequestBody TicketDto ticketDto) {
		
		// 세션에 티켓 정보 저장
		// 더 좋은 방법 고민해보기..
		session.setAttribute("ticket", ticketDto);
		
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 3634279e46d43dee4be45365feaec12f");
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		// 주문번호
		params.add("partner_order_id", "partner_order_id");
		// 예약자 id 
		params.add("partner_user_id", "partner_user_id");
		// 상품명
		// 배열로 보내서 toString하면 여러 종류 상품 가능
		params.add("item_name", "항공권 결제");
		// 수량
		params.add("quantity", ticketDto.getQuantity() + "");
		// 총액
		params.add("total_amount", ticketDto.getTotalAmount());
		// 비과세 금액
		params.add("tax_free_amount", "0");
		// 성공 시 url
		params.add("approval_url", "http://localhost/payment/success");
		// 취소 시 url
		params.add("cancel_url", "http://localhost/payment/cancel");
		// 실패 시 url
		params.add("fail_url", "http://localhost/fail");
		
		HttpEntity<MultiValueMap<String, String>> reqEntity = new HttpEntity<>(params, headers);
		
		ResponseEntity<PaymentResponseDto> responseDto 
			= restTemplate.exchange("https://kapi.kakao.com/v1/payment/ready", HttpMethod.POST,
									reqEntity, PaymentResponseDto.class);
		
		return responseDto.getBody().getNextRedirectPcUrl().toString();
	}

	/**
	 * 결제 완료 시 티켓 예매 처리
	 * @return 일단 메인페이지로
	 */
	@GetMapping("/success")
	public String reserveTicketProc(@RequestParam String pg_token) {
		TicketDto ticketDto = (TicketDto) session.getAttribute("ticket");
		System.out.println(ticketDto);
		System.out.println("ㅎㅇ");
		
		return "redirect:/";
	}
	
	/**
	 * 결제 취소 시
	 * @return
	 */
	@GetMapping("/cancel")
	public String cancelPage() {
		
		return "redirect:/";
	}
	
	/**
	 * 결제 실패 시
	 * @return
	 */
	@GetMapping("/fail")
	public String failPage() {
		
		return "redirect:/";
	}
	
}
