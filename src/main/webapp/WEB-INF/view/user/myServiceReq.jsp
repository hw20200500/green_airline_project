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
</style>
<main>
	<div>
		<h1>특별 기내식 신청 내역</h1>
		<div>
			<div>티켓 번호 | 출발지 -> 도착지 | 출발 날짜 | 특별 기내식 종류 | 수량</div>

			<c:choose>
				<c:when test="${specialMealResponseDtos.size() != 0}">
					<c:forEach var="specialMealResponseDtos" items="${specialMealResponseDtos}">
						<form action="/inFlightService/myReqServiceDelete?id=${specialMealResponseDtos.rmId}" method="post">
							<input type="hidden" name="id" value="${specialMealResponseDtos.rmId}">
							<div>
								${specialMealResponseDtos.ticketId} ${specialMealResponseDtos.departure} -> ${specialMealResponseDtos.destination} ${specialMealResponseDtos.departureDateFormat()}
								${specialMealResponseDtos.ifmName} ${specialMealResponseDtos.rmAmount} 개
								<button type="submit" class="btn btn-danger">신청 취소</button>
							</div>
						</form>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<p>신청한 내역이 없습니다.</p>
				</c:otherwise>
			</c:choose>

			<a class="btn btn-primary" href="/inFlightService/inFlightServiceSpecial">특별 기내식 신청 페이지로 이동</a>

		</div>

	</div>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>