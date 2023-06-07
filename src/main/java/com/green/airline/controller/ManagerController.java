package com.green.airline.controller;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.green.airline.dto.request.ManagerFormDto;
import com.green.airline.dto.response.CountByYearAndMonthDto;
import com.green.airline.dto.response.DestinationCountDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.MemberInfoDto;
import com.green.airline.dto.response.MonthlySalesForChartDto;
import com.green.airline.dto.response.ProductBrandOrderAmountDto;
import com.green.airline.dto.response.ResponseDto;
import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.VocCountByTypeDto;
import com.green.airline.dto.response.VocInfoDto;
import com.green.airline.enums.UserRole;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.Manager;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.Memo;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.BaggageRequestService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.service.ManagerService;
import com.green.airline.service.MemoService;
import com.green.airline.service.ProductService;
import com.green.airline.service.RouteService;
import com.green.airline.service.TicketPaymentService;
import com.green.airline.service.TicketService;
import com.green.airline.service.UserService;
import com.green.airline.service.VocService;
import com.green.airline.utils.Define;
import com.green.airline.utils.PagingObj;
import com.green.airline.utils.PhoneNumberUtil;

@RequestMapping("/manager")
@Controller
public class ManagerController {

	@Autowired
	private TicketPaymentService ticketPaymentService;

	@Autowired
	private MemoService memoService;

	@Autowired
	private UserService userService;

	@Autowired
	private VocService vocService;

	@Autowired
	private RouteService routeService;

	@Autowired
	private ProductService productService;

	@Autowired
	private AirportService airportService;

	@Autowired
	private TicketService ticketService;

	@Autowired
	private ManagerService managerService;

	@Autowired
	private InFlightSvService inFlightSvService;

	@Autowired
	private BaggageRequestService baggageRequestService;

	@Autowired
	private HttpSession session;

	/**
	 * @author 서영
	 * @return 대시보드 (관리자 페이지의 메인)
	 */
	@GetMapping("/dashboard")
	public String dashboardPage(Model model) {

		String managerId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();

		Integer year = LocalDateTime.now().getYear();
		Integer nowMonth = LocalDateTime.now().getMonthValue();
		Integer lastMonth = LocalDateTime.now().minusMonths(1).getMonthValue();

		// 최근 1년간 월간 매출액 (이번 달 제외)
		List<MonthlySalesForChartDto> salesList = ticketPaymentService.readMonthlySales(year + "-" + nowMonth + "-01");

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

		// 지난 달에 작성된 고객의 말씀 유형별 개수
		List<VocCountByTypeDto> vocCountList = null;
		// 만약 저번 달이 12월이라면
		if (lastMonth.intValue() == 12) {
			vocCountList = vocService.readWriteCountGroupByType(year - 1, lastMonth);
		} else {
			vocCountList = vocService.readWriteCountGroupByType(year, lastMonth);
		}

		// JSON으로 변환
		JsonArray jsonArray2 = new JsonArray();
		Iterator<VocCountByTypeDto> it2 = vocCountList.iterator();
		while (it2.hasNext()) {
			VocCountByTypeDto dto = it2.next();
			JsonObject object = new JsonObject();
			object.addProperty("type", dto.getType());
			object.addProperty("count", dto.getCount());
			jsonArray2.add(object);
		}
		String vocData = gson.toJson(jsonArray2);
		model.addAttribute("vocData", vocData);

		// 도착지별 이용객 수 순위
		List<DestinationCountDto> routeCountList = routeService.readGroupByDestinationLimitN(12);

		// JSON으로 변환
		JsonArray jsonArray3 = new JsonArray();
		Iterator<DestinationCountDto> it3 = routeCountList.iterator();
		while (it3.hasNext()) {
			DestinationCountDto dto = it3.next();
			JsonObject object = new JsonObject();
			object.addProperty("destination", dto.getDestination());
			object.addProperty("count", dto.getCount());
			jsonArray3.add(object);
		}
		String routeData = gson.toJson(jsonArray3);
		model.addAttribute("routeData", routeData);

		// 마일리지샵 구매량 상위 n개 브랜드
		List<ProductBrandOrderAmountDto> brandList = productService.readTopNBrand(5);
		Collections.reverse(brandList);

		// JSON으로 변환
		JsonArray jsonArray4 = new JsonArray();
		Iterator<ProductBrandOrderAmountDto> it4 = brandList.iterator();
		while (it4.hasNext()) {
			ProductBrandOrderAmountDto dto = it4.next();
			JsonObject object = new JsonObject();
			object.addProperty("brand", dto.getBrand());
			object.addProperty("orderAmount", dto.getOrderAmount());
			jsonArray4.add(object);
		}
		String brandData = gson.toJson(jsonArray4);
		model.addAttribute("brandData", brandData);

		// 이번 달 매출액
		MonthlySalesForChartDto nowMonthSales = ticketPaymentService.readSalesByThisMonth(year, nowMonth);
		Long nowMonthSalesValue = (long) 0;
		if (nowMonthSales != null) {
			nowMonthSalesValue = nowMonthSales.getSales();
		}
		model.addAttribute("thisMonthSales", nowMonthSalesValue);

		// 저번 달 매출액
		MonthlySalesForChartDto lastMonthSales = null;
		// 만약 저번 달이 12월이라면
		if (lastMonth.intValue() == 12) {
			lastMonthSales = ticketPaymentService.readSalesByThisMonth(year - 1, lastMonth);
		} else {
			lastMonthSales = ticketPaymentService.readSalesByThisMonth(year, lastMonth);
		}

		Long lastMonthSalesValue = (long) 0;
		if (lastMonthSales != null) {
			lastMonthSalesValue = lastMonthSales.getSales();
		}
		// 저번 달 대비 매출액 증감 여부 (보류)
		Long salesDiff = nowMonthSalesValue - lastMonthSalesValue;
		model.addAttribute("salesDiff", salesDiff);

		// 이번 달 신규 회원 수
		Integer newUserCount = 0;
		CountByYearAndMonthDto newCountDto = userService.readNewUserCount(year, nowMonth);
		// 신규 회원이 존재하지 않으면 null
		if (newCountDto != null) {
			newUserCount = newCountDto.getCount();
		}
		model.addAttribute("newUserCount", newUserCount);

		// 이번 달 탈퇴 회원 수
		Integer withdrawUserCount = 0;
		CountByYearAndMonthDto withdrawCountDto = userService.readWithdrawUserCount(year, nowMonth);
		// 탈퇴 회원이 존재하지 않으면 null
		if (withdrawCountDto != null) {
			withdrawUserCount = withdrawCountDto.getCount();
		}
		model.addAttribute("withdrawUserCount", withdrawUserCount);

		// 이번 달에 작성된 고객의 말씀 수
		Integer vocCount = 0;
		CountByYearAndMonthDto vocCountDto = vocService.readWriteCount(year, nowMonth);
		// 작성된 고객의 말씀 내역이 존재하지 않으면 null
		if (vocCountDto != null) {
			vocCount = vocCountDto.getCount();
		}
		model.addAttribute("vocCount", vocCount);

		// 해당 관리자의 메모 불러오기
		Memo memo = memoService.readByManagerId(managerId);
		model.addAttribute("memo", memo);

		// 처리되지 않은 고객의 말씀 리스트 최근순 5개
		List<VocInfoDto> vocList = vocService.readVocListLimit(0, 0, 5);
		model.addAttribute("vocList", vocList);
		// 처리되지 않은 고객의 말씀 리스트 개수
		Integer vocListCount = vocService.readVocList(0).size();
		model.addAttribute("vocListCount", vocListCount);

		// 메인 페이지임을 표시 (메뉴 설정 시 필요)
		int isMain = 1;
		model.addAttribute("isMain", isMain);

		return "/manager/dashboard";
	}

	/**
	 * @author 서영 메모 갱신
	 */
	@PostMapping("/updateMemo")
	@ResponseBody
	public void updateMemoProc(@RequestBody Memo memo) {

		String managerId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		memo.setManagerId(managerId);
		memoService.updateMemo(memo);
	}

	/**
	 * @author 서영
	 * @return 회원정보 조회
	 */
	@GetMapping("/memberList/{page}")
	public String memberListPage(@PathVariable Integer page, Model model) {

		// 전체 회원 목록
		List<Member> allMemberList = userService.readMemberListAll();
		// 총 페이지 수
		int pageCount = (int) Math.ceil(allMemberList.size() / 10.0);
		model.addAttribute("pageCount", pageCount);

		// 표시할 글 목록
		Integer index = (page - 1) * 10;
		List<MemberInfoDto> memberList = userService.readMemberListAllLimit(index);
		model.addAttribute("memberList", memberList);

		return "/manager/memberList";
	}

	/**
	 * @author 서영
	 * @return 회원정보 조회 검색
	 */
	@GetMapping("/memberList/search")
	public String memberListPage(@RequestParam String memberId, Model model) {

		List<MemberInfoDto> memberList = userService.readMemberListSearch(memberId.trim());
		model.addAttribute("memberList", memberList);

		model.addAttribute("search", memberId);

		return "/manager/memberList";
	}

	/**
	 * @author 서영
	 * @return 회원정보 상세 페이지
	 */
	@GetMapping("/memberDetail/{id}")
	public String memberDetailPage(@PathVariable String id, Model model) {

		MemberInfoDto member = userService.readMemberById(id);
		model.addAttribute("member", member);

		return "/manager/memberDetail";
	}

	/**
	 * @author 서영
	 * @return 관리자 정보 조회
	 */
	@GetMapping("/list/{page}")
	public String managerListPage(@PathVariable Integer page, Model model) {

		// 전체 회원 목록
		List<Manager> allManagerList = managerService.readManagerListAll();
		// 총 페이지 수
		int pageCount = (int) Math.ceil(allManagerList.size() / 10.0);
		model.addAttribute("pageCount", pageCount);

		// 표시할 글 목록
		Integer index = (page - 1) * 10;
		List<Manager> managerList = managerService.readManagerListAllLimit(index);
		model.addAttribute("managerList", managerList);

		return "/manager/managerList";
	}

	/**
	 * @author 서영
	 * @return 관리자 정보 조회 검색
	 */
	@GetMapping("/list/search")
	public String managerListPage(@RequestParam String managerId, Model model) {

		List<Manager> managerList = managerService.readManagerListSearch(managerId.trim());
		model.addAttribute("managerList", managerList);

		model.addAttribute("search", managerId);

		return "/manager/managerList";
	}

	/**
	 * @author 서영
	 * @return 항공 서비스 탭 메인 페이지
	 */
	@GetMapping("/airService")
	public String airServicePage() {
		return "/manager/airService";
	}

	/**
	 * @author 서영
	 * @return 회원관리 탭 메인 페이지
	 */
	@GetMapping("/userManage")
	public String userManagePage() {
		return "/manager/userManage";
	}

	/**
	 * @author 서영
	 * @return 마일리지샵 탭 메인 페이지
	 */
	@GetMapping("/mileageShop")
	public String mileageShopPage() {
		return "/manager/mileageShop";
	}

	/**
	 * @author 서영
	 * @return 관리자용 항공권 조회 페이지
	 */
	@GetMapping("/scheduleList")
	public String selectTicketOptionPage(Model model) {

		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);

		return "/ticket/selectSchedule";
	}

	/**
	 * @author 서영
	 * @return 관리자용 항공권 구매 내역 페이지
	 */
	@GetMapping("/ticketList/{page}")
	public String ticketListPage(Model model, @PathVariable Integer page) {
		// 전체 구매 내역
		List<TicketAllInfoDto> allTicketList = ticketService.readTicketListAll();
		// 총 페이지 수
		int pageCount = (int) Math.ceil(allTicketList.size() / 10.0);
		model.addAttribute("pageCount", pageCount);

		// 표시할 글 목록
		Integer index = (page - 1) * 10;
		List<TicketAllInfoDto> ticketList = ticketService.readTicketListAllLimit(index);

		model.addAttribute("ticketList", ticketList);

		return "/manager/ticketList";
	}

	/**
	 * @author 서영 회원 탈퇴 처리
	 */
	@PutMapping("/memberWithdraw/{memberId}")
	@ResponseBody
	public ResponseDto<Boolean> memberWithdraw(@PathVariable String memberId) {

		Integer statusCode = HttpStatus.OK.value();
		Integer code = Define.CODE_SUCCESS;
		String resultCode = Define.RESULT_CODE_SUCCESS;
		String message = "탈퇴 처리되었습니다.";
		Boolean data = userService.updateUserByStatus(memberId, 1);

		// 탈퇴 처리가 되지 않았다면
		if (data == false) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			code = Define.CODE_FAIL;
			resultCode = Define.RESULT_CODE_FAIL;
			message = "이미 탈퇴한 회원입니다.";
		}
		return new ResponseDto<Boolean>(statusCode, code, message, resultCode, data);
	}

	/**
	 * @return 관리자 등록 페이지
	 */
	@GetMapping("/registration")
	public String manageRegPage() {
		return "/manager/registration";
	}

	/**
	 * 관리자 등록 처리
	 */
	@PostMapping("/registration")
	public String manageRegProc(@Valid ManagerFormDto managerFormDto, BindingResult bindingResult) {

		// 빈 값이 있는지 확인
		if (bindingResult.hasErrors()) {
			throw new CustomRestfullException("입력되지 않은 필수 항목이 존재합니다.", HttpStatus.BAD_REQUEST);
		}

		// 전화번호 형식 확인
		String phoneNumber = PhoneNumberUtil.checkPhoneNumber(managerFormDto.getPhoneNumber());
		managerFormDto.setPhoneNumber(phoneNumber);

		// 아이디 생성 (m + 난수 6자리)
		String id = "m" + (int) Math.floor(Math.random() * 899999 + 100000);

		// 해당 id가 이미 존재하는지 확인 (존재한다면 다시)
		User searchUser = userService.readUserById(id);
		// 이미 존재한다면 반복문으로 들어감
		while (searchUser != null) {
			id = "m" + (int) Math.floor(Math.random() * 899999 + 100000);
			searchUser = userService.readUserById(id);
		}

		Manager manager = Manager.builder().id(id).name(managerFormDto.getManagerName())
				.birthDate(managerFormDto.getBirthDate()).gender(managerFormDto.getGender())
				.phoneNumber(managerFormDto.getPhoneNumber()).email(managerFormDto.getEmail()).build();
		managerService.createManager(manager);

		User user = User.builder().id(id).password(id).userRole(UserRole.ADMIN.getUserRole()).build();
		userService.createUser(user);

		return "redirect:/manager/list/1";
	}

	// 특별 기내식 신청 내역
	@GetMapping("/inFlightSpecialMeal")
	public String inFlightSpecialMealPage(Model model,
			@RequestParam(name = "nowPage", defaultValue = "1", required = false) String nowPage,
			@RequestParam(name = "cntPerPage", defaultValue = "10", required = false) String cntPerPage) {
		Integer total = inFlightSvService.readInFlightMealCount();
		PagingObj obj = new PagingObj(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		List<InFlightMealResponseDto> inFlightMealResonseDtos = inFlightSvService.readInFlightMealForManager(obj);

		model.addAttribute("paging", obj);
		model.addAttribute("inFlightMealResonseDtos", inFlightMealResonseDtos);
		return "/manager/inFlightSpecialMeal";
	}

	// 위탁 수하물 신청 내역
	@GetMapping("/baggageRequest")
	public String baggageRequestPage(Model model,
			@RequestParam(name = "nowPage", defaultValue = "1", required = false) String nowPage,
			@RequestParam(name = "cntPerPage", defaultValue = "10", required = false) String cntPerPage) {

		Integer total = baggageRequestService.readBaggageReqCount();
		PagingObj obj = new PagingObj(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		List<InFlightMealResponseDto> inFlightMealResponseDtos = baggageRequestService.readBaggageReqForManager(obj);
		model.addAttribute("inFlightMealResponseDtos", inFlightMealResponseDtos);
		System.out.println(inFlightMealResponseDtos);
		model.addAttribute("paging", obj);

		return "/manager/baggageRequest";
	}

	/**
	 * @author 서영
	 * @return 고객센터 탭 메인 페이지
	 */
	@GetMapping("/customerCenter")
	public String customerCenterPage() {
		return "/manager/customerCenter";
	}

	/**
	 * @author 서영
	 * @return 게시판 관리 탭 메인 페이지
	 */
	@GetMapping("/boardManage")
	public String boardManagePage() {
		return "/manager/boardManage";
	}

	/**
	 * 정다운
	 * @return 관리자 마일리지샵 판매 조회
	 */
	@GetMapping("/productBuyList")
	public String productBuyListPage() {

		return "/manager/productBuyList";
	}
}
