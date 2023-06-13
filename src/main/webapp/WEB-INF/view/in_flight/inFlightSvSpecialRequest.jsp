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
	padding: 10px;
	width: 600px;
	border-bottom: 1px solid #ddd;
	margin-bottom: 20px;
	display: flex;
	background-color: #f8f9fc;
	font-size: 22px;
}

input[type=text]:focus {
	outline: none;
}

input[type=text] {
	text-align: center;
	border: none;
}

.btn--primary {
	color: white;
	border: none;
	background-color: #8ABBE2;
}

.btn--primary:hover {
	color: white;
	border: none;
	background-color: #8ABBE2;
}

.btn--danger {
	color: white;
	border: none;
	background-color: #DC6093;
}

.btn--danger:hover {
	color: white;
	border: none;
	background-color: #DC6093;
}

#free--baggage--id:focus {
	outline: none;
}

.checkedBaggage--background {
	background-color: #8ABBE2;
}

.amount--count {
	display: flex;
	justify-content: space-evenly;
}

.inFlightSvSpecial--one--wrap {
	background-color: #f8f9fc;
	padding: 20px;
	display: flex;
	flex-direction: column;
	width: 400px;
	height: 310px;
}

table {
	width: 1180px;
	border: none;
}

table tr th {
	text-align: center;
}

#inFlight--arrival {
	margin-top: 30px;
	display: flex;
	text-align: center;
	justify-content: center;
	flex-direction: column;
}

.inFlightSv--selectBox--wrap {
	display: flex;
	justify-content: center;
	margin-bottom: 40px;
}

table tr th, table tr td {
	padding: 10px;
}

table tr th {
	background-color: #f8f9fc;
}

.inflightSv--amount--wrap {
	display: flex;
	align-items: center;
	height: 29px;
	cursor: pointer;
}

#amount--count {
	display: flex;
	justify-content: center;
}

.btn--primary {
	margin-top: 15px;
	color: white;
	border: none;
	background-color: #8ABBE2;
	width: 136px;
	height: 40px;
	border-radius: 5px;
}

.btn--primary:hover {
	color: white;
	border: none;
	background-color: #8ABBE2;
	height: 40px;
	border-radius: 5px;
}

.page--move{
	color: white;
	border: none;
	background-color: #c0c0c0;
	width: 200px;
	height: 40px;
	border-radius: 5px;
}
</style>

<main>

	<div>
		<h2 class="page--title">특별 기내식 신청</h2>
		<p class="page--title--description">특별 기내식을 신청하지 않으시면 기본 기내식이 제공됩니다.</p>
		<hr>
		<br>

		<div id="inFlight--arrival">
			<div>
				<h3 style="margin-bottom: 10px;">출발 일정</h3>
			</div>
			<div class="inFlightSv--selectBox--wrap">
				<!-- db 안에 들어있는 departureDate는 format 전의 값이니까 2023/05/18 -> 2023년05월18일 -->
				<select name="modal--name--arrivaldate" id="modal--id--arrivaldate">
					<c:forEach var="inFlightServiceResponseDtos" items="${inFlightServiceResponseDtos}">
						<option value="${inFlightServiceResponseDtos.ticketId}_${inFlightServiceResponseDtos.seatCount}" id="arrival--option">${inFlightServiceResponseDtos.ticketId} ㅣ ${inFlightServiceResponseDtos.departure}→${inFlightServiceResponseDtos.destination}
							${inFlightServiceResponseDtos.departureDateFormat()}</option>
					</c:forEach>
				</select> <br>
			</div>
		</div>

		<form action="#">
			<table border="1">
				<tr>
					<th>특별 기내식 종류</th>
					<th>특별 기내식 상세</th>
					<th>수량</th>
				</tr>

				<tr>
					<td style="text-align: center;">유아식 및 아동식</td>
					<td><c:forEach var="babyMeal" items="${babyMeal}" varStatus="status">
							<input type="radio" class="radio--ifmd" name="babyMeal" id="babyMeal--label${status.index}" value="${babyMeal.id}">
							<label for="babyMeal--label${status.index}">${babyMeal.name}</label>
							<br>
						</c:forEach></td>
					<td>
						<div id="amount--count">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountMinus(1)">remove</span>
							</div>
							<input type="text" class="seat--count--input" id="seat--count--input1" name="amount1" value="0" readonly="readonly" style="width: 50px;">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountPlus(1)">add</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">야채식</td>
					<td><c:forEach var="veganMeal" items="${veganMeal}" varStatus="status">
							<input type="radio" class="radio--ifmd" name="veganMeal" id="veganMeal--label${status.index}" value="${veganMeal.id}">
							<label for="veganMeal--label${status.index}">${veganMeal.name}</label>
							<br>
						</c:forEach></td>
					<td>
						<div id="amount--count">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountMinus(2)">remove</span>
							</div>
							<input type="text" class="seat--count--input" id="seat--count--input2" name="amount2" value="0" readonly="readonly" style="width: 50px;">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountPlus(2)">add</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">식사 조절식</td>
					<td><c:forEach var="lowfatMeal" items="${lowfatMeal}" varStatus="status">
							<input type="radio" class="radio--ifmd" name="lowfatMeal" id="lowfatMeal--label${status.index}" value="${lowfatMeal.id}">
							<label for="lowfatMeal--label${status.index}">${lowfatMeal.name}</label>
							<br>
						</c:forEach></td>
					<td>
						<div id="amount--count">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountMinus(3)">remove</span>
							</div>
							<input type="text" class="seat--count--input" id="seat--count--input3" name="amount3" value="0" readonly="readonly" style="width: 50px;">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountPlus(3)">add</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">종교식</td>
					<td><c:forEach var="religionMeal" items="${religionMeal}" varStatus="status">
							<input type="radio" class="radio--ifmd" name="religionMeal" id="religionMeal--label${status.index}" value="${religionMeal.id}">
							<label for="religionMeal--label${status.index}">${religionMeal.name}</label>
							<br>
						</c:forEach></td>
					<td>
						<div id="amount--count">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountMinus(4)">remove</span>
							</div>
							<input type="text" class="seat--count--input" id="seat--count--input4" name="amount4" value="0" readonly="readonly" style="width: 50px;">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountPlus(4)">add</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">기타 특별식</td>
					<td><c:forEach var="etcMeal" items="${etcMeal}" varStatus="status">
							<input type="radio" class="radio--ifmd" name="etcMeal" id="etcMeal--label${status.index}" value="${etcMeal.id}">
							<label for="etcMeal--label${status.index}">${etcMeal.name}</label>
							<br>
						</c:forEach></td>
					<td>
						<div id="amount--count">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountMinus(5)">remove</span>
							</div>
							<input type="text" class="seat--count--input" id="seat--count--input5" name="amount5" value="0" readonly="readonly" style="width: 50px;">
							<div class="inflightSv--amount--wrap">
								<span class="material-symbols-outlined symbol" onclick="seatCountPlus(5)">add</span>
							</div>
						</div>
					</td>
				</tr>
			</table>
			
			<div>
				<button type="button" id="inflightmeal--request" class="btn--primary">신청 완료</button>
				<button type="button" onclick="location.href='/inFlightService/inFlightServiceSpecial'" class="page--move">특별 기내식 페이지</button>
			</div>
		</form>
	</div>
</main>

<script src="/js/inFlightServiceSpecial.js">
	
</script>

<input type="hidden" name="menuName" id="menuName" value="특별 기내식 신청">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>