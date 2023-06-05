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
table{
	width: 1200px;
	text-align: center;
	border: 1px solid #ccc;
	margin-top: 30px;
}

table tr th, table tr td {
	padding: 5px;
}
</style>
<main>
	<div>
		<h2>특별 기내식 신청 내역 조회</h2>
		<hr>

		<table border="1">
			<tr style="background-color:#E5EFF3;">
				<th>예약자</th>
				<th>티켓번호</th>
				<th>출발지</th>
				<th>도착지</th>
				<th>출발일자</th>
				<th>신청 수량</th>
				<th>신청 특별 기내식 종류</th>
			</tr>

			<c:forEach var="inFlightMealResonseDtos" items="${inFlightMealResonseDtos}">
				<tr>
					<td>${inFlightMealResonseDtos.memberId}</td>
					<td>${inFlightMealResonseDtos.ticketId}</td>
					<td>${inFlightMealResonseDtos.departure}</td>
					<td>${inFlightMealResonseDtos.destination}</td>
					<td>${inFlightMealResonseDtos.departureDateFormat()}</td>
					<td>${inFlightMealResonseDtos.amount}개</td>
					<td>${inFlightMealResonseDtos.name}</td>
				</tr>
			</c:forEach>
		</table>

	</div>
</main>


<input type="hidden" name="menuName" id="menuName" value="항공서비스">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>