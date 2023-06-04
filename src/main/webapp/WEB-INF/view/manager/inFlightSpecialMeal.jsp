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
	.inRequest--wrap{
		display: flex;
	}
</style>
<main>
	<div>
		<h2>특별 기내식 신청 내역 조회</h2>
		
		<c:forEach var="inFlightMealResonseDtos" items="${inFlightMealResonseDtos}">
			<div class="inRequest--wrap">
				<div>${inFlightMealResonseDtos.memberId}</div>
				<div>${inFlightMealResonseDtos.ticketId}</div>
				<div>${inFlightMealResonseDtos.departureDateFormat()}</div>
				<div>${inFlightMealResonseDtos.destination}</div>
				<div>${inFlightMealResonseDtos.seatCount}</div>
				<div>${inFlightMealResonseDtos.amount}</div>
				<div>${inFlightMealResonseDtos.name}</div>
			</div>
		</c:forEach>
	</div>
</main>


<input type="hidden" name="menuName" id="menuName" value="항공서비스">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>