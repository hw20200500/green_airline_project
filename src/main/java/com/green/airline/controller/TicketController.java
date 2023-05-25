package com.green.airline.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.dto.request.ScheduleSelectDto;
import com.green.airline.dto.request.TicketOptionDto;
import com.green.airline.dto.response.ScheduleInfoResponseDto;
import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.dto.response.SeatPriceDto;
import com.green.airline.dto.response.SeatStatusResponseDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.TicketDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.Passenger;
import com.green.airline.repository.model.ReservedSeat;
import com.green.airline.repository.model.Ticket;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.PassengerService;
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
	
	
	/**
	 * @return 항공권 옵션 선택 페이지
	 */
	@GetMapping("/selectSchedule")
	public String selectTicketOptionPage(Model model) {
		
		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);
		
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
		}
		
		model.addAttribute("ticket", ticketDto);
		
		return "/ticket/payment";
	}
	
	/**
	 * @return 항공권 구매 내역 페이지
	 */
	@GetMapping("/list")
	public String ticketListPage(Model model) {
		String memberId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		
		List<TicketAllInfoDto> ticketList = ticketService.readTicketListByMemberId(memberId);
		
		model.addAttribute("ticketList", ticketList);
		
		return "/ticket/list";
	}
	
	/**
	 * @return 항공권 상세 페이지 (결제 완료된 것만 열람 가능)
	 */
	@GetMapping("/detail/{id}")
	public String ticketDetailPage(Model model, @PathVariable String id) {
		
		String memberId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		
		TicketAllInfoDto ticket = ticketService.readTicketAllInfoByTicketId(id);
		model.addAttribute("ticket", ticket);
		
		List<Passenger> passengerList = passengerService.readByTicketId(id);
		model.addAttribute("passengerList", passengerList);
		
		List<ReservedSeat> reservedSeatList = reservedSeatService.readByTicketId(id);
		model.addAttribute("reservedSeatList", reservedSeatList);
		
		String name = userService.readMemberById(memberId).getKorName();
		model.addAttribute("name", name);
		
		return "/ticket/detail";
	}
	
}
