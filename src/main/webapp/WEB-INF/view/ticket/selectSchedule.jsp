<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
		<script>let manager = 1</script>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
		<script>let manager = 0</script>
	</c:otherwise>
</c:choose>

<link rel="stylesheet" href="/css/ticket.css">

<!-- 항공권 선택 페이지 -->


<main>

	<h2 class="page--title">
		<c:choose>
			<c:when test="${\"관리자\".equals(principal.userRole)}">
				운항 스케줄 조회
			</c:when>
			<c:otherwise>
				항공권 예약
			</c:otherwise>
		</c:choose>
	</h2>
	<hr>
	<br>
	
	<!-- 왕복/편도, 출발지/도착지, 탑승일, 탑승객 수/연령 -->
	<div class="d-flex align-items-center flex-column" style="width: 100%;">
		<div style="width: 1016px" class="size--limit--div">
			<div>
				<h5>여정/날짜 선택</h5>
				<ul class="ticket--type">
					<li id="ticketType1" onclick="selectedType(1);" class="selected--type">왕복
					<li id="ticketType2" onclick="selectedType(2);">편도
				</ul>
			</div>
			
			<br>

			<div class="d-flex">
				<!-- 출발지 -->
				<div id="departureDiv">
					<input type="text" name="departure" placeholder="출발지" id="departure" autocomplete="off">
					<!-- 자동완성 및 공항 선택 -->
					<div class="airport--div" id="departureAirport">
						<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
							<h5>자동 완성</h5>
							<button class="close--button" onclick="$('#departureAirport').hide();" type="button">
								<span class="material-symbols-outlined">close</span>
							</button>
						</div>
						<ul class="autocomplete--list" id="departureList"></ul>
						<div class="d-flex justify-content-center" style="width: 100%">
							<button class="all--airport departure--button" type="button">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">location_on</span>
									<li style="font-size: 15px;">전체 공항 조회
								</ul>
							</button>
						</div>
					</div>
				</div>

				<!-- 출발지 도착지 서로 바꾸는 버튼 -->
				<button id="airportSwapBtn" onclick="airportSwap();" type="button">
					<span class="material-symbols-outlined" style="color: #4c4c4c; font-size: 28px;">swap_horiz</span>
				</button>

				<!-- 도착지 -->
				<div id="destinationDiv">
					<input type="text" name="destination" placeholder="도착지" id="destination" autocomplete="off">
					<!-- 자동완성 및 공항 선택 -->
					<div class="airport--div" id="destinationAirport">
						<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
							<h5>자동 완성</h5>
							<button class="close--button" onclick="$('#destinationAirport').hide();" type="button">
								<span class="material-symbols-outlined">close</span>
							</button>
						</div>
						<ul class="autocomplete--list" id="destinationList"></ul>
						<div class="d-flex justify-content-center" style="width: 100%">
							<button class="all--airport destination--button" type="button">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">location_on</span>
									<li style="font-size: 15px;">전체 공항 조회
								</ul>
							</button>
						</div>
					</div>
				</div>

				<!-- 탑승일 선택 -->
				<div id="flightDateDiv">
					<input type="text" name="flightDate" id="flightDate" placeholder="탑승일" readonly>
					<!-- 날짜 선택 -->
					<!-- 왕복 -->
					<div class="datepicker--div--type1">
						<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
							<h5>날짜 선택</h5>
							<button class="close--button" onclick="$('.datepicker--div--type1').hide();" type="button">
								<span class="material-symbols-outlined">close</span>
							</button>
						</div>
						<div style="background-color: #f3f3f3; padding: 10px; margin-bottom: 10px;">
							<div class="datepicker--div">
								<label for="flightDate1">가는 날</label> <input type="text" class="datepicker flight--date1" id="flightDate1" readonly>
							</div>
							<div class="datepicker--div">
								<label for="flightDate2">오는 날</label> <input type="text" class="datepicker flight--date2" id="flightDate2" readonly>
							</div>
						</div>
					</div>
					<!-- 편도 -->
					<div class="datepicker--div--type2">
						<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
							<h5>날짜 선택</h5>
							<button class="close--button" onclick="$('.datepicker--div--type2').hide();" type="button">
								<span class="material-symbols-outlined">close</span>
							</button>
						</div>
						<div class="datepicker--div" style="background-color: #f3f3f3; padding: 10px; margin-bottom: 10px;">
							<label for="flightDate0">가는 날</label> <input type="text" class="datepicker flight--date" id="flightDate0">
						</div>
					</div>
				</div>
			</div>
			<br> <br>
			<c:if test="${\"관리자\".equals(principal.userRole) == false}">
				<div>
					<h5>탑승 인원 선택</h5>
					<div id="ageTypeDiv">
						<!-- 탑승 인원 선택 -->
						<div style="margin-right: 58px;">
							<!-- 성인은 최소 1명 -->
							<label>성인 (만 12세 이상)</label><br>
							<div class="age--type--div">
								<button class="minus--button" type="button">-</button>
								<input type="number" min="0" max="99" value="1" id="ageType1" readonly>
								<button class="plus--button" type="button">+</button>
							</div>
						</div>
	
						<div style="margin-right: 58px;">
							<label>소아 (만 2세 이상 ~ 12세 미만)</label><br>
							<div class="age--type--div">
								<button class="minus--button" type="button">-</button>
								<input type="number" min="0" max="99" value="0" id="ageType2" readonly>
								<button class="plus--button" type="button">+</button>
							</div>
						</div>
	
						<div>
							<label>유아 (만 2세 미만)</label><br>
							<div class="age--type--div">
								<button class="minus--button" type="button">-</button>
								<input type="number" min="0" max="99" value="0" id="ageType3" readonly>
								<button class="plus--button" type="button">+</button>
							</div>
						</div>
					</div>
					<br>
					<button class="age--calculater" type="button">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">calculate</span>
							<li style="font-size: 15px;">나이 계산기
						</ul>
					</button>
				</div>
			</c:if>
			<br>
			<div class="d-flex justify-content-end" style="width: 100%">
				<button class="blue--btn--big" id="selectScheduleBtn" type="button">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li style="margin-right: 3px;">항공권 조회
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">search</span>
					</ul>
				</button>
			</div>
		</div>

		<!-- 여기서부터 운항 스케줄 출력 -->
		<form action="/ticket/selectSeat" method="get">
			<div class="schedule--list--div" id="scheduleList1">
				<br>
				<hr style="width: 100%">
				<br>
				<h6 class="d-flex align-items-center" style="margin-bottom: 15px; color: #314f79">
					<span class="material-symbols-outlined" style="font-size: 20px;">flight</span>&nbsp;
					<!-- 왕복 : 첫 번째 여정 / 편도 : 편도로 표시 -->
					<span style="font-size: 18px;"></span>
				</h6>
				<h3 class="d-flex align-items-center" style="margin-bottom: 60px;">
					<!-- 출발지 -->
					<span style="width: 300px; text-align: right;"></span>
					<span style="font-size: 23px; margin: 0 50px;">▶</span>
					<!-- 도착지 -->
					<span style="width: 300px; text-align: left;"></span>
				</h3>
				<table border="1">
					<thead>
						<tr>
							<th>출도착시간</th>
							<th>항공편명</th>
							<th>이코노미</th>
							<th>비즈니스</th>
							<th>퍼스트</th>
						</tr>
					</thead>
					<tbody>
						<!-- AJAX로 행 추가 -->
					</tbody>
				</table>
			</div>
			<!-- 왕복 선택 시에만 출력 -->
			<div class="schedule--list--div" id="scheduleList2">
				<br>
				<hr style="width: 100%;">
				<br>
				<h6 class="d-flex align-items-center" style="margin-bottom: 15px; color: #314f79">
					<span class="material-symbols-outlined" style="font-size: 20px;">flight</span>&nbsp;
					<!-- 왕복 : 두 번째 여정 -->
					<span style="font-size: 18px;"></span>
				</h6>
				<h3 class="d-flex align-items-center" style="margin-bottom: 60px;">
					<!-- 출발지 -->
					<span style="width: 300px; text-align: right;"></span>
					<span style="font-size: 23px; margin: 0 50px;">▶</span>
					<!-- 도착지 -->
					<span style="width: 300px; text-align: left;"></span>
				</h3>
				<table border="1">
					<thead>
						<tr>
							<th>출도착시간</th>
							<th>항공편명</th>
							<th>이코노미</th>
							<th>비즈니스</th>
							<th>퍼스트</th>
						</tr>
					</thead>
					<tbody>
						<!-- AJAX로 행 추가 -->
					</tbody>
				</table>
			</div>
			<c:if test="${\"관리자\".equals(principal.userRole) == false}">
				<div id="selectSeatBtnDiv">
					<button type="submit" class="blue--btn--middle" id="selectSeatBtn">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li style="margin-right: 4px;">좌석 선택
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">airline_seat_recline_extra</span>
						</ul>
					</button>
				</div>
			</c:if>
		</form>
	</div>

	<!-- 전체 공항 조회 모달 -->
	<div class="modal fade header--modal all--airport--modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal--title--div">
					<h4 class="modal--title"></h4>
					<button class="close--button" onclick="$('.all--airport--modal').modal('hide');">
						<span class="material-symbols-outlined">close</span>
					</button>
				</div>
				<div class="modal-body d-flex">

					<!-- 지역 목록 -->
					<ul style="min-width: 210px; margin: 0 20px 0 0">
						<c:forEach var="r" items="${regionList}">
							<li class="region--li">${r.region}</li>
						</c:forEach>
					</ul>

					<!-- 지역을 선택하면 취항지 불러오기 -->
					<div style="width: 100%;">
						<h5 style="margin: 0">취항지</h5>
						<hr style="margin: 10px 0 20px;">
						<ul class="airport--ul">
						</ul>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- 나이 계산기 모달 -->
	<div class="modal fade header--modal age--calculater--modal">
		<div class="modal-dialog" style="max-width: 350px;">
			<div class="modal-content">
				<div class="modal--title--div">
					<h4 class="modal--title">나이 계산기</h4>
					<button class="close--button" onclick="$('.age--calculater--modal').modal('hide');">
						<span class="material-symbols-outlined">close</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="d-flex align-items-center justify-content-center" style="margin: 10px;">
						<div style="margin-right: 20px;">
							<div class="d-flex" style="margin-bottom: 10px;">
								<label for="birthDate" style="width: 80px; margin: 0">생년월일</label> <input type="text" id="birthDate" placeholder="yyyy-mm-dd">
							</div>
							<div class="d-flex">
								<label for="thisDate" style="width: 80px; margin: 0">탑승일</label> <input type="text" id="thisDate" placeholder="yyyy-mm-dd">
							</div>
						</div>
						<button class="search--btn" id="calculateBtn">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li style="height: 24px; margin-right: 2px;">조회
								<li style="height: 24px;"><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 18px; padding-top: 4px;">touch_app</span>
							</ul>
						</button>
					</div>
					<div id="calculaterResult"></div>
				</div>
			</div>
		</div>
	</div>

</main>

<script src="/js/ticket.js"></script>
<script>
	// 출발날짜 - 현재날짜
	let curDate = new Date();
	let birthDate = stringToDate(`${memberBirthDate}`);
	let memberAgeType = calculateAgeType(birthDate, curDate);
</script>

<!-- 메인 페이지에서 넘어온 경우 -->
<c:if test="${option != null}">
	<script>
		let ticketType = ${option.ticketType};
	
		// 왕복, 편도 선택
		selectedType(ticketType);
		$("#departure").val(`${option.departure}`);
		$("#destination").val(`${option.destination}`);
		$("#ageType1").val(${option.adultCount});
		$("#ageType2").val(${option.childCount});
		$("#ageType3").val(${option.infantCount});
		$("#flightDate").addClass("flight--date--inserted");
		
		var date1 = `${option.flightDate1}`;
		var date2 = `${option.flightDate2}`;
		var date0 = `${option.flightDate0}`;
		
		// 왕복이면
		if (ticketType == 1) {
			$("#flightDate1").val(date1);
			$("#flightDate2").val(date2);
			$("#flightDate").val(date1 + " ~ " + date2);
			
		// 편도면
		} else {
			$("#flightDate0").val(date0);
			$("#flightDate").val(date0);
			
		}
		$("#selectScheduleBtn").click();
		
	</script>
</c:if>

<input type="hidden" name="menuName" id="menuName" value="항공권 예약">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
