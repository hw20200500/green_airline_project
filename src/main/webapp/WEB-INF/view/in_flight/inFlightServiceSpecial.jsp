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
.inFlightMeals--option--wrap {
	display: flex;
	justify-content: center;
}

#inFlightMeals--option {
	width: 300px;
	height: 40px;
	border: none;
	border-bottom: 1px solid black;
	font-size: 20px;
	margin-bottom: 50px;
	margin-top: 30px;
	padding-bottom: 5px;
	text-align: center;
}

#inFlightMeals--image {
	display: flex;
	justify-content: center;
}

#inFlightMeals--description {
	display: flex;
	justify-content: center;
}

#inFlightMeals--description>span {
	width: 1000px;
	font-size: 1em;
	margin-bottom: 20px;
}

#inFlightMeals--details {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-bottom: 10px;
}

.detail--wrap {
	width: 1000px;
}

.inFlightMeals--btn--wrap {
	display: flex;
	justify-content: center;	
}

.inFlightMeals--btn--wrap > div{
	width: 1000px;
}
</style>

<div>
	<main>
		<h2>특별 기내식</h2>
		<hr>
		<input type="hidden" name="memberId" value="memberId">

		<div class="inFlightMeals--option--wrap">
			<select id="inFlightMeals--option">
				<c:forEach var="flightMeals" items="${flightMeals}" varStatus="status">
					<c:if test="${status.index>0}">
						<option value="${flightMeals.name}">${flightMeals.name}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>

		<div id="inFlightMeals--image">
			<img id="meals--image" src="/images/in_flight/${inFlightMeals.get(0).image}">
		</div>
		<div id="inFlightMeals--description">
			<span>${inFlightMeals.get(0).ifmName} : ${inFlightMeals.get(0).ifmDescription}</span>
		</div>

		<div id="inFlightMeals--details">
			<c:forEach var="inFlightMeals" items="${inFlightMeals}">
				<div class="detail--wrap">
					<span>${inFlightMeals.ifmdName}</span>
					<p>${inFlightMeals.ifmdDescription}</p>
				</div>
			</c:forEach>

		</div>

		<div class="inFlightMeals--btn--wrap">
			<div>
				<button type="button" id="inFlightMeals--request--btn" class="btn btn-primary" data-toggle="modal" data-target="#special--meal--req">특별 기내식 신청</button>
			</div>
		</div>

		<!-- The Modal -->
		<div class="modal" id="special--meal--req">
			<input type="hidden" id="isLogin--check" value="${isLogin}">
			<div class="modal-dialog">
				<div class="modal-content">
					<form>
						<!-- Modal Header -->
						<div class="modal-header">
							<div>
								<h4 class="modal-title">특별 기내식 신청</h4>
								<div>*특별 기내식을 신청하지 않으시면 기본 기내식이 제공됩니다.</div>
							</div>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div>
								<div>출발 일정</div>
								<div class="modal--div--arrivaldate">
									<div id="inFlight--arrival">
										<!-- db 안에 들어있는 departureDate는 format 전의 값이니까 2023/05/18 -> 2023년05월18일 -->
										<select name="modal--name--arrivaldate" id="modal--id--arrivaldate">
											<c:forEach var="inFlightServiceResponseDtos" items="${inFlightServiceResponseDtos}">
												<option value="${inFlightServiceResponseDtos.departureDateFormat()}" id="arrival--option">${inFlightServiceResponseDtos.departure}→ ${inFlightServiceResponseDtos.destination}
													${inFlightServiceResponseDtos.departureDateFormat()}</option>
											</c:forEach>
										</select> <br>
									</div>
								</div>
							</div>

							<div>
								<div>종류</div>
								<div class="modal--ifmdName">
									<div id="inFlightMeals--detail">
										<c:forEach var="inFlightMeals" items="${inFlightMeals}" varStatus="status">
											<input type="radio" class="radio--ifmd" name="ifmdName" id="ifmdName--label${status.index}" value="${inFlightMeals.ifmdName}">
											<label for="ifmdName--label${status.index}">${inFlightMeals.ifmdName}</label>
											<br>
										</c:forEach>
									</div>
								</div>
							</div>

							<div>
								<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
								수량 &nbsp;<input type="number" id="seat--count--input" name="amount" min="1" max="${inFlightServiceResponseDtos.get(0).seatCount}">
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" id="inflightmeal--request" class="btn btn-primary" data-dismiss="modal">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>

	<script src="/js/inFlightServiceSpecial.js">
		
	</script>

</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>