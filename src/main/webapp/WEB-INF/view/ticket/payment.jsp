<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
	
	.small--title {
		display: flex;
		align-items: center;
		justify-content: center;
		margin-bottom: 30px; 
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
	
	.passenger--info--list table th:first-child, .passenger--info--list table td:first-child {
		border-left: hidden;
	}
	
	.passenger--info--list table th:last-child, .passenger--info--list table td:last-child {
		border-right: hidden;
	}
	
	.passenger--info--list table tr:first-of-type th {
		border-top: 2px solid #ccc;
	}
	
	.passenger--info--list table tr:last-of-type td {
		border-bottom: 2px solid #ccc;
	}
	
	.passenger--info--list table th {
		font-size: 17px;
		text-align: center;
		padding: 5px;
	}
	
	.passenger--info--list table td {
		padding: 5px;
		font-size: 17px;
		text-align: center;		
	}
	
	.passenger--info--list label {
		cursor: pointer;
	}
	
	.name--td input, .birth--td input {
		outline: none;
		border: none;
		text-align: center;
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
			<hr>
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
			<hr>
			<br>
			<!-- 여기서부터 결제 정보 -->
			<h5 class="small--title">
				<span class="material-symbols-outlined">credit_card</span>
				<span>결제 정보</span>
			</h5>
			
		</div>
	</div>

</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
