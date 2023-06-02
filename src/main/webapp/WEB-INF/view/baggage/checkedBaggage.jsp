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

<main>
	<div>
		<div>

			<%-- 위탁 수하물 레이아웃 만들기 --%>
			<h1>위탁 수하물 안내</h1>
			<p>항공사에 맡기는 각종 수하물의 크기, 요금, 준비 방법 등에 대한 정보를 안내해 드립니다.</p>
		</div>

		<div>
			<button type="button" onclick="location.href='/baggage/checkedBaggage'" class="btn btn-primary">수하물 규정</button>
			<button type="button" onclick="location.href='/baggage/transitBaggage'" class="btn btn-primary">환승 수하물</button>
		</div>

		<div>
			<h3>무료 위탁 수하물</h3>
			<p>탑승 여정에 맞는 무료 수하물 허용량을 조회해 보세요.</p>
		</div>

		<div>
			<select id="free--baggage--id" name="section">
				<c:forEach var="baggage" items="${baggage}">
					<option value="${baggage.section}">${baggage.section}</option>
				</c:forEach>
			</select>
		</div>

		<div class="free--baggage--description--class">
			<table border="1">
				<tr>
					<td>좌석 등급</td>
					<td>무료 수하물 허용량</td>
				</tr>
				<c:forEach var="checkedBaggages" items="${checkedBaggages}" varStatus="status">
					<tr class="checkedBaggages--all--class${status.index} checkedBaggages--empty--class">
						<td class="checkedBaggages--gradeId--class">${checkedBaggages.gradeId}</td>
						<td class="checkedBaggages--freeAllowance--class">${checkedBaggages.freeAllowance}</td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<div>
			<h3>유의사항</h3>
			<ul>
				<li>조회 결과는 조회 구간에 대한 일반 규정으로, 경유지가 포함되어 있을 수 있으며 실제 운항 여부는 확인이 필요합니다.</li>
				<li>이 정보는 참고용으로 공항에서 지불시 제시되는 금액입니다.</li>
				<li>위탁수하물 개수가 <b>1인당 4개</b>를 초과할 경우 또는 다구간 여정일 경우 그린항공 서비스센터로 문의하여 주시기 바랍니다.<br> (추가 위탁 가능한 수하물 개수는 항공기의 운항 상황에 따라 제한될 수 있습니다.)
				</li>
				<li>개수/무게/사이즈 초과에 부과되는 요금은 수하물 각각에 부과됩니다.</li>
				<li>사이즈 초과를 지정하지 않은 경우, 158cm 이내(가로+세로+높이) 사이즈 기준으로 요금이 제공됩니다.</li>
			</ul>
		</div>

		<div>
			<button type="button" id="checkedBaggage--request--btn" class="btn btn-primary" data-toggle="modal" data-target="#baggage--req">위탁 수하물 신청</button>
		</div>

		<div>
			<!-- The Modal -->
			<div class="modal" id="baggage--req">
				<input type="hidden" id="isLogin--check" value="${isLogin}">
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
								<div>예약 노선 보여주기</div>
								<div class="">
									<select>
										<c:forEach var="baggageGroupBySection" items="${baggageGroupBySection}">
											<option value="${baggageGroupBySection.section}">${baggageGroupBySection.section}
										</c:forEach>
									</select> <br> <select name="modal--name--arrivaldate" id="modal--id--departuredate">
										<c:forEach var="inFlightServiceResponseDtos" items="${inFlightServiceResponseDtos}" varStatus="status">
											<option value="${inFlightServiceResponseDtos.departureDateFormat()}" id="arrival--option">${baggageReqResponses.get(status.index).seatGradeName}|
												${inFlightServiceResponseDtos.departure}→${inFlightServiceResponseDtos.destination} ${inFlightServiceResponseDtos.departureDateFormat()}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<form action="/baggage/checkedBaggageProc" method="post">
								<div>
									<div>개수 *1인당 최대 4개</div>
									<div class="">
										 <input type="number" name="amount" min="1" id="seat--count--input" max="${inFlightServiceResponseDtos.get(0).seatCount * 4}">
									</div>
								</div>
								<div>*현장에서 추가 무게 발생시 추가 요금 발생합니다.</div>

								<div></div>
								<input type="hidden" name="brId"> <input type="hidden" name="memberId">
								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="submit" class="btn btn-primary">Submit</button>
									<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
								</div>
							</form>
						</div>

					</div>
				</div>
			</div>
		</div>
		<script src="/js/checkedBaggage.js"></script>
	</div>
</main>

<input type="hidden" name="menuName" id="menuName" value="수하물 안내">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>