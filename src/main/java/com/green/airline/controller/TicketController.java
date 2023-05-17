package com.green.airline.controller;

import java.util.ArrayList;
import java.util.List;

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
import com.green.airline.dto.response.ScheduleInfoResponseDto;
import com.green.airline.dto.response.SeatInfoResponseDto;
import com.green.airline.dto.response.SeatStatusResponseDto;
import com.green.airline.repository.model.Airport;
import com.green.airline.service.AirportService;
import com.green.airline.service.ScheduleService;
import com.green.airline.service.SeatService;
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
	
	
	/**
	 * @return 항공권 옵션 선택 페이지
	 */
	@GetMapping("/selectOption")
	public String selectTicketOptionPage(Model model) {
		
		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);
		
		return "/ticket/selectOption";
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
				s.formatDate();
				
				List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "이코노미");				
				// 해당 스케줄에 운항하는 비행기의 전체 이코노미 좌석 수
				Integer eTotalCount = eSeatList.size();
				s.setEcTotalCount(eTotalCount);
				
				// 현재 예약 가능한 이코노미 좌석 수
				Integer eCurCount = TicketUtil.currentSeatCount(eTotalCount, eSeatList);
				s.setEcCurCount(eCurCount);
				
				
				List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "비즈니스");				
				// 해당 스케줄에 운항하는 비행기의 전체 비즈니스 좌석 수
				Integer bTotalCount = bSeatList.size();
				s.setBuTotalCount(bTotalCount);
				
				// 현재 예약 가능한 비즈니스 좌석 수
				Integer bCurCount = TicketUtil.currentSeatCount(bTotalCount, bSeatList);
				s.setBuCurCount(bCurCount);
				
				
				List<SeatStatusResponseDto> fSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "퍼스트");				
				// 해당 스케줄에 운항하는 비행기의 전체 퍼스트 좌석 수
				Integer fTotalCount = fSeatList.size();
				s.setFiTotalCount(fTotalCount);
				
				// 현재 예약 가능한 퍼스트 좌석 수
				Integer fCurCount = TicketUtil.currentSeatCount(fTotalCount, fSeatList);
				s.setFiCurCount(fCurCount);
				
			});
			
			// 두 번째 여정에 해당하는 스케줄 리스트
			List<ScheduleInfoResponseDto> secondScheduleList = scheduleService.readByAirportAndDepartureDate(scheduleSelectDto.getAirport2(), scheduleSelectDto.getAirport1(), scheduleSelectDto.getFlightDate2()); 
			
			// 좌석 정보
			secondScheduleList.forEach(s -> {
				s.formatDate();
				
				List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "이코노미");				
				// 해당 스케줄에 운항하는 비행기의 전체 이코노미 좌석 수
				Integer eTotalCount = eSeatList.size();
				s.setEcTotalCount(eTotalCount);
				
				// 현재 예약 가능한 이코노미 좌석 수
				Integer eCurCount = TicketUtil.currentSeatCount(eTotalCount, eSeatList);
				s.setEcCurCount(eCurCount);
				
				
				List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "비즈니스");				
				// 해당 스케줄에 운항하는 비행기의 전체 비즈니스 좌석 수
				Integer bTotalCount = bSeatList.size();
				s.setBuTotalCount(bTotalCount);
				
				// 현재 예약 가능한 비즈니스 좌석 수
				Integer bCurCount = TicketUtil.currentSeatCount(bTotalCount, bSeatList);
				s.setBuCurCount(bCurCount);
				
				
				List<SeatStatusResponseDto> fSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "퍼스트");				
				// 해당 스케줄에 운항하는 비행기의 전체 퍼스트 좌석 수
				Integer fTotalCount = fSeatList.size();
				s.setFiTotalCount(fTotalCount);
				
				// 현재 예약 가능한 퍼스트 좌석 수
				Integer fCurCount = TicketUtil.currentSeatCount(fTotalCount, fSeatList);
				s.setFiCurCount(fCurCount);
			});
				
			// 리스트 병합
			responseList.addAll(firstScheduleList);
			responseList.addAll(secondScheduleList);
			
		// 편도
		} else {
			responseList = scheduleService.readByAirportAndDepartureDate(scheduleSelectDto.getAirport1(), scheduleSelectDto.getAirport2(), scheduleSelectDto.getFlightDate1());
			
			// 좌석 정보
			responseList.forEach(s -> {
				s.formatDate();
				
				List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "이코노미");				
				// 해당 스케줄에 운항하는 비행기의 전체 이코노미 좌석 수
				Integer eTotalCount = eSeatList.size();
				s.setEcTotalCount(eTotalCount);
				
				// 현재 예약 가능한 이코노미 좌석 수
				Integer eCurCount = TicketUtil.currentSeatCount(eTotalCount, eSeatList);
				s.setEcCurCount(eCurCount);
				
				
				List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "비즈니스");				
				// 해당 스케줄에 운항하는 비행기의 전체 비즈니스 좌석 수
				Integer bTotalCount = bSeatList.size();
				s.setBuTotalCount(bTotalCount);
				
				// 현재 예약 가능한 비즈니스 좌석 수
				Integer bCurCount = TicketUtil.currentSeatCount(bTotalCount, bSeatList);
				s.setBuCurCount(bCurCount);
				
				
				List<SeatStatusResponseDto> fSeatList = seatService.readSeatListByScheduleIdAndGrade(s.getId(), "퍼스트");				
				// 해당 스케줄에 운항하는 비행기의 전체 퍼스트 좌석 수
				Integer fTotalCount = fSeatList.size();
				s.setFiTotalCount(fTotalCount);
				
				// 현재 예약 가능한 퍼스트 좌석 수
				Integer fCurCount = TicketUtil.currentSeatCount(fTotalCount, fSeatList);
				s.setFiCurCount(fCurCount);
			});
			
		}
		
		return responseList;
	}
	
	/**
	 * @return 좌석 선택 페이지
	 */
	@GetMapping("/selectSeat/{scheduleId}")
	public String selectSeatPage(Model model, @PathVariable Integer scheduleId) {
		// 선택할 좌석 수
		model.addAttribute("seatCount", 3);
		
		// 현재 항공 일정 id
		model.addAttribute("scheduleId", scheduleId);
		
		// 해당 스케줄에 운항하는 비행기의 이코노미 좌석 리스트 (예약 여부 포함)
		List<SeatStatusResponseDto> eSeatList = seatService.readSeatListByScheduleIdAndGrade(scheduleId, "이코노미");
		model.addAttribute("economyList", eSeatList);
		
		// 해당 스케줄에 운항하는 비행기의 비즈니스 좌석 리스트 (예약 여부 포함)
		List<SeatStatusResponseDto> bSeatList = seatService.readSeatListByScheduleIdAndGrade(scheduleId, "비즈니스");
		model.addAttribute("businessList", bSeatList);
		
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
	
	
}
