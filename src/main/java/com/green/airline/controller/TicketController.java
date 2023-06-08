package com.green.airline.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.request.ScheduleDateCheckDto;
import com.green.airline.dto.request.ScheduleOptionForMainPageDto;
import com.green.airline.dto.request.ScheduleSelectDto;
import com.green.airline.dto.request.TicketOptionDto;
import com.green.airline.dto.response.MemberInfoDto;
import com.green.airline.dto.response.ResponseDto;
import com.green.airline.dto.response.ScheduleInfoResponseDto;
import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.dto.response.SeatPriceDto;
import com.green.airline.dto.response.SeatStatusResponseDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.TicketDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.Passenger;
import com.green.airline.repository.model.RefundFee;
import com.green.airline.repository.model.ReservedSeat;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.PassengerService;
import com.green.airline.service.RefundService;
import com.green.airline.service.ReservedSeatService;
import com.green.airline.service.ScheduleService;
import com.green.airline.service.SeatService;
import com.green.airline.service.TicketService;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;
import com.green.airline.utils.TicketUtil;

/**
 * @author 서영
 * 티켓 예매 관련 컨트롤러
 */
@Controller
@RequestMapping("/ticket")
public class TicketController {

	@Autowired
	private SeatService seatService;
	
	@Autowired
	private AirportService airportService;
	
	@Autowired
	private ScheduleService scheduleService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private TicketService ticketService;
	
	@Autowired
	private PassengerService passengerService;
	
	@Autowired
	private ReservedSeatService reservedSeatService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RefundService refundService;
	
	
	/**
	 * @return 항공권 옵션 선택 페이지
	 */
	@GetMapping("/selectSchedule")
	public String selectTicketOptionPage(Model model) {
		
		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);
		
		if (session.getAttribute(Define.PRINCIPAL) != null) {
			String memberId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
			MemberInfoDto member = userService.readMemberById(memberId);
			model.addAttribute("memberBirthDate", member.getBirthDate());		
		}
		
		return "/ticket/selectSchedule";
	}
	
	/**
	 * @return 항공권 옵션 선택 페이지
	 */
	@GetMapping("/selectSchedule/search")
	public String selectTicketOptionPageFromMain(Model model, ScheduleOptionForMainPageDto optionDto) {
		
		model.addAttribute("option", optionDto);
		
		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);
		if (session.getAttribute(Define.PRINCIPAL) != null) {
			String memberId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
			MemberInfoDto member = userService.readMemberById(memberId);
			model.addAttribute("memberBirthDate", member.getBirthDate());		
		}
		return "/ticket/selectSchedule";
	}

	/**
	 * @return 선택한 옵션에 따른 운항스케줄 리스트 반환
	 */
	@PostMapping("/flightSchedule/{type}")
	@ResponseBody
	public List<ScheduleInfoResponseDto> selectScheduleListData(@RequestBody ScheduleSelectDto scheduleSelectDto, @PathVariable Integer type) {
		
		List<ScheduleInfoResponseDto> responseList = new ArrayList<>();
		
		// 왕복
		if (type == 1) {
			// 첫 번째 여정에 해당하는 스케줄 리스트
			List<ScheduleInfoResponseDto> firstScheduleList = scheduleService.readByAirportAndDepartureDate(scheduleSelectDto.getAirport1(), scheduleSelectDto.getAirport2(), scheduleSelectDto.getFlightDate1()); 
			
			firstScheduleList.forEach(s -> {
				// 형식 변환
				s.formatTime();
				
				// 좌석 등급별 티켓 가격 가져오기
				SeatPriceDto seatPriceDto = seatService.readSeatPriceByScheduleId(s.getId());
				List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "이코노미");				
				List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "비즈니스");				
				List<SeatStatusResponseDto> fSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "퍼스트");				
				
				// 좌석 등급별 가격, 전체 좌석 수, 잔여 좌석 수 세팅
				s = TicketUtil.setSeatPriceAndCount(s, seatPriceDto, eSeatList, bSeatList, fSeatList);
			});
			
			// 두 번째 여정에 해당하는 스케줄 리스트
			List<ScheduleInfoResponseDto> secondScheduleList = scheduleService.readByAirportAndDepartureDate(scheduleSelectDto.getAirport2(), scheduleSelectDto.getAirport1(), scheduleSelectDto.getFlightDate2()); 
			
			// 좌석 정보
			secondScheduleList.forEach(s -> {
				// 형식 변환
				s.formatTime();
				
				// 좌석 등급별 티켓 가격 가져오기
				SeatPriceDto seatPriceDto = seatService.readSeatPriceByScheduleId(s.getId());
				List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "이코노미");				
				List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "비즈니스");				
				List<SeatStatusResponseDto> fSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "퍼스트");				
				
				// 좌석 등급별 가격, 전체 좌석 수, 잔여 좌석 수 세팅
				s = TicketUtil.setSeatPriceAndCount(s, seatPriceDto, eSeatList, bSeatList, fSeatList);
			});
				
			// 리스트 병합
			responseList.addAll(firstScheduleList);
			responseList.addAll(secondScheduleList);
			
		// 편도
		} else {
			responseList = scheduleService.readByAirportAndDepartureDate(scheduleSelectDto.getAirport1(), scheduleSelectDto.getAirport2(), scheduleSelectDto.getFlightDate1());
			
			// 좌석 정보
			responseList.forEach(s -> {
				// 형식 변환
				s.formatTime();
				
				// 좌석 등급별 티켓 가격 가져오기
				SeatPriceDto seatPriceDto = seatService.readSeatPriceByScheduleId(s.getId());
				List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "이코노미");				
				List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "비즈니스");				
				List<SeatStatusResponseDto> fSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "퍼스트");				
				
				// 좌석 등급별 가격, 전체 좌석 수, 잔여 좌석 수 세팅
				s = TicketUtil.setSeatPriceAndCount(s, seatPriceDto, eSeatList, bSeatList, fSeatList);
			});
		}
		return responseList;
	}
	
	/**
	 * @return 좌석 선택 페이지
	 */
	@GetMapping("/selectSeat")
	public String selectSeatPage(Model model, TicketOptionDto ticketOptionDto) {
		
		// 객체 세팅
		List<TicketDto> ticketList = ticketOptionDto.setVariables();
		ticketList.forEach(t -> {
			t.setAirplaneId(scheduleService.readByScheduleId(t.getScheduleId()).getAirplaneId());
		});

		// 티켓 옵션 정보
		model.addAttribute("ticketList", ticketList);
		// 선택할 좌석 수 (성인 + 소아)
		model.addAttribute("totalSeatCount", ticketList.get(0).getAdultCount() + ticketList.get(0).getChildCount());
		
		// 운항 스케줄 정보
		ScheduleInfoResponseDto scheduleInfo1 = scheduleService.readInfoDtoByScheduleId(ticketList.get(0).getScheduleId());
		scheduleInfo1.formatDateTime();
		model.addAttribute("sch1Info", scheduleInfo1);
		
		// 스케줄1에 운항하는 비행기의 이코노미 좌석 리스트 (예약 여부 포함)
		List<SeatStatusResponseDto> eSeatList1 = seatService.readSeatListByScheduleIdAndGrade(ticketList.get(0).getScheduleId(), "이코노미");
		model.addAttribute("sch1EcList", eSeatList1);
		// 스케줄1에 운항하는 비행기의 비즈니스 좌석 리스트 (예약 여부 포함)
		List<SeatStatusResponseDto> bSeatList1 = seatService.readSeatListByScheduleIdAndGrade(ticketList.get(0).getScheduleId(), "비즈니스");
		model.addAttribute("sch1BuList", bSeatList1);
		// 스케줄1에 운항하는 비행기의 퍼스트 좌석 리스트 (예약 여부 포함)
		List<SeatStatusResponseDto> fSeatList1 = seatService.readSeatListByScheduleIdAndGrade(ticketList.get(0).getScheduleId(), "퍼스트");
		model.addAttribute("sch1FiList", fSeatList1);
		
		// 왕복이라면
		if (ticketList.size() == 2) {
			ScheduleInfoResponseDto scheduleInfo2 = scheduleService.readInfoDtoByScheduleId(ticketList.get(1).getScheduleId());
			scheduleInfo2.formatDateTime();
			model.addAttribute("sch2Info", scheduleInfo2);
			
			// 스케줄2에 운항하는 비행기의 이코노미 좌석 리스트 (예약 여부 포함)
			List<SeatStatusResponseDto> eSeatList2 = seatService.readSeatListByScheduleIdAndGrade(ticketList.get(1).getScheduleId(), "이코노미");
			model.addAttribute("sch2EcList", eSeatList2);
			// 스케줄2에 운항하는 비행기의 비즈니스 좌석 리스트 (예약 여부 포함)
			List<SeatStatusResponseDto> bSeatList2 = seatService.readSeatListByScheduleIdAndGrade(ticketList.get(1).getScheduleId(), "비즈니스");
			model.addAttribute("sch2BuList", bSeatList2);
			// 스케줄1에 운항하는 비행기의 퍼스트 좌석 리스트 (예약 여부 포함)
			List<SeatStatusResponseDto> fSeatList2 = seatService.readSeatListByScheduleIdAndGrade(ticketList.get(1).getScheduleId(), "퍼스트");
			model.addAttribute("sch2FiList", fSeatList2);
		}
		return "/ticket/selectSeat";
	}
	
	/**
	 * AJAX 통신용
	 * @return 선택한 좌석의 정보
	 */
	@GetMapping("/selectedSeatData")
	@ResponseBody
	public SeatInfoResponseDto selectedSeatData(@RequestParam String seatName, @RequestParam Integer scheduleId) {
		
		SeatInfoResponseDto responseDto = seatService.readSeatInfoByNameAndScheduleId(seatName, scheduleId);
		
		return responseDto;
	}
	
	/**
	 * @return 탑승객 정보 입력 + 결제 페이지
	 */
	@GetMapping("/payment")
	public String paymentPage(Model model, TicketDto ticketDto) {
		
		// 운항 스케줄 정보
		ScheduleInfoResponseDto scheduleInfo1 = scheduleService.readInfoDtoByScheduleId(ticketDto.getScheduleId());
		scheduleInfo1.formatDateTimeType2();
		model.addAttribute("sch1Info", scheduleInfo1);
		
		// 티켓 가격
		SeatPriceDto seatPriceDto1 = seatService.readSeatPriceByScheduleId(ticketDto.getScheduleId());
		
		// 성인 1인 기준 가격
		Long sch1Price = TicketUtil.seatPriceByGrade(seatPriceDto1, ticketDto.getSeatGrade());
		
		Long sch1AdultPrice = sch1Price * ticketDto.getAdultCount();	
		Long sch1ChildPrice = (long) (sch1Price * Define.CHILD_PRICE_RATE * ticketDto.getChildCount());	
		Long sch1InfantPrice = (long) (sch1Price * Define.INFANT_PRICE_RATE * ticketDto.getInfantCount());	
		
		model.addAttribute("sch1AdultPrice", sch1AdultPrice);
		model.addAttribute("sch1ChildPrice", sch1ChildPrice);
		model.addAttribute("sch1InfantPrice", sch1InfantPrice);
		
		Long price = sch1AdultPrice + sch1ChildPrice + sch1InfantPrice;
		ticketDto.setPrice(price);
		// 마일리지 가격
		Long milesPrice = (long) Math.floor(price * Define.MILES_TICKET_RATE);
		model.addAttribute("milesPrice", milesPrice);
		
		// 왕복이라면
		if (ticketDto.getScheduleId2() != null) {
			ScheduleInfoResponseDto scheduleInfo2 = scheduleService.readInfoDtoByScheduleId(ticketDto.getScheduleId2());
			scheduleInfo2.formatDateTimeType2();
			model.addAttribute("sch2Info", scheduleInfo2);
			// 티켓 가격
			SeatPriceDto seatPriceDto2 = seatService.readSeatPriceByScheduleId(ticketDto.getScheduleId2());
			// 성인 1인 기준 가격
			Long sch2Price = TicketUtil.seatPriceByGrade(seatPriceDto2, ticketDto.getSeatGrade2());
			
			Long sch2AdultPrice = sch2Price * ticketDto.getAdultCount();	
			Long sch2ChildPrice = (long) (sch2Price * Define.CHILD_PRICE_RATE * ticketDto.getChildCount());	
			Long sch2InfantPrice = (long) (sch2Price * Define.INFANT_PRICE_RATE * ticketDto.getInfantCount());	
			
			model.addAttribute("sch2AdultPrice", sch2AdultPrice);
			model.addAttribute("sch2ChildPrice", sch2ChildPrice);
			model.addAttribute("sch2InfantPrice", sch2InfantPrice);
			
			Long price2 = sch2AdultPrice + sch2ChildPrice + sch2InfantPrice;
			ticketDto.setPrice2(price2);
			Long milesPrice2 = (long) Math.floor(price2 * Define.MILES_TICKET_RATE);
			model.addAttribute("milesPrice2", milesPrice2);
		}
		
		model.addAttribute("ticket", ticketDto);
		
		return "/ticket/payment";
	}
	
	/**
	 * @return 항공권 구매 내역 페이지
	 */
	@GetMapping("/list/{page}")
	public String ticketListPage(Model model, @PathVariable Integer page) {
		String memberId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		// 전체 구매 내역
		List<TicketAllInfoDto> allTicketList = ticketService.readTicketListByMemberId(memberId);
		// 총 페이지 수
		int pageCount = (int) Math.ceil(allTicketList.size() / 10.0);
		model.addAttribute("pageCount", pageCount);
		
		// 표시할 글 목록
		Integer index = (page - 1) * 10;
		List<TicketAllInfoDto> ticketList = ticketService.readTicketListByMemberIdLimit(memberId, index);
		
		model.addAttribute("ticketList", ticketList);
		
		return "/ticket/list";
	}
	
	/**
	 * @return 항공권 상세 페이지 (결제 완료된 것만 열람 가능)
	 */
	@GetMapping("/detail/{id}")
	public String ticketDetailPage(Model model, @PathVariable String id) {
		
		TicketAllInfoDto ticket = ticketService.readTicketAllInfoByTicketId(id);
		model.addAttribute("ticket", ticket);
		
		Integer type = null;
		if (ticket.getId().length() == 9 && ticket.getId().substring(8).equals("B")) {
			type = 2;
		} else {
			type = 1;
		}
		model.addAttribute("type", type);
		
		List<Passenger> passengerList = passengerService.readByTicketId(id);
		model.addAttribute("passengerList", passengerList);
		
		List<ReservedSeat> reservedSeatList = reservedSeatService.readByTicketId(id);
		model.addAttribute("reservedSeatList", reservedSeatList);
		
		List<RefundFee> refundFeeList = refundService.readByType(ticket.getScheduleType());
		model.addAttribute("refundFeeList", refundFeeList);
		
		return "/ticket/detail";
	}

	/**
	 * 환불 안내 페이지
	 */
	@GetMapping("/refundInfo")
	public String refundInfoPage(Model model) {
		
		List<RefundFee> refundFeeList1 = refundService.readByType(1);
		model.addAttribute("refundFeeList1", refundFeeList1);
		
		List<RefundFee> refundFeeList2 = refundService.readByType(2);
		model.addAttribute("refundFeeList2", refundFeeList2);
		
		return "/ticket/refundInfo";
	}
	
	/**
	 * 첫 번째 여정과 두 번째 여정의 일정이 정상적으로 선택됐는지 확인
	 */
	@PostMapping("/checkDate")
	@ResponseBody
	public ResponseDto<Boolean> checkDateProc(@RequestBody ScheduleDateCheckDto scheduleDto) {
		
		int statusCode = HttpStatus.OK.value();
		Boolean data = false;
		String message = "정상적인 선택입니다.";
		int code = Define.CODE_SUCCESS;
		String resultCode = "success";
		
		ScheduleInfoResponseDto sch1 = scheduleService.readInfoDtoByScheduleId(scheduleDto.getScheduleId1());
		ScheduleInfoResponseDto sch2 = scheduleService.readInfoDtoByScheduleId(scheduleDto.getScheduleId2());
		
		// 스케줄1의 출발시간이 스케줄2의 출발시간보다 늦다면
		// 즉, 스케줄2가 스케줄1보다 먼저라면
		if (sch1.getDepartureDate().after(sch2.getDepartureDate())) {
			statusCode = HttpStatus.BAD_REQUEST.value();
			data = true;
			message = "첫 번째 여정과 두 번째 여정의 순서가 잘못되었습니다.\n다시 선택해주시길 바랍니다.";
			code = Define.CODE_FAIL;
			resultCode = "fail";
			
		// 스케줄1의 도착시간이 스케줄2의 출발시간보다 늦다면
		// 즉, 스케줄1과 스케줄2의 운항시간이 겹친다면
		} else if (sch1.getArrivalDate().after(sch2.getDepartureDate())) {
			statusCode = HttpStatus.BAD_REQUEST.value();
			data = true;
			message = "첫 번째 여정과 두 번째 여정의 일정이 겹칩니다.\n다시 선택해주시길 바랍니다.";
			code = Define.CODE_FAIL;
			resultCode = "fail";
		}
		
		return new ResponseDto<Boolean>(statusCode, code, message, resultCode, data);	
	}
	
	
	
}
