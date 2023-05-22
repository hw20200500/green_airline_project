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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.green.airline.dto.request.PaymentDto;
import com.green.airline.dto.response.PaymentResponseDto;
import com.green.airline.repository.model.User;
import com.green.airline.utils.Define;

@Controller
public class AuthController {
	
	@Autowired
	private HttpSession session;

	
	@GetMapping("/auth/kakao/callback")
	@ResponseBody
	public String kakaoCallbackCode(@RequestBody PaymentDto paymentDto) {
		
		String id = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		
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
		params.add("item_name", "항공권");
		// 수량
		params.add("quantity", paymentDto.getQuantity());
		// 총액
		params.add("total_amount", paymentDto.getTotalAmount());
		// 비과세 금액
		params.add("tax_free_amount", "0");
		// 성공 시 url
		params.add("approval_url", "http://localhost");
		// 취소 시 url
		params.add("cancel_url", "http://localhost");
		// 실패 시 url
		params.add("fail_url", "http://localhost");
		
		HttpEntity<MultiValueMap<String, String>> reqEntity = new HttpEntity<>(params, headers);
		
		ResponseEntity<PaymentResponseDto> responseDto 
			= restTemplate.exchange("http://kapi.kakao.com/v1/payment/ready", HttpMethod.POST,
									reqEntity, PaymentResponseDto.class);
		
		
		
		return "";
	}
	
}
