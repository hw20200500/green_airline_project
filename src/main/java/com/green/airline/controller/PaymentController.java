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

import com.green.airline.dto.kakao.PayApproveDto;
import com.green.airline.dto.kakao.PaymentResponseDto;
import com.green.airline.dto.kakao.RefundResponseDto;
import com.green.airline.dto.request.RefundDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.TicketDto;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.service.CoolSmsService;
import com.green.airline.service.RefundService;
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
	
	@Autowired
	private RefundService refundService;
	
	private final String KAKAO_API_KEY = "3634279e46d43dee4be45365feaec12f";
	

	/**
	 * @author 서영
	 * @return 카카오페이 결제 요청 페이지
	 */
	@PostMapping("/request")
	@ResponseBody
	public String kakaoPayPage(@RequestBody TicketDto ticketDto) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + KAKAO_API_KEY);
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
		try {
			ticketService.createTicketAndPayment(ticketDto, userId);
			
		} catch (Exception e) {
			System.out.println("이미 같은 결제 요청을 한 번 해서 데이터를 추가하지 않음");
		}
		
		return responseDto.getBody().getNextRedirectPcUrl().toString();
	}

	/**
	 * 결제 완료 시 티켓 예약 처리
	 * @return 결제 완료 페이지
	 */
	@GetMapping("/success")
	public String reserveTicketPage(@RequestParam String pg_token, Model model) {
		
		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		Member member = userService.readMemberById(userId);
		
		String tel = member.getPhoneNumber();
		String name = member.getKorName();
		
		// 결제 완료 처리 후 결제 정보 반환
		List<TicketAllInfoDto> ticketList = ticketService.updatePaymentStatusIsSuccess(userId);

		// 결제 승인 처리하기
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + KAKAO_API_KEY);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("tid", ticketList.get(0).getTid());
		params.add("partner_order_id", "partner_order_id");
		params.add("partner_user_id", "partner_user_id");
		params.add("pg_token", pg_token);
		
		HttpEntity<MultiValueMap<String, String>> reqEntity = new HttpEntity<>(params, headers);
		
		ResponseEntity<PayApproveDto> responseDto
			= restTemplate.exchange("https://kapi.kakao.com/v1/payment/approve", HttpMethod.POST,
									reqEntity, PayApproveDto.class);
		
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
	
	/**
	 * 환불 요청
	 */
	@PostMapping("/refund")
	public String refundProc(RefundDto refundDto) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + KAKAO_API_KEY);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// 취소 금액 여기서 계산
		// 전체 결제 금액
		Long paymentAmount = refundDto.getPaymentAmount();
		
		// 환불 수수료 구하기
		// 국내선/국제선 여부
		Integer scheduleType = refundDto.getScheduleType();
		// 티켓 출발일 - 현재 날짜 차이
		Integer dayCount = refundDto.getDayCount();
		System.out.println("날짜 차이 : " + dayCount);
		
		// 성인 1인 기준 환불 수수료
		Long fee = refundService.readRefundFee(scheduleType, dayCount);
		System.out.println("인당 수수료 : " + fee);
		
		Integer adultCount = refundDto.getAdultCount();
		Integer childCount = refundDto.getChildCount();
		
		Long totalFee = (fee * adultCount) + Math.round(fee * childCount * Define.CHILD_PRICE_RATE);	
		System.out.println("최종 수수료 : " + totalFee);
		
		// 최종 환불 금액
		Long refundAmount = paymentAmount - totalFee;
		System.out.println("최종 환불 금액 : " + refundAmount);
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("tid", refundDto.getTid());
		params.add("cancel_amount", refundAmount + "");
		params.add("cancel_tax_free_amount", "0");
		
		HttpEntity<MultiValueMap<String, String>> reqEntity = new HttpEntity<>(params, headers);
		
		ResponseEntity<RefundResponseDto> responseDto
			= restTemplate.exchange("https://kapi.kakao.com/v1/payment/cancel", HttpMethod.POST,
									reqEntity, RefundResponseDto.class);
		
		// DB 결제 내역에 status 처리
		ticketService.updateStatusRefund(refundDto.getTid(), refundDto.getTicketType());
		
		return "redirect:/ticket/list";
	}
	
	
}
