<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style></style>

<div>
	<main>
		<h2>특별 기내식</h2>
		<input type="hidden" name="memberId" value="memberId">
	
		<div>
			<div>항목 선택</div>
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

		<div id="inFlightMeals--detail">
			<c:forEach var="inFlightMeals" items="${inFlightMeals}">
				<span>${inFlightMeals.ifmdName}</span>
				<p>${inFlightMeals.ifmdDescription}</p>
			</c:forEach>

		</div>

		<div>
			<button type="button" id="inFlightMeals--request--btn" class="btn btn-primary" data-toggle="modal" data-target="#special--meal--req">특별 기내식 신청</button>
		</div>

		<!-- The Modal -->
		<div class="modal" id="special--meal--req">
			<input type="hidden" id="isLogin--check" value="${isLogin}">		
			<div class="modal-dialog">
				<div class="modal-content">
					<form action="/inFlightService/specialMealReq" method="post">
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
												<option value="${inFlightServiceResponseDtos.departureDateFormat()}" id="arrival--option">${inFlightServiceResponseDtos.departureDateFormat()}</option>
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