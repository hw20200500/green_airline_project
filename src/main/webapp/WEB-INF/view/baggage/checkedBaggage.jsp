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
.checkedBaggage--title--wrap {
	display: flex;
}

.checkedBaggage--ul {
	display: flex;
	justify-content: space-between;
}

.checkedBaggage--ul li {
	display: flex;
}

.checkedBaggage--ul li a {
	display: block;
	display: flex;
	background-color: white;
	width: 590px;
	height: 70px;
	border: 1px solid #ebebeb;
	justify-content: center;
	align-items: center;
	font-size: 23px;
}

/* .checkedBaggage--ul li a:hover {
	background-color: #8abbe1;
	color: white;
} */

.checkedBaggage--content--wrap {
	margin-top: 20px;
}

.checkedBaggage--select--all--class {
	border: 1px solid #ebebeb;
	padding: 30px;
	display: flex;
	flex-direction: column;
	margin-bottom: 20px;
}

.checkedBaggage--select--class {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.checkedBaggage--select--class p {
	margin-right: 330px;
	font-size: 15px;
	color: #767676;
}

#free--baggage--id {
	border: none;
	border-bottom: 1px solid black;
	padding-bottom: 10px;
	width: 400px;
	font-size: 22px;
}

table {
	width: 1180px;
	border-left: none;
	border-right: none;
	margin-bottom: 20px;
}

table tr th, table tr td {
	text-align: center;
	padding: 10px;
	border: 1px solid #ebebeb;
}

.checkedBaggage--notice--class {
	background-color: #f8f9fc;
	padding: 20px;
	margin-bottom: 20px;
}

.checkedBaggage--notice--ul {
	font-size: 15px;
}

.checkedBaggage--notice--ul li {
	list-style: disc;
	margin-left: 20px;
}

.none--btn--primary{
	color: white;
	border: none;
	background-color: #c0c0c0;
}
.none--btn--primary:hover{
	color: white;
	border: none;
	background-color: #c0c0c0;
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
	margin-top: 15px;
	display: flex;
	justify-content: center;
	margin-bottom: 15px;
}

.inflightSv--amount--wrap {
	display: flex;
	align-items: center;
	height: 29px;
	cursor: pointer;
}

#modal--id--departuredate {
	border: none;
	border-bottom: 1px solid #ebebeb;
	background: #f8f9fc;
	padding: 10px;
	width: 430px;
}

.checkedBaggage-modal--select {
	display: flex;
	justify-content: center;
}

#seat--count--input {
	display: flex;
	justify-content: space-evenly;
}

.checkedBaggage--modal--marginBottom {
	margin-bottom: 10px;
}

p {
	font-size: 15px;
}

.modal-body{
	padding: 5px;
}
</style>

<main>
	<div>
		<div>
			<h2 class="page--title" style="margin-bottom: 30px;">수하물 이용 안내</h2>
			<p class="page--title--description">수하물은 고객이 여행 시 휴대 또는 탁송을 의뢰한 소지품 및 물품을 의미하는 단어입니다.<br> 짐을 준비하시는 고객님의 여행이 한결 편할 수 있도록 꼭 알아두셔야 하는 수하물 관련 정보를 안내합니다.</p>
			<hr>
			<br>
		</div>

		<div class="checkedBaggage--title--wrap">
			<ul class="checkedBaggage--ul">
				<li><a href="/baggage/checkedBaggage" style="background-color: #8ABBE2; color: white;" id="left--li">수하물 규정</a></li>
				<li><a href="/baggage/transitBaggage" id="right--li">환승 수하물</a></li>
			</ul>
		</div>

		<div class="checkedBaggage--content--wrap">
			<h4 style="color:#174481">무료 위탁 수하물</h4>
			<p>탑승 여정에 맞는 무료 수하물 허용량을 조회해 보세요.</p>
		</div>

		<div class="checkedBaggage--select--all--class">
			<div class="checkedBaggage--select--class">
				<p>구간 선택</p>
				<select id="free--baggage--id" name="section">
					<c:forEach var="baggage" items="${baggage}">
						<option value="${baggage.section}">${baggage.section}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="free--baggage--description--class">
			<table border="1">
				<tr style="background-color: #f8f9fc">
					<th style="border-left: none;">좌석 등급</th>
					<th style="border-right: none;">무료 수하물 허용량</th>
				</tr>
				<c:forEach var="checkedBaggages" items="${checkedBaggages}" varStatus="status">
					<tr class="checkedBaggages--all--class${status.index} checkedBaggages--empty--class">
						<td class="checkedBaggages--gradeId--class" style="border-left: none;">${checkedBaggages.gradeId}</td>
						<td class="checkedBaggages--freeAllowance--class" style="border-right: none;">${checkedBaggages.freeAllowance}</td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<div class="checkedBaggage--notice--class">
			<h5>유의사항</h5>
			<ul class="checkedBaggage--notice--ul">
				<li>조회 결과는 조회 구간에 대한 일반 규정으로, 경유지가 포함되어 있을 수 있으며 실제 운항 여부는 확인이 필요합니다.</li>
				<li>이 정보는 참고용으로 공항에서 지불시 제시되는 금액입니다.</li>
				<li>위탁수하물 개수가 <b>1인당 4개</b>를 초과할 경우 또는 다구간 여정일 경우 그린항공 서비스센터로 문의하여 주시기 바랍니다.<br> (추가 위탁 가능한 수하물 개수는 항공기의 운항 상황에 따라 제한될 수 있습니다.)
				</li>
				<li>개수/무게/사이즈 초과에 부과되는 요금은 수하물 각각에 부과됩니다.</li>
				<li>사이즈 초과를 지정하지 않은 경우, 158cm 이내(가로+세로+높이) 사이즈 기준으로 요금이 제공됩니다.</li>
			</ul>
		</div>

		<div>
			<button type="button" id="checkedBaggage--request--btn" class="btn btn--primary" data-toggle="modal" data-target="#baggage--req">위탁 수하물 신청</button>
			<button type="button" class="btn none--btn--primary" onclick="location.href='/baggage/limit'">운송 제한 물품</button>
		</div>

		<div>
			<c:if test="${inFlightServiceResponseDtos.size() != 0}">
				<!-- The Modal -->
				<div class="modal" id="baggage--req">
					<div class="modal-dialog">
						<div class="modal-content">
							<!-- Modal Header -->
							<div class="modal-header">
								<div>
									<h4 class="modal-title">위탁 수하물 신청</h4>
								</div>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">
								<div>
									<div>
										<h4 style="margin-left: 25px; padding-top: 10px;">출발 일정</h4>
									</div>
									<div class="checkedBaggage-modal--select">
										<select name="ticketId" id="modal--id--departuredate">
											<c:forEach var="inFlightServiceResponseDtos" items="${inFlightServiceResponseDtos}" varStatus="status">
												<option value="${inFlightServiceResponseDtos.ticketId}" id="arrival--option">${inFlightServiceResponseDtos.ticketId}
													${inFlightServiceResponseDtos.departure}→${inFlightServiceResponseDtos.destination} ${inFlightServiceResponseDtos.departureDateFormat()}</option>
											</c:forEach>
										</select>
									</div>
								</div>

								<div>
									<div class="amount--count">
										<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
										<div class="inflightSv--amount--wrap">
											<span class="material-symbols-outlined symbol" onclick="seatCountMinus()">remove</span>
										</div>
										<input type="text" name="amount" min="1" id="seat--count--input" max="${inFlightServiceResponseDtos.get(0).seatCount*4}" value="0" readonly="readonly"
											style="width: 50px; border: none; text-align: center;">
										<div class="inflightSv--amount--wrap">
											<span class="material-symbols-outlined symbol" onclick="seatCountPlus()">add</span>
										</div>
									</div>
								</div>
								<div class="checkedBaggage--modal--marginBottom">
									<div style="margin-left: 25px;">
										개수 <b>1인당 최대 4개</b>
									</div>
									<div style="margin-left: 25px;">*현장에서 추가 무게 발생시 추가 요금 발생합니다.</div>
								</div>
								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn--primary" id="submit--btn">신청</button>
									<button type="button" class="btn btn--danger modal_close" data-dismiss="modal">취소</button>
								</div>
							</div>

						</div>
					</div>
				</div>
			</c:if>
		</div>
		<script src="/js/checkedBaggage.js"></script>
	</div>
</main>

<input type="hidden" name="menuName" id="menuName" value="위탁 수하물 신청">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>