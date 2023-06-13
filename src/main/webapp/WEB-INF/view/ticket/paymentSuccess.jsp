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

<link rel="stylesheet" href="/css/payment.css">

<!-- 결제 완료 페이지 -->

<main class="d-flex flex-column">
	<h2 class="page--title">항공권 예약</h2>
	<hr>
	<br>
	
	<div class="d-flex align-items-center flex-column" style="width: 100%;">
		<h3 class="reserve--complete">예약이 완료되었습니다.</h3>
		<div class="split--div"></div>
		<div class="info--div">
			<div class="d-flex flex-column align-items-center" style="width: 430px">
				<ul class="info--ul">
					<li>예약번호
					<c:choose>
						<%-- 왕복인 경우 --%>
						<c:when test="${ticketList.size() == 2}">
							<li>${ticketList.get(0).id} ㅣ ${ticketList.get(1).id}
						</c:when>
						<%-- 편도인 경우 --%>
						<c:otherwise>
							<li>${ticketList.get(0).id}
						</c:otherwise>
					</c:choose>
				</ul>
				
				<ul class="info--ul">
					<li>예약일자
					<li>${ticketList.get(0).formatReservedDate()}
				</ul>
				
				<ul class="info--ul">
					<li>노선
					<li>
						${ticketList.get(0).departure}&nbsp;
						<c:choose>
							<c:when test="${ticketList.size() == 2}">
								↔
							</c:when>
							<c:otherwise>
								→
							</c:otherwise>
						</c:choose>
						&nbsp;${ticketList.get(0).destination}
					</li>
				</ul>
				
				<ul class="info--ul">
					<li>일정
					<c:choose>
						<%-- 왕복인 경우 --%>
						<c:when test="${ticketList.size() == 2}">
							<li>${ticketList.get(0).formatDepartureDate()} ~ ${ticketList.get(1).formatDepartureDate()}
						</c:when>
						<%-- 편도인 경우 --%>
						<c:otherwise>
							<li>${ticketList.get(0).formatDepartureDate()}
						</c:otherwise>
					</c:choose>
				</ul>
			
				<ul class="info--ul">
					<li>승객
					<li>
						성인${ticketList.get(0).adultCount}
						<c:if test="${ticketList.get(0).childCount != 0}">
							&nbsp;소아${ticketList.get(0).childCount}
						</c:if>					
						<c:if test="${ticketList.get(0).infantCount != 0}">
							&nbsp;유아${ticketList.get(0).infantCount}
						</c:if>
					</li>
				</ul>
				
				<ul class="info--ul">
					<li>결제번호
					<li>${ticketList.get(0).tid}
				</ul>
				
				<ul class="info--ul">
					 <li>결제금액
					 <c:choose>
					 	<c:when test="${ticketList.size() == 2}">
							 <li><fmt:formatNumber value="${ticketList.get(0).amount + ticketList.get(1).amount}" pattern="#,###"/>원
					 	</c:when>
					 	<c:otherwise>
							 <li><fmt:formatNumber value="${ticketList.get(0).amount}" pattern="#,###"/>원
					 	</c:otherwise>
					 </c:choose>
				</ul>
	
			</div>
		</div>
		
		<button class="list--btn" onclick="location.href='/ticket/list/1';">
			<ul class="d-flex justify-content-center" style="margin: 0;">
				<li><span class="material-symbols-outlined" style="font-size: 23px; margin-right: 4px; margin-top: 2px;">inventory</span>
				<li style="font-size: 16px;">예약 내역 조회
			</ul>
		</button>

	</div>

</main>

<script>
	$(document).ready(function() {
		if ($(".destination--departure").width() > $(".info--ul").eq(0).width()) {
			$(".split--div").css("width", $(".destination--departure").width() + 30)
		} else {
			$(".split--div").css("width", $(".info--ul").eq(0).width() + 30)
		}
		
	});
</script>

<input type="hidden" name="menuName" id="menuName" value="항공권 예약">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
