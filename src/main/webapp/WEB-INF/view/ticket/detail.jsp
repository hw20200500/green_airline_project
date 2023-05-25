<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<!-- 구매한 항공권 상세 페이지 -->

<style>
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
	
</style>

<main class="d-flex flex-column">
	<h2>항공권 상세 페이지</h2>
	<hr>
	<br>
	<div class="d-flex justify-content-center" style="width: 100%;">
		<div style="width: 900px;" class="d-flex flex-column align-items-center">
		
		${ticket.id}
	
		
		<c:forEach var="seat" items="${reservedSeatList}">
			<br>
			${seat.seatName}	
			<br>
		</c:forEach>
		
		

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
			
			<br>
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
									<span style="font-weight: 500; color: #c6c6c6;">결제취소</span>
								</c:when>
								<c:when test="${ticket.status == 1}">
									<span style="font-weight: 500; color: #436195;">결제완료</span>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
			<c:if test="${ticket.checkDate()}">
				<div class="d-flex justify-content-center" style="width: 100%; margin: 70px 0 40px;">
					<button class="search--btn--middle" style="padding: 8px 12px 4px 5px;">
						<ul class="d-flex justify-content-center">
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 26px; margin-top: 1px;">attach_money</span>
							<li style="margin-left: 4px;">환불 신청
						</ul>
					</button>
				</div>
			</c:if>
			
		</div>
	</div>

</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
