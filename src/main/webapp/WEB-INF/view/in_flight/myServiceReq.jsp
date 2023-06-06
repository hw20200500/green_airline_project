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
table {
	width: 1180px;
	border: none;
	text-align: center;
}

/* table > tbody > tr:nth-child(1){
	background-color: #f8f9fc;
} */
table tr th, table tr td {
	padding: 10px;
}

.btn--primary {
	border: none;
	background-color: #8ABBE2;
	color: white;
	margin-right: 10px;
}

.btn--primary:hover {
	border: none;
	background-color: #8ABBE2;
	color: white;
}

.myServiceReq--btn--wrap {
	margin-top: 30px;
}

.btn--danger {
	background-color: #c0c0c0;
	color: white;
}

.btn--danger:hover {
	background-color: #c0c0c0;
	color: white;
}
</style>
<main>
	<div>
		<h2 class="page--title">특별 기내식 신청 내역</h2>
		<hr>
		<br>

		<div>
			<table>

				<tr>
					<th>티켓 번호</th>
					<th>출발지 → 도착지</th>
					<th>출발 날짜</th>
					<th>신청 특별 기내식 종류</th>
					<th>수량</th>
				</tr>

				<c:choose>
					<c:when test="${specialMealResponseDtos.size() != 0}">
						<c:forEach var="specialMealResponseDtos" items="${specialMealResponseDtos}">
							<form action="/inFlightService/myReqServiceDelete?id=${specialMealResponseDtos.rmId}" method="post">
								<input type="hidden" name="id" value="${specialMealResponseDtos.rmId}">
								<tr>
									<td>${specialMealResponseDtos.ticketId}</td>
									<td>${specialMealResponseDtos.departure}->${specialMealResponseDtos.destination}</td>
									<td>${specialMealResponseDtos.departureDateFormat()}</td>
									<td>${specialMealResponseDtos.name}</td>
									<td>${specialMealResponseDtos.rmAmount}개</td>
									<td><button type="submit" class="btn btn--danger" onclick="confirm('정말 취소하시겠습니까?')">신청 취소</button></td>
								</tr>
							</form>
						</c:forEach>
					</c:when>

					<c:otherwise>
						<tr>
							<td><p>신청한 내역이 없습니다.</p></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>


			<div class="myServiceReq--btn--wrap">
				<a class="btn btn--primary" href="/inFlightService/inFlightSpecialReq">특별 기내식 신청 페이지로 이동</a>
			</div>

		</div>
	</div>
	<input type="hidden" name="menuName" id="menuName" value="특별 기내식 신청 내역">
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>