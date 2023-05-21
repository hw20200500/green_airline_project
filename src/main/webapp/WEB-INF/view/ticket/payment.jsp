<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
	.ticket--div {
		background-image: url("/images/ticket/ticket.png");
		width: 1000px;
		height: 180px;
		padding-left: 70px;
	}
	
	.ticket--div h6 {
		padding-top: 14px;
		margin-bottom: 15px;
	}

	ul {
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
	
</style>

<!-- 탑승객 정보 입력 및 결제 페이지 -->

<main class="d-flex flex-column">
	<h2>항공권 예약</h2>
	<hr>
	<br>
	<div class="d-flex justify-content-center" style="width: 100%;">
		<div style="width: 1000px;">
			<h5 style="margin-bottom: 20px;">여정 정보</h5>
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
			<h5 style="margin-bottom: 20px;">탑승객 정보</h5>
			
		</div>
	</div>

</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
