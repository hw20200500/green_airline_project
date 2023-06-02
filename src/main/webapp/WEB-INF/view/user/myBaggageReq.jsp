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
		<h1>위탁 수하물 신청 내역</h1>
		<div>
			<div>좌석 등급 | 출발지 -> 도착지 | 출발 날짜 | 수하물 개수</div>

			<c:choose>
				<c:when test="${baggageReqResponses.size() != 0 }">
					<c:forEach var="baggageReqResponses" items="${baggageReqResponses}">
						<c:if test="${baggageReqResponses.amount != 0}">
							<div>${baggageReqResponses.seatGradeName}
								| ${baggageReqResponses.departure} -> ${baggageReqResponses.destination} |
								<%-- 출발 날짜 가져오기 !! ${.departureDateFormat()} --%>
								| ${baggageReqResponses.amount}
								<button type="button" class="btn btn-danger" onclick="deleteBtn(${baggageReqResponses.baggageId})">신청 취소</button>
							</div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>신청 내역이 없습니다.</p>
				</c:otherwise>
			</c:choose>

			<a class="btn btn-primary" href="/baggage/checkedBaggage">위탁 수하물 신청 페이지로 이동</a>

		</div>
	</div>
</main>
<script src="/js/myReqBaggage.js"></script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>