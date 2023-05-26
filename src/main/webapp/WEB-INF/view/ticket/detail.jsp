<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/ticket.css">

<!-- 구매한 항공권 상세 페이지 -->

<style>
	#ticketBackground {
		background-image: url("/images/ticket/ticket2.png");
		width: 1000px;
		height: 285px;
		padding: 80px 0 13px 35px;
		display: flex;
	}
	
	#ticketBackground div:last-of-type {
		margin-top: -4px;
	}
	
	#ticketBackground div:last-of-type p {
		color: #474747;
		margin-bottom: 5px;
	}
	
	p {
		margin: 0;
	}
	
	#passengerTable th:nth-of-type(1) {
		width: 15%;
	}
	
	#passengerTable th:nth-of-type(2) {
		width: 21%;
	}
	
	#passengerTable th:nth-of-type(3) {
		width: 32%;
	}
	
	#passengerTable th:nth-of-type(4) {
		width: 32%;
	}
	
	#paymentTable th:nth-of-type(1) {
		width: 40%;
	}
	
	#paymentTable th:nth-of-type(2) {
		width: 30%;
	}
	
	#paymentTable th:nth-of-type(3) {
		width: 30%;
	}
	
	.var--span {
		font-size: 15px;
		color: #595959;
	}
	
	.var--span--eng {
		font-size: 15px;
		color: #595959;
		font-style: italic;
		margin-right: 15px;
	}
	
	.var--span--eng--s {
		font-size: 14px;
		color: #595959;
		font-style: italic;
		margin-right: 10px;
	}
	
	.value--span {
		font-weight: 500;
		font-size: 18px;
		color: #474747;
	}
	
	.value--span--s {
		font-weight: 500;
		font-size: 15px;
		color: #474747;
	}
	
	.grade--p {
		text-align: center;
		font-size: 20px;
		font-weight: 600;
		margin-bottom: 12px !important;
	}
	
</style>

<main class="d-flex flex-column">
	<h2>항공권 상세 페이지</h2>
	<hr>
	<br>
	<div class="d-flex flex-column align-items-center" style="width: 100%;">
		
			<h5 class="small--title" style="margin-bottom: 35px;">
				<span class="material-symbols-outlined">airplane_ticket</span>
				<span>항공권 정보</span>
			</h5>
			<div id="ticketBackground">
				<div class="d-flex flex-column justify-content-between" style="height: 100%; width: 690px; margin-right: 30px">
					<p>
						<span class="var--span">출발지/도착지</span> 
						<span class="var--span--eng">FROM/TO</span>
						<span class="value--span" style="font-size: 20px; font-weight: 600">${ticket.departure} → ${ticket.destination}</span>
					</p>
					<p>
						<span class="var--span">항공편명</span>
						<span class="var--span--eng">FLIGHT</span>
						<span class="value--span">${ticket.airplaneName}</span>
					</p>
					<p>
						<span class="var--span">출발일/도착일</span> 
						<span class="var--span--eng">DATE</span>
						<span class="value--span">${ticket.formatDepartureDate2()} ~ ${ticket.formatArrivalDate()}</span>
					</p>
					<p>
						<span class="var--span">좌석</span>
						<span class="var--span--eng">SEAT</span>
						<span class="value--span">
							<c:forEach var="seat" items="${reservedSeatList}">
								${seat.seatName}&nbsp;	
							</c:forEach>
						</span>
					</p>
					<p style="text-align: right; color: #595959">${ticket.id}</p>
				</div>
				
				<div style="width: 228px;">
					<p class="grade--p">
						<c:choose>
							<c:when test="${ticket.seatGrade.equals(\"이코노미\")}">
								Economy
							</c:when>
							<c:when test="${ticket.seatGrade.equals(\"비즈니스\")}">
								Business
							</c:when>
							<c:otherwise>
								First
							</c:otherwise>
						</c:choose>
					</p>
					<p>
						<span class="var--span--eng--s">FROM</span>
						<span class="value--span--s">${ticket.departure}</span>
					</p>
					<p>
						<span class="var--span--eng--s">TO</span>
						<span class="value--span--s">${ticket.destination}</span>
					</p>
					<p>
						<span class="var--span--eng--s">FLIGHT</span>
						<span class="value--span--s">${ticket.airplaneName}</span>
					</p>
					<p>
						<span class="var--span--eng--s">DATE</span>
						<span class="value--span--s">${ticket.formatDepartureDate2()}</span>
					</p>
					<p>
						<span class="var--span--eng--s">PASSENGER</span>
						<span class="value--span--s">
							성인${ticket.adultCount}
							<c:if test="${ticket.childCount != 0}">
								&nbsp;소아${ticket.childCount}
							</c:if>
							<c:if test="${ticket.infantCount != 0}">
								&nbsp;유아${ticket.infantCount}
							</c:if>
						</span>
					</p>
				</div>
			
				
			</div>
		
		<div style="width: 900px;" class="d-flex flex-column align-items-center">
			<br><br>
			<hr style="width: 1000px; margin-left: -50px;">
			<br>	

			<h5 class="small--title">
				<span class="material-symbols-outlined">group</span>
				<span>탑승객 정보</span>
			</h5>
			<table border="1" class="list--table" id="passengerTable">
				<thead>
				<tr>
					<th>번호</th>
					<th>성별</th>
					<th>성명</th>
					<th>생년월일</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="i" value="1"/>
				<c:forEach var="passenger" items="${passengerList}">
					<tr>
						<td>
							${i}
						</td>
						<td>
							<c:choose>
								<c:when test="${passenger.gender.equals(\"M\")}">
									남성
								</c:when>
								<c:otherwise>
									여성
								</c:otherwise>
							</c:choose> 
						</td>
						<td>
							${passenger.name}
						</td>
						<td>
							${passenger.birthDate}
						</td>
					</tr>
					<c:set var="i" value="${i + 1}"/>
				</c:forEach>
				</tbody>
			</table>
			
			<br><br>
			<hr style="width: 1000px; margin-left: -50px;">
			<br>	
			
			<h5 class="small--title">
				<span class="material-symbols-outlined" style="margin-top: 1px;">credit_card</span>
				<span>결제 정보</span>
			</h5>
			<table border="1" class="list--table" style="width: 700px;" id="paymentTable">
				<thead>
				<tr>
					<th>결제번호</th>
					<th>결제금액</th>
					<th>상태</th>
				</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							${ticket.tid}
						</td>
						<td>
							${ticket.formatAmount()}원
						</td>
						<td>
							<c:choose>
								<c:when test="${ticket.status == 2}">
									<span style="font-weight: 500; color: #c6c6c6;">환불처리</span>
								</c:when>
								<c:when test="${ticket.status == 1}">
									<span style="font-weight: 500; color: #436195;">결제완료</span>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
			<c:if test="${ticket.checkRefundable()}">
				<div class="d-flex justify-content-center" style="width: 100%; margin: 70px 0 40px;">
					<button class="search--btn--middle" style="padding: 8px 12px 4px 5px;" id="refundBtn">
						<ul class="d-flex justify-content-center">
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 26px; margin-top: 1px;">attach_money</span>
							<li style="margin-left: 4px;">환불 신청
						</ul>
					</button>
				</div>
			</c:if>
		</div>
	</div>
	
	<div class="modal fade header--modal refund--modal">
		<div class="modal-dialog" style="max-width: 400px;">
			<div class="modal-content">
				<div class="modal--title--div">
					<h4 class="modal--title">환불 신청</h4>
					<button class="close--button" onclick="$('.refund--modal').modal('hide');">
						<span class="material-symbols-outlined">close</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="d-flex align-items-center justify-content-center" style="margin: 10px;">
						<form action="/payment/refund" method="post">
							<input type="hidden" name="tid" value="${ticket.tid}">
							<input type="hidden" name="paymentAmount" value="${ticket.amount}">
							<input type="hidden" name="ticketType" value="${type}">
							<input type="hidden" name="dayCount" value="">
							<input type="hidden" name="scheduleType" value="${ticket.scheduleType}">
 							<input type="hidden" name="adultCount" value="${ticket.adultCount}">
 							<input type="hidden" name="childCount" value="${ticket.childCount}">
							<button class="search--btn" id="refundReqBtn" type="submit">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li style="height: 24px; margin-right: 2px;">신청
									<li style="height: 24px;"><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 18px; padding-top: 4px;">touch_app</span>
								</ul>
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</main>

<script>
	$("#refundBtn").on("click", function() {
		$(".refund--modal").modal();
	});
	
	$("#refundReqBtn").on("click", function() {
		
		// 출발날짜 - 현재날짜
		let curDate = new Date();
		let depDate = stringToDate(`${ticket.formatDepartureDate()}`);
		let dayCount = calculateDayDiff(depDate, curDate);
		$("input[name=\"dayCount\"]").val(dayCount);

	});
</script>

<script src="/js/ticket.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
