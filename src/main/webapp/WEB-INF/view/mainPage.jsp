<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/mainPage.css">

<div class="main--img--div">
	<div style="width: 1178px; margin-left: 25px;">
		<div class="menu--name--div">
			<span class="material-symbols-outlined" style="margin: 1px 6px 0 0">airplane_ticket</span> <span>항공권 예약</span>
		</div>
	</div>
	<div class="ticket--option--div">
		<form>
			<ul class="ticket--type">
				<li id="ticketType1" onclick="selectedType(1);" class="selected--type">왕복
				<li id="ticketType2" onclick="selectedType(2);">편도
			</ul>
			<div class="d-flex align-items-end">
				<!-- 출발지 -->
				<div id="departureDiv">
					<p class="option--name--p">
						<span class="material-symbols-outlined">flight_takeoff</span>
						<span>출발지</span>
					</p>
					<input type="text" name="departure" placeholder="FROM" id="departure" autocomplete="off">
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
				<button id="airportSwap" onclick="airportSwap();" type="button">
					<span class="material-symbols-outlined" style="color: #4c4c4c; font-size: 28px;">swap_horiz</span>
				</button>

				<!-- 도착지 -->
				<div id="destinationDiv">
					<p class="option--name--p">
						<span class="material-symbols-outlined">flight_land</span>
						<span>도착지</span>
					</p>
					<input type="text" name="destination" placeholder="TO" id="destination" autocomplete="off">
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
					<p class="option--name--p">
						<span class="material-symbols-outlined">calendar_month</span>
						<span>탑승일</span>
					</p>
					<input type="text" name="flightDate" id="flightDate" placeholder="가는 날 ~ 오는 날" readonly>
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
								<label for="flightDate1">가는 날</label> <input type="text" class="datepicker flight--date1" id="flightDate1">
							</div>
							<div class="datepicker--div">
								<label for="flightDate2">오는 날</label> <input type="text" class="datepicker flight--date2" id="flightDate2">
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
							<label for="flightDate0">가는 날</label> <input type="text" class="datepicker flight--date" id="flightDate0" value="2023-06-13">
						</div>
					</div>
				</div>

				<div id="passengerDiv">
					<p class="option--name--p">
						<span class="material-symbols-outlined">group</span>
						<span>탑승인원</span>
					</p>
					<input type="text" name="passenger" id="passenger" placeholder="탑승인원" value="성인1" readonly>
					<div id="ageTypeDiv">
						<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
							<h5 style="margin-bottom: 10px;">탑승인원 선택</h5>
							<button class="close--button" onclick="$('#ageTypeDiv').hide();" type="button">
								<span class="material-symbols-outlined">close</span>
							</button>
						</div>
						<div class="d-flex align-items-end">
							<!-- 탑승 인원 선택 -->
							<div style="margin-right: 30px;" class="d-flex flex-column align-items-center">
								<!-- 성인은 최소 1명 -->
								<label>성인</label>
								<div class="age--type--div">
									<button class="minus--button" type="button">-</button>
									<input type="number" min="0" max="99" value="1" id="ageType1" readonly>
									<button class="plus--button" type="button">+</button>
								</div>
							</div>

							<div style="margin-right: 30px;" class="d-flex flex-column align-items-center">
								<label>소아</label>
								<div class="age--type--div">
									<button class="minus--button" type="button">-</button>
									<input type="number" min="0" max="99" value="0" id="ageType2" readonly>
									<button class="plus--button" type="button">+</button>
								</div>
							</div>

							<div class="d-flex flex-column align-items-center">
								<label>유아</label>
								<div class="age--type--div">
									<button class="minus--button" type="button">-</button>
									<input type="number" min="0" max="99" value="0" id="ageType3" readonly>
									<button class="plus--button" type="button">+</button>
								</div>
							</div>
							<button class="age--calculater" type="button">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">calculate</span>
									<li style="font-size: 15px;">나이 계산기
								</ul>
							</button>
						</div>
					</div>
				</div>
				<div class="d-flex justify-content-end" style="width: 100%">
					<button class="search--btn--big" id="selectScheduleBtn" type="button">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li style="margin-right: 3px;">항공권 조회
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">search</span>
						</ul>
					</button>
				</div>
			</div>
		</form>
	</div>
</div>


<!-- 여기 안에 쓰기 -->
<main></main>

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

<script src="/js/ticket.js"></script>
<script>
	$(".minus--button, .plus--button").on("click", function() {
		insertPassenger();
	});
</script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
