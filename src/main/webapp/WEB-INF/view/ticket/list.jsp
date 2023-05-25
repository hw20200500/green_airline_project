<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

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

.complete--payment:hover {
	font-weight: 500;
	cursor: pointer;
}
</style>

<script>
	$(document).ready(function() {
		$(".complete--payment").on("click", function() {
			let id = $(this).attr("id").split("tr")[1];
			
			location.href="/ticket/detail/" + id;
			
		});
	});
</script>

<!-- 항공권 구매 내역 페이지 -->

<main class="d-flex flex-column">
	<h2>항공권 구매 내역</h2>
	<hr>
	<br>
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
								<span style="font-weight: 500; color: #c6c6c6;">환불</span>
							</c:when>
							<c:when test="${ticket.status == 1}">
								<span style="font-weight: 500; color: #436195;">결제완료</span>
							</c:when>
						</c:choose>
					</td>
				</tr>
				<script>
					var target = "#tr" + `${ticket.id}`;
					if ($(target).children().eq(5).text().trim() == '결제완료') {
						$(target).addClass("complete--payment");
					}
				</script>
			</c:forEach>
		</tbody>
	</table>

</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
