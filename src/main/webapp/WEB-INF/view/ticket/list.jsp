<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<style>
.list--table th:nth-of-type(1) {
	width: 11%;
}

.list--table th:nth-of-type(2) {
	width: 8%;
}

.list--table th:nth-of-type(3) {
	width: 10%;
}

.list--table th:nth-of-type(4) {
	width: 30%;
}

.list--table th:nth-of-type(5) {
	width: 30%;
}
.list--table th:nth-of-type(6) {
	width: 11%;
}

.list--table tbody tr:hover {
	font-weight: 500;
	cursor: pointer;
}
</style>

<!-- 항공권 구매 내역 페이지 -->

<main class="d-flex flex-column">
	<h2 class="page--title">항공권 구매 내역</h2>
	<hr>
	<br>
	
	<c:choose>
		<c:when test="${ticketList.isEmpty()}">
			<p class="no--list--p">구매 내역이 존재하지 않습니다.</p>
		</c:when>
		<c:otherwise>
			<table class="list--table" border="1">
				<thead>
					<tr>
						<th>티켓번호</th>
						<th>항공편</th>
						<th>좌석등급</th>
						<th>출발</th>
						<th>도착</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ticketList}" var="ticket">
						<tr id="tr${ticket.id}">
							<td>${ticket.id}</td>
							<td>${ticket.airplaneName}</td>
							<td>${ticket.seatGrade}석</td>
							<td>${ticket.departure} <span style="color: #575757">ㅣ</span> ${ticket.formatDepartureDate2()}</td>
							<td>${ticket.destination} <span style="color: #575757">ㅣ</span> ${ticket.formatArrivalDate()}</td>
							<td>
								<c:choose>
									<c:when test="${ticket.status == 2}">
										<span style="font-weight: 500; color: #c6c6c6;">환불처리</span>
									</c:when>
									<c:when test="${ticket.status == 1}">
										<span style="font-weight: 500; color: #436195;">결제완료</span>
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${pageCount != null}">
				<ul class="page--list">
					<c:forEach var="i" begin="1" end="${pageCount}" step="1">
						<c:choose>
							<c:when test="${i == page}">
								<li><a href="/ticket/list/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
							</c:when>
							<c:otherwise>
								<li><a href="/ticket/list/${i}">${i}</a>									
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
			</c:if>
		</c:otherwise>
	</c:choose>

</main>

<script>
	$(document).ready(function() {
		$(".list--table tbody tr").on("click", function() {
			let id = $(this).attr("id").split("tr")[1];
			
			location.href="/ticket/detail/" + id;
			
		});
	});
</script>

<input type="hidden" name="menuName" id="menuName" value="항공권 구매 내역">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
