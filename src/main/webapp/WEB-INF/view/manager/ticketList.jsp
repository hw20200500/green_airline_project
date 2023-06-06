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
	width: 10%;
}

.list--table th:nth-of-type(2) {
	width: 14%;
}

.list--table th:nth-of-type(3) {
	width: 18%;
}

.list--table th:nth-of-type(4) {
	width: 18%;
}

.list--table th:nth-of-type(5) {
	width: 15%;
}

.list--table th:nth-of-type(6) {
	width: 15%;
}

.list--table th:nth-of-type(7) {
	width: 10%;
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
						<th>예약자</th>
						<th>출발지</th>
						<th>도착지</th>
						<th>출발일자</th>
						<th>예약일자</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ticketList}" var="ticket">
						<tr id="tr${ticket.id}">
							<td>${ticket.id}</td>
							<td>${ticket.memberId}</td>
							<td>${ticket.departure}</td>
							<td>${ticket.destination}</td>
							<td>${ticket.formatDepartureDate2()}</td>
							<td>${ticket.formatReservedDate()}</td>
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
					<c:choose>
						<c:when test="${pageCount < 11}">
							<c:forEach var="i" begin="1" end="${pageCount}" step="1">
								<c:choose>
									<c:when test="${i == page}">
										<li><a href="/manager/ticketList/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
									</c:when>
									<c:otherwise>
										<li><a href="/manager/ticketList/${i}">${i}</a>									
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<%-- 페이지가 11개 이상이라면 --%>
						<c:otherwise>
							<c:choose>
								<c:when test="${page < 11}">
									<c:forEach var="i" begin="1" end="10" step="1">
										<c:choose>
											<c:when test="${i == page}">
												<li><a href="/manager/ticketList/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
											</c:when>
											<c:otherwise>
												<li><a href="/manager/ticketList/${i}">${i}</a>									
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<li><a href="/manager/ticketList/11">></a>		
								</c:when>
								<c:otherwise>
									<li><a href="/manager/ticketList/1"><</a>		
									<c:forEach var="i" begin="11" end="${pageCount}" step="1">
										<c:choose>
											<c:when test="${i == page}">
												<li><a href="/manager/ticketList/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
											</c:when>
											<c:otherwise>
												<li><a href="/manager/ticketList/${i}">${i}</a>									
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
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
