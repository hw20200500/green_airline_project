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
.baggageRequest--wrap {
	display: flex;
}
</style>

<main>
	<div>
		<h2>위탁 수하물 신청 내역 조회</h2>

		<c:forEach var="inFlightMealResponseDtos" items="${inFlightMealResponseDtos}">
			<div class="baggageRequest--wrap">
				<div>${inFlightMealResponseDtos.memberId}</div>
				<div>${inFlightMealResponseDtos.ticketId}</div>
				<div>${inFlightMealResponseDtos.departureDateFormat()}</div>
				<div>${inFlightMealResponseDtos.destination}</div>
				<div>${inFlightMealResponseDtos.seatCount}</div>
				<div>${inFlightMealResponseDtos.seatGradeName}</div>
				<div>${inFlightMealResponseDtos.amount}</div>
			</div>
		</c:forEach>
	</div>
</main>


<input type="hidden" name="menuName" id="menuName" value="항공서비스">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>