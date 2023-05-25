package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.TicketDto;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.TicketPayment;
import com.green.airline.repository.model.User;
import com.green.airline.service.CoolSmsService;
import com.green.airline.service.TicketService;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private TicketService ticketService;
	
	@Autowired
	private CoolSmsService coolSmsService;
	
	@Autowired
	private UserService userService;
	

	/**
	 * @author 서영
	 * @return 카카오페이 결제 요청 페이지
	 */
	@PostMapping("/request")
	@ResponseBody
	public String kakaoPayPage(@RequestBody TicketDto ticketDto) {
		
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
		params.add("total_amount", ticketDto.getTotalAmount() + "");
		// 비과세 금액
		params.add("tax_free_amount", "0");
		// 성공 시 url
		params.add("approval_url", "http://localhost/payment/success");
		// 취소 시 url
		params.add("cancel_url", "http://localhost/payment/cancel");
		// 실패 시 url
		params.add("fail_url", "http://localhost/payment/fail");
		
		HttpEntity<MultiValueMap<String, String>> reqEntity = new HttpEntity<>(params, headers);
		
		ResponseEntity<PaymentResponseDto> responseDto 
			= restTemplate.exchange("https://kapi.kakao.com/v1/payment/ready", HttpMethod.POST,
									reqEntity, PaymentResponseDto.class);
		
		ticketDto.setTid(responseDto.getBody().getTid());
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		
		// 예약 처리 (결제 성공 시 그대로 남고, 결제 실패/취소 시 삭제)
		// 해당 유저의 가장 최근 예약 내역을 가져오면 예약 ID를 가져올 수 있음
		// 예약 ID를 가져와서 결제 내역도 삭제
		ticketService.createTicketAndPayment(ticketDto, userId);
		
		return responseDto.getBody().getNextRedirectPcUrl().toString();
	}

	/**
	 * 결제 완료 시 티켓 예약 처리
	 * @return 결제 완료 페이지
	 */
	@GetMapping("/success")
	public String reserveTicketPage(@RequestParam String pg_token, Model model) {

		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		// 결제 완료 처리 후 결제 정보 반환
		List<TicketAllInfoDto> ticketList = ticketService.updatePaymentStatusIsSuccess(userId);
		
		Member member = userService.readMemberById(userId);
		
		String tel = member.getPhoneNumber();
		String name = member.getKorName();
		
		// 예약 완료 메시지 발송 (문자 건 수 제한 때문에 지금은 주석)
		// coolSmsService.completeMessage(tel, name, ticketList.get(0).getId());
		
		model.addAttribute("ticketList", ticketList);
		
		return "/ticket/paymentSuccess";
	}
	
	/**
	 * 결제 취소 시
	 * @return 항공스케줄 선택 페이지
	 */
	@GetMapping("/cancel")
	public String cancelPage() {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		// 예약 내역 삭제
		ticketService.deleteTicketByPaymentCancel(userId);
		
		return "redirect:/ticket/selectSchedule";
	}
	
	/**
	 * 결제 실패 시
	 * @return 항공스케줄 선택 페이지
	 */
	@GetMapping("/fail")
	public String failPage() {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		// 예약 내역 삭제
		ticketService.deleteTicketByPaymentCancel(userId);
		
		return "redirect:/ticket/selectSchedule";
	}
	
}
