<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<!-- 결제 완료 페이지 -->

<main class="d-flex flex-column">
	<h2>항공권 예약</h2>
	<hr>
	<br>
	<div class="d-flex justify-content-center" style="width: 100%;">
		결제 완료
		<br>
		
		<div>
			티켓 정보
			<br>
		<c:choose>
			<%-- 왕복인 경우 --%>
			<c:when test="${ticketList.size() == 2}">
				tid : ${payment.tid}
				<br>
				ticketId1 : ${payment.ticketId1}
				<br>
				ticketId2 : ${payment.ticketId2}
				<br>
				amount1 : ${payment.amount1}
				<br>
				amount2 : ${payment.amount2}
				<br>
				status1 : ${payment.status1}
				<br>
				status2 : ${payment.status2}
			</c:when>
			<%-- 편도인 경우 --%>
			<c:otherwise>
			
			</c:otherwise>
		</c:choose>
		</div>
		
		<div>
			 결제 정보
			 <br>
			 결제 번호 : ${ticketList.get(0).tid}
			 <br>
			 결제 금액 : 
			 <c:choose>
			 	<c:when test="${ticketList.size() == 2}">
					 ${ticketList.get(0).amount + ticketList.get(1).amount}
			 	</c:when>
			 	<c:otherwise>
					 ${ticketList.get(0).amount}
			 	</c:otherwise>
			 </c:choose>
			 
		</div>
		


	</div>
	

</main>



<script src="/js/payment.js"></script>
<script src="/js/ticket.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
