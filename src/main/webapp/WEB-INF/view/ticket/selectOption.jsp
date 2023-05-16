<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- 항공권 선택 페이지 -->

<style>
	.ticket--type {
		display: flex;
		border: 1px solid #ccc;
		align-items: center;
		width: 200px;
	}
	
	.ticket--type li {
		cursor: pointer;
		background-color: white;
		flex: 1;
		text-align: center;
		padding: 10px 0;
	}
	
	.selected--type {
		background-color: #8abbe1 !important;
	}
	
	#departure, #destination, #flightDate {
		text-align: center;
		padding: 20px 5px;
		font-size: 30px;
		width: 300px;
		font-weight: 600;
	}
	
	#flightDate {
		cursor: pointer;
	}
	
	.flight--date--inserted {
		font-size: 23px !important;
		padding: 25.25px 5px !important;
	}
	
	#flightDateDiv {
		margin-left: 58px;
	}
	
	#airportSwap {
		/*border: 1px solid rgba(0, 0, 0, 0.2);*/
		border: none;
		background-color: white;
		height: 25px;
		border-radius: 20px;
		margin: 30px 15px;
	} 
	
	.airport--div, .datepicker--div--type1, .datepicker--div--type2 {
		border: 1px solid #ccc;
		width: 300px;
		position: absolute;
		padding: 15px 20px 20px;
		display: none;
	}
	
	.datepicker--div--type1, .datepicker--div--type2 {
		padding: 15px 20px 10px;	
	}
	
	.airport--div h5, .datepicker--div--type1 h5, .datepicker--div--type1 h5 {
		margin-top: 10px;
		font-size: 18px;
		margin-bottom: 0;
	}
	
	.autocomplete--list {
		width: 100%;
		background-color: #f3f3f3;
		min-height: 44px;
		max-height: 210px;
		margin: 0 0 15px;
		padding: 0px 10px;
		overflow: auto; /* max-height 넘으면 스크롤 생김 */
	}
	
	.autocomplete--list li {
		padding: 10px;
		border-bottom: 1px solid #ccc;
	}
	
	.departure--airport--li, .destination--airport--li {
		padding: 8px;
		border-bottom: 1px solid buttonhighlight;
	}
	
	.autocomplete--list li:last-of-type, 
	.departure--airport--li:last-of-type, .destination--airport--li:last-of-type {
		border-bottom: hidden;
	}
	
	.departure--li:hover, .destination--li:hover, 
	.departure--airport--li:hover, .destination--airport--li:hover {
		cursor: pointer;
		font-weight: 600;
		color: #3163aa;
	}
	
	.all--airport {
		color: rgba(0, 0, 0, 0.7);
		border: 1px solid #ccc;
		border-radius: 5px;
		background-color: white;
		padding: 5px 7px 1px 3px;
	}
	
	.close--button {
		height: 24px;
		border: none;
		background: none;
		color: rgba(0, 0, 0, 0.7)
	}
	
	.all--airport--modal {
		margin-top: 200px;
	}
	
	.modal--title--div {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 20px;
		background-color: #ccc;
	}
	
	.modal--title {
		margin: 0;
	}
	
	.region--li {
		padding: 10px;
		border-right: 1px solid white;
		border-bottom: 1px solid white;
		background-color: #f3f3f3;
		cursor: pointer;
	}
	
	.region--li--selected {
		background-color: #BCE3F6;
	}
	
	.airport--ul {
		margin: 0;
		max-height: 300px;
		overflow: auto;
	}
	
	.datepicker {
		text-align: center;
		padding: 0px 0 1px;
		width: 130px;
	}
	
	.datepicker--div {
		margin-bottom: 10px;
	}
	
	.datepicker--div label {
		margin-right: 15px;
		margin-bottom: 0;
	}
	
	.datepicker--div input {
		cursor: pointer;
	}
	
	
</style>


	<main>
	
		<h2>항공권 옵션 선택</h2>
		<hr>
	
		<!-- 왕복/편도, 출발지/도착지, 탑승일, 탑승객 수/연령 -->
		
		<ul class="ticket--type">
			<li id="ticketType1" onclick="selectedType(1);" class="selected--type">왕복
			<li id="ticketType2" onclick="selectedType(2);">편도
		</ul>
		
		<div class="d-flex">
			<!-- 출발지 -->
			<div id="departureDiv">
				<input type="text" name="departure" placeholder="출발지" id="departure" autocomplete="off">
				<!-- 자동완성 및 공항 선택 -->
				<div class="airport--div" id="departureAirport">
					<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
						<h5>자동 완성</h5>
						<button class="close--button" onclick="$('#departureAirport').hide();">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<ul class="autocomplete--list" id="departureList">
					</ul>
					<div class="d-flex justify-content-center" style="width: 100%">
						<button class="all--airport departure--button">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">location_on</span>
								<li style="font-size: 15px;">전체 공항 조회
							</ul>
						</button>
					</div>
				</div>
			</div>
		
			<!-- 출발지 도착지 서로 바꾸는 버튼 -->
			<button id="airportSwap" onclick="airportSwap();">
				<span class="material-symbols-outlined" style="color: #4c4c4c; font-size: 28px;">swap_horiz</span>
			</button>
			
			<!-- 도착지 -->
			<div id="destinationDiv">
				<input type="text" name="destination" placeholder="도착지" id="destination" autocomplete="off">
				<!-- 자동완성 및 공항 선택 -->
				<div class="airport--div" id="destinationAirport">
					<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
						<h5>자동 완성</h5>
						<button class="close--button" onclick="$('#destinationAirport').hide();">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<ul class="autocomplete--list" id="destinationList">
					
					</ul>
					<div class="d-flex justify-content-center" style="width: 100%">
						<button class="all--airport destination--button">
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
						<button class="close--button" onclick="$('.datepicker--div--type1').hide();">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<div class="datepicker--div">
						<label for="flightDate1">가는 날</label>
						<input type="text" class="datepicker flight--date1" id="flightDate1">
					</div>
					<div class="datepicker--div">
						<label for="flightDate2">오는 날</label>
						<input type="text" class="datepicker flight--date2" id="flightDate2">
					</div>
				</div>
				<!-- 편도 -->
				<div class="datepicker--div--type2">
					<div class="d-flex justify-content-between" style="margin-bottom: 15px;">
						<h5>날짜 선택</h5>
						<button class="close--button" onclick="$('.datepicker--div--type2').hide();">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<div class="datepicker--div">
						<label for="flightDate0">편도</label>
						<input type="text" class="datepicker flight--date" id="flightDate0">
					</div>
				</div>
			</div>
		</div>
		<div>
			<!-- 탑승 인원 선택 -->
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
		
	</main>


<script src="/js/ticket.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
