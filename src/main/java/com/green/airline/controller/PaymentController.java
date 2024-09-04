package com.green.airline.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
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

import com.green.airline.dto.SaveMileageDto;
import com.green.airline.dto.kakao.PayApproveDto;
import com.green.airline.dto.kakao.PaymentResponseDto;
import com.green.airline.dto.kakao.RefundResponseDto;
import com.green.airline.dto.request.RefundDto;
import com.green.airline.dto.response.MemberInfoDto;
import com.green.airline.dto.response.ResponseDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.TicketDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.service.CoolSmsService;
import com.green.airline.service.MileageService;
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

	@Autowired
	private MileageService mileageService;

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
		params.add("item_name", "항공권 예매");
		// 수량
		params.add("quantity", ticketDto.getQuantity() + "");
		// 총액
		params.add("total_amount", ticketDto.getTotalAmount() + "");
		// 비과세 금액
		params.add("tax_free_amount", "0");
		// 성공 시 url
		params.add("approval_url", "http://" + Define.IP_ADDRESS + "/payment/success"); // ip 고치기
		// 취소 시 url
		params.add("cancel_url", "http://" + Define.IP_ADDRESS + "/payment/cancel");
		// 실패 시 url
		params.add("fail_url", "http://" + Define.IP_ADDRESS + "/payment/fail");

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
			ticketService.createTicketAndPayment(ticketDto, userId, 0);

		} catch (Exception e) {
			// 뒤로가기 했다가 다시 결제 요청을 할 경우를 대비해서 삭제했다가 다시 추가
			ticketService.deleteTicketByPaymentCancel(userId);
			ticketService.createTicketAndPayment(ticketDto, userId, 0);
		}

		return responseDto.getBody().getNextRedirectPcUrl().toString();
	}

	/**
	 * @author 서영
	 * 결제 완료 시 티켓 예약 처리
	 * @return 결제 완료 페이지
	 */
	@GetMapping("/success")
	public String reserveTicketPage(@RequestParam String pg_token, Model model) {
		System.out.println("로그인 여부" + (User) session.getAttribute(Define.PRINCIPAL));

		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		MemberInfoDto member = userService.readMemberById(userId);

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
	 * @author 서영
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
	 * @author 서영
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
	 * @author 서영
	 * 환불 요청
	 */
	@PostMapping("/refund")
	public String refundProc(RefundDto refundDto) {

		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();

		// 취소 금액 여기서 계산
		// 전체 결제 금액
		Long paymentAmount = refundDto.getPaymentAmount();

		// 환불 수수료 구하기
		// 국내선/국제선 여부
		Integer scheduleType = refundDto.getScheduleType();

		// 티켓 출발일 - 현재 날짜 차이
		Integer dayCount = refundDto.getDayCount();

		Integer adultCount = refundDto.getAdultCount();
		Integer childCount = refundDto.getChildCount();

		// 카카오페이라면
		if (refundDto.getTid().substring(0, 1).equals("T")) {

			RestTemplate restTemplate = new RestTemplate();

			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", "KakaoAK " + KAKAO_API_KEY);
			headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

			// 성인 1인 기준 환불 수수료
			Long fee = refundService.readRefundFee(scheduleType, dayCount);
			Long totalFee = (fee * adultCount) + Math.round(fee * childCount * Define.CHILD_PRICE_RATE);

			// 최종 환불 금액
			Long refundAmount = paymentAmount - totalFee;

			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			params.add("cid", "TC0ONETIME");
			params.add("tid", refundDto.getTid());
			params.add("cancel_amount", refundAmount + "");
			params.add("cancel_tax_free_amount", "0");

			HttpEntity<MultiValueMap<String, String>> reqEntity = new HttpEntity<>(params, headers);

			ResponseEntity<RefundResponseDto> responseDto
					= restTemplate.exchange("https://kapi.kakao.com/v1/payment/cancel", HttpMethod.POST,
					reqEntity, RefundResponseDto.class);
			// 마일리지 결제라면
		} else {

			// 성인 1인 기준 환불 수수료
			Long fee = (long) Math.floor(refundService.readRefundFee(scheduleType, dayCount) * Define.MILES_TICKET_RATE);
			Long totalFee = (fee * adultCount) + Math.round(fee * childCount * Define.CHILD_PRICE_RATE);

			// 최종 환불 금액
			Long refundAmount = paymentAmount - totalFee;
			// 마일리지 환불 처리
			mileageService.updateUseMilesDataStatus(userId, totalFee, refundAmount, refundDto.getTicketId());

		}

		// 환불 관련 DB 처리
		ticketService.updateStatusRefund(refundDto.getTid(), refundDto.getTicketId(), refundDto.getTicketType());

		return "redirect:/ticket/detail/" + refundDto.getTicketId();
	}

	/**
	 * @author 서영
	 * 마일리지 결제
	 */
	@PostMapping("/miles")
	@ResponseBody
	public ResponseDto<String> milesPaymentProc(@RequestBody TicketDto ticketDto) {

		int statusCode = HttpStatus.OK.value();
		int code = Define.CODE_SUCCESS;
		String message = "결제가 성공했습니다.";
		String resultCode = Define.RESULT_CODE_SUCCESS;
		String data = "";

		String userId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		// 현재 마일리지
		Long currentMiles = (long) mileageService.readSaveMileage(userId).getBalance();

		Long milesPrice = ticketDto.getMilesPrice();
		// 결제할 마일리지
		if (ticketDto.getScheduleId2() != null) {
			milesPrice += ticketDto.getMilesPrice2();
		}

		// 현재 마일리지보다 결제할 마일리지가 높다면
		if (currentMiles < milesPrice) {
			statusCode = HttpStatus.BAD_REQUEST.value();
			code = Define.CODE_FAIL;
			message = "마일리지가 부족합니다.";
			resultCode = Define.RESULT_CODE_FAIL;

		} else {
			// 결제 처리 (티켓아이디 반환)
			try {
				data = ticketService.createTicketAndPayment(ticketDto, userId, 1);

			} catch (Exception e) {
				// 뒤로가기 했다가 다시 결제 요청을 할 경우를 대비해서 삭제했다가 다시 추가
				ticketService.deleteTicketByPaymentCancel(userId);
				data = ticketService.createTicketAndPayment(ticketDto, userId, 1);
			}

		}
		return new ResponseDto<String>(statusCode, code, message, resultCode, data);
	}

}