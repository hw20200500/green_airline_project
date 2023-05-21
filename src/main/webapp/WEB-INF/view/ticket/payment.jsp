<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
	.ticket--div {
		background-image: url("/images/ticket/ticket.png");
		width: 900px;
		height: 180px;
		padding-left: 70px;
	}
	
	.ticket--div h6 {
		padding-top: 14px;
		margin-bottom: 15px;
	}

	ul, label {
		margin: 0;
	}
	
	.destination--departure {
		display: flex;
		align-items: flex-end;
	}
	
	.destination--departure span:nth-of-type(1), .destination--departure span:nth-of-type(3) {
		font-size: 24px;
		font-weight: 500;
	}
	
	.destination--departure span:nth-of-type(2) {
		margin: 0 13px 2px;
		font-size: 22px;
	}
	
	.destination--departure span:nth-of-type(4) {
		margin: 0 13px 2px;
		font-size: 22px;
	}
	
	.flight--date {
		color: gray;
	}
	
	.seat--list {
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		width: 810px;
	}
	
	.seat--list:hover {
		overflow: visible;
	}
	
	.small--title {
		display: flex;
		align-items: center;
		justify-content: center;
		margin-bottom: 40px; 
		color: #314f79;
	}
	
	.small--title span:first-of-type {
		margin-right: 5px;
	}
	
	.small--title span:hover {
		color: #314f79;
	}
	
	/* 탑승객 정보 테이블 */
	.passenger--info--list table {
		width: 100%;
		border-color: #ddd;
	}
	
	.passenger--info--list th:nth-of-type(1) {
		width: 15%;
	}
	
	.passenger--info--list th:nth-of-type(2) {
		width: 25%;
	}
	
	.passenger--info--list th:nth-of-type(3) {
		width: 30%;
	}
	
	.passenger--info--list th:nth-of-type(4) {
		width: 30%;
	}
	
	.passenger--info--list th {
		background-color: #E5EFF3;
		color: #404040;
	}
	
	.passenger--info--list table th:first-child, .passenger--info--list table td:first-child, 
	.payment--table th, .payment--table td, .payment--table tr {
		border-left: hidden;
	}
	
	.passenger--info--list table th:last-child, .passenger--info--list table td:last-child,
	.payment--table th, .payment--table td, .payment--table tr {
		border-right: hidden;
	}
	
	.passenger--info--list table tr:first-of-type th, .payment--table th {
		border-top: 2px solid #ccc;
	}
	
	.passenger--info--list table tr:last-of-type td, .payment--table tr:last-of-type td {
		border-bottom: 2px solid #ccc;
	}
	
	.passenger--info--list table th, .passenger--info--list table td {
		font-size: 17px;
		text-align: center;
		padding: 5px;
	}
	
	.passenger--info--list label {
		cursor: pointer;
	}
	
	.name--td input, .birth--td input {
		outline: none;
		border: none;
		text-align: center;
	}
	
	.payment--table {
		width: 350px;
		border-color: #ddd;
		margin: 0 auto;
		font-size: 17px;
	}
	
	.payment--table tr:nth-of-type(2) td:first-of-type, .payment--table tr:nth-of-type(7) td:first-of-type {
		padding: 3px 0 3px 30px !important;
	}
	
	.payment--table td:first-of-type {
		padding: 3px 0 3px 60px;
	}
	
	.payment--table tr:nth-of-type(3) td:last-of-type, .payment--table tr:nth-of-type(4) td:last-of-type, 
	.payment--table tr:nth-of-type(5) td:last-of-type, .payment--table tr:nth-of-type(8) td:last-of-type,
	.payment--table tr:nth-of-type(9) td:last-of-type, .payment--table tr:nth-of-type(10) td:last-of-type {
		text-align: right;
		padding: 3px;
	}
	
	.payment--table th {
		padding: 5px;
		background-color: #F5F5F6;
		color: #404040;
	}
	
	.payment--table tr:last-of-type th {
		background-color: #c6dde5;
	}
	
	.payment--table tr:last-of-type th:last-of-type {
		text-align: right;
	}

</style>

<!-- 탑승객 정보 입력 및 결제 페이지 -->

<main class="d-flex flex-column">
	<h2>항공권 예약</h2>
	<hr>
	<br>
	<div class="d-flex justify-content-center" style="width: 100%;">
		<div style="width: 900px;">
			<h5 class="small--title">
				<span class="material-symbols-outlined">airplane_ticket</span>
				<span>여정 정보</span>
			</h5>
			<div>
				<div class="ticket--div" id="ticketDiv1">
					<h6>
						<c:choose>
							<c:when test="${ticket.scheduleId2 != null}">
								가는 편
							</c:when>
							<c:otherwise>
								편도
							</c:otherwise>
						</c:choose>
					</h6>
					<p class="destination--departure">
						<span>${sch1Info.departureAirport}</span>
						<span>▶</span>
						<span>${sch1Info.destinationAirport}</span>
					</p>
					<p class="flight--date">${sch1Info.strDepartureDate}&nbsp;~&nbsp;${sch1Info.strArrivalDate}&nbsp;(${sch1Info.flightTime})</p>
					<p class="seat--list">
						${sch1Info.airplaneName}
						&nbsp;ㅣ&nbsp;
						${ticket.seatGrade}석
						&nbsp;ㅣ&nbsp;
						좌석번호&nbsp;
						<c:forEach var="seat" items="${ticket.seatNames}">
							${seat}&nbsp;
						</c:forEach>
					</p>
				</div>
			
				<c:if test="${ticket.scheduleId2 != null}">
				<br>
				<div class="ticket--div" id="ticketDiv1">
					<h6>오는 편</h6>
					<p class="destination--departure">
						<span>${sch2Info.departureAirport}</span>
						<span>▶</span>
						<span>${sch2Info.destinationAirport}</span>
					</p>
					<p class="flight--date">${sch2Info.strDepartureDate}&nbsp;~&nbsp;${sch2Info.strArrivalDate}&nbsp;(${sch1Info.flightTime})</p>
					<p class="seat--list">
						${sch2Info.airplaneName}
						&nbsp;ㅣ&nbsp;
						${ticket.seatGrade2}석
						&nbsp;ㅣ&nbsp;
						좌석번호&nbsp;
						<c:forEach var="seat" items="${ticket.seatNames2}">
							${seat}&nbsp;
						</c:forEach>
					</p>
				</div>
				</c:if>
			</div>
			<br>
			<hr style="width: 1000px; margin-left: -50px;">
			<br>
			<!-- 여기서부터 탑승객 정보 입력 -->
			<h5 class="small--title">
				<span class="material-symbols-outlined">group</span>
				<span>탑승객 정보</span>
			</h5>
			<div class="passenger--info--list">
				<!-- 성인 -->
				<table border="1">
					<tr>
						<th>구분</th>
						<th>성별</th>
						<th>성명</th>
						<th>생년월일</th>
					</tr>
					<c:forEach var="i" begin="0" end="${ticket.adultCount - 1}">
						<tr id="passenger${i + 1}">
							<td class="age--td">
								성인 ${i + 1}
							</td>
							<td class="gender--td">
								<input type="radio" name="gender${i + 1}" id="genderM${i + 1}">
								<label for="genderM${i + 1}">남성</label>
								&nbsp;&nbsp;
								<input type="radio" name="gender${i + 1}" id="genderF${i + 1}">
								<label for="genderF${i + 1}">여성</label>
							</td>
							<td class="name--td">
								<input type="text" name="name${i + 1}">
							</td>
							<td class="birth--td">
								<input type="text" name="birth${i + 1}">
							</td>
						</tr>
					</c:forEach>
				</table>
				<!-- 소아 -->
				<c:if test="${ticket.childCount != 0}">
					<br>
					<table border="1">
						<tr>
							<th>구분</th>
							<th>성별</th>
							<th>성명</th>
							<th>생년월일</th>
						</tr>
						<c:forEach var="i" begin="0" end="${ticket.childCount - 1}">
							<tr id="passenger${ticket.adultCount + i + 1}">
								<td class="age--td">
									소아 ${i + 1}
								</td>
								<td class="gender--td">
									<input type="radio" name="gender${ticket.adultCount + i + 1}" id="genderM${ticket.adultCount + i + 1}">
									<label for="genderM${ticket.adultCount + i + 1}">남성</label>
									&nbsp;&nbsp;
									<input type="radio" name="gender${ticket.adultCount + i + 1}" id="genderF${ticket.adultCount + i + 1}">
									<label for="genderF${ticket.adultCount + i + 1}">여성</label>
								</td>
								<td class="name--td">
									<input type="text" name="name${ticket.adultCount + i + 1}">
								</td>
								<td class="birth--td">
									<input type="text" name="birth${ticket.adultCount + i + 1}">
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				<!-- 유아 -->
				<c:if test="${ticket.infantCount != 0}">
					<br>
					<table border="1">
						<tr>
							<th>구분</th>
							<th>성별</th>
							<th>성명</th>
							<th>생년월일</th>
						</tr>
						<c:forEach var="i" begin="0" end="${ticket.infantCount - 1}">
							<tr id="passenger${ticket.adultCount + ticket.childCount + i + 1}">
								<td class="age--td">
									유아 ${i + 1}
								</td>
								<td class="gender--td">
									<input type="radio" name="gender${ticket.adultCount + ticket.childCount + i + 1}" id="genderM${ticket.adultCount + ticket.childCount + i + 1}">
									<label for="genderM${ticket.adultCount + ticket.childCount + i + 1}">남성</label>
									&nbsp;&nbsp;
									<input type="radio" name="gender${ticket.adultCount + ticket.childCount + i + 1}" id="genderF${ticket.adultCount + ticket.childCount + i + 1}">
									<label for="genderF${ticket.adultCount + ticket.childCount + i + 1}">여성</label>
								</td>
								<td class="name--td">
									<input type="text" name="name${ticket.adultCount + ticket.childCount + i + 1}">
								</td>
								<td class="birth--td">
									<input type="text" name="birth${ticket.adultCount + ticket.childCount + i + 1}">
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</div>
			<br>
			<div class="d-flex justify-content-center" style="width: 100%; margin: 30px 0 40px;">
				<button class="search--btn--middle" id="passengerInfoBtn">
					<ul class="d-flex justify-content-center">
						<li style="margin-right: 4px;">입력 완료
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">done</span>
					</ul>
				</button>
			</div>
			<!-- 여기서부터 결제 정보 -->
			<div id="paymentDiv">
			<hr style="width: 1000px; margin-left: -50px;">
			<br>
				<h5 class="small--title">
					<span class="material-symbols-outlined">credit_card</span>
					<span>결제 정보</span>
				</h5>
				<div>
					<table border="1" class="payment--table">
						<tr>
							<th colspan="2">
								<c:choose>
									<c:when test="${ticket.scheduleId2 != null}">
										여정 1 요금	
									</c:when>
									<c:otherwise>
										편도 요금
									</c:otherwise>
								</c:choose>
							</th>
						</tr>
						<tr>
							<td>${ticket.seatGrade}</td>
							<td><td>
						<tr>
							<td>성인 ${ticket.adultCount}인</td>
							<!-- 콤마 찍어서 나타내기 -->
							<td><fmt:formatNumber value="${sch1AdultPrice}" pattern="#,###"/>&nbsp;원</td>
						</tr>
						<tr>
							<td>소아 ${ticket.childCount}인</td>
							<td><fmt:formatNumber value="${sch1ChildPrice}" pattern="#,###"/>&nbsp;원</td>
						</tr>
						<tr>
							<td>유아 ${ticket.infantCount}인</td>
							<td><fmt:formatNumber value="${sch1InfantPrice}" pattern="#,###"/>&nbsp;원</td>
						</tr>
						<!-- 왕복이라면 -->
						<c:if test="${ticket.scheduleId2 != null}">
							<tr>
								<th colspan="2">여정 2 요금</th>
							</tr>
							<tr>
								<td>${ticket.seatGrade2}</td>
								<td><td>
							</tr>
							<tr>
								<td>성인 ${ticket.adultCount}인</td>
								<!-- 콤마 찍어서 나타내기 -->
								<td><fmt:formatNumber value="${sch2AdultPrice}" pattern="#,###"/>&nbsp;원</td>
							</tr>
							<tr>
								<td>소아 ${ticket.childCount}인</td>
								<td><fmt:formatNumber value="${sch2ChildPrice}" pattern="#,###"/>&nbsp;원</td>
							</tr>
							<tr>
								<td>유아 ${ticket.infantCount}인</td>
								<td><fmt:formatNumber value="${sch2InfantPrice}" pattern="#,###"/>&nbsp;원</td>
							</tr>
						</c:if>
						<tr>
							<th>총액</th>
							<th><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>&nbsp;원</th>
						</tr>
					</table>
					
				</div>
			</div>
			
		</div>
	</div>

</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
