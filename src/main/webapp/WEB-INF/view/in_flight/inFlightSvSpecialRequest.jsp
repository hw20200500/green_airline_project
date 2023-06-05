<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<style>

#modal--id--arrivaldate:focus {
	outline: none;
}

#modal--id--arrivaldate {
	border: none;
	border-bottom: 1px solid #ebebeb;
	background: #f8f9fc;
	padding: 10px;
	width: 350px;
}

input[type=text]:focus {
	outline: none;
}

input[type=text] {
	text-align: center;
	border: none;
}
</style>

<main>

	<div>
		<div class="modal-header">
			<div>
				<h4 class="modal-title">특별 기내식 신청</h4>
				<div>*특별 기내식을 신청하지 않으시면 기본 기내식이 제공됩니다.</div>
			</div>
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>

		<!-- Modal body -->
		<div class="modal-body">
			<form action="/inFlightService/specialMealReq" method="post">
				<div class="inFlightMeal--selectBox">
					<h4 style="font-size: 25px;">출발 일정</h4>
					<div class="modal--div--arrivaldate">
						<div id="inFlight--arrival">
							<!-- db 안에 들어있는 departureDate는 format 전의 값이니까 2023/05/18 -> 2023년05월18일 -->
							<select name="modal--name--arrivaldate" id="modal--id--arrivaldate">
								<c:forEach var="inFlightServiceResponseDtos" items="${inFlightServiceResponseDtos}">
									<option value="${inFlightServiceResponseDtos.ticketId}_${inFlightServiceResponseDtos.seatCount}" id="arrival--option">${inFlightServiceResponseDtos.departure}→${inFlightServiceResponseDtos.destination}
										${inFlightServiceResponseDtos.departureDateFormat()}</option>
								</c:forEach>
							</select> <br>
						</div>
					</div>
				</div>

				<div>
					<div class="modal--ifmdName">
						<div id="inFlightMeals--detail">
							<div class="inFlightMeals--request--wrap">
								<div>
									<h5>유아식 및 아동식</h5>
								</div>
								<br>
								<div class="inflightService--wrap">
									<c:forEach var="babyMeal" items="${babyMeal}" varStatus="status">
										<input type="radio" class="radio--ifmd" name="babyMeal" id="babyMeal--label${status.index}" value="${babyMeal.mealId}">
										<label for="babyMeal--label${status.index}">${babyMeal.name}</label>
										<br>
									</c:forEach>
								</div>
								<div class="amount--count">
									<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountMinus(1)">remove</span>
									</div>
									<input type="text" class="seat--count--input" id="seat--count--input1" name="amount1" value="0" readonly="readonly" style="width: 50px;">
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountPlus(1)">add</span>
									</div>
								</div>
							</div>
							<div class="inFlightMeals--request--wrap">
								<div>
									<h5>야채식</h5>
								</div>
								<br>
								<div class="inflightService--wrap">
									<c:forEach var="veganMeal" items="${veganMeal}" varStatus="status">
										<input type="radio" class="radio--ifmd" name="veganMeal" id="veganMeal--label${status.index}" value="${veganMeal.mealId}">
										<label for="veganMeal--label${status.index}">${veganMeal.name}</label>
										<br>
									</c:forEach>
								</div>
								<div class="amount--count">
									<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountMinus(2)">remove</span>
									</div>
									<input type="text" class="seat--count--input" id="seat--count--input2" name="amount2" value="0" readonly="readonly" style="width: 50px;">
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountPlus(2)">add</span>
									</div>
								</div>
							</div>
							<div class="inFlightMeals--request--wrap">
								<div>
									<h5>식사 조절식</h5>
								</div>
								<br>
								<div class="inflightService--wrap">
									<c:forEach var="lowfatMeal" items="${lowfatMeal}" varStatus="status">
										<input type="radio" class="radio--ifmd" name="lowfatMeal" id="lowfatMeal--label${status.index}" value="${lowfatMeal.mealId}">
										<label for="lowfatMeal--label${status.index}">${lowfatMeal.name}</label>
										<br>
									</c:forEach>
								</div>
								<div class="amount--count">
									<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountMinus(3)">remove</span>
									</div>
									<input type="text" class="seat--count--input" id="seat--count--input3" name="amount3" value="0" readonly="readonly" style="width: 50px;">
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountPlus(3)">add</span>
									</div>
								</div>
							</div>
							<div class="inFlightMeals--request--wrap">
								<div>
									<h5>종교식</h5>
								</div>
								<br>
								<div class="inflightService--wrap">
									<c:forEach var="religionMeal" items="${religionMeal}" varStatus="status">
										<input type="radio" class="radio--ifmd" name="religionMeal" id="religionMeal--label${status.index}" value="${religionMeal.mealId}">
										<label for="religionMeal--label${status.index}">${religionMeal.name}</label>
										<br>
									</c:forEach>
								</div>
								<div class="amount--count">
									<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountMinus(4)">remove</span>
									</div>
									<input type="text" class="seat--count--input" id="seat--count--input4" name="amount4" value="0" readonly="readonly" style="width: 50px;">
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountPlus(4)">add</span>
									</div>
								</div>
							</div>
							<div class="inFlightMeals--request--wrap">
								<div>
									<h5>기타 특별식</h5>
								</div>
								<br>
								<div class="inflightService--wrap">
									<c:forEach var="etcMeal" items="${etcMeal}" varStatus="status">
										<input type="radio" class="radio--ifmd" name="etcMeal" id="etcMeal--label${status.index}" value="${etcMeal.mealId}">
										<label for="etcMeal--label${status.index}">${etcMeal.name}</label>
										<br>
									</c:forEach>
								</div>
								<div class="amount--count">
									<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountMinus(5)">remove</span>
									</div>
									<input type="text" class="seat--count--input" id="seat--count--input5" name="amount5" value="0" readonly="readonly" style="width: 50px;">
									<div class="inflightSv--amount--wrap">
										<span class="material-symbols-outlined symbol" onclick="seatCountPlus(5)">add</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</main>

<script src="/js/inFlightServiceSpecial.js">
	
</script>

<input type="hidden" name="menuName" id="menuName" value="특별 기내식 신청">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>