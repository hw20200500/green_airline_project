<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/payment.css">

<script>
	$(document).ready(function() {
		if ($(".destination--departure").width() > $(".info--ul").eq(0).width()) {
			$(".split--div").css("width", $(".destination--departure").width() + 30)
		} else {
			$(".split--div").css("width", $(".info--ul").eq(0).width() + 30)
		}
		
		if
		
	});
</script>

<style>
	.split--div {
		height: 3px;
		width: 100%;
		background-color: #c6dde5;
		margin: 5px 0 20px;
	}
	
	.info--ul {
		display: flex;
		justify-content: space-between;
		width: 100%;
	}
	
	.info--ul li {
		font-size: 17px;
	}
	
	.info--ul li:first-of-type {
		color: #3f5f8d;
	}
	
	.info--ul li {
		font-weight: 500;
		color: #585858;
	}

	.info--div {
		display: flex;
		align-items: center;
		flex-direction: column;
		padding: 20px;
	}

</style>


<!-- 결제 완료 페이지 -->

<main class="d-flex flex-column">
	<h2>항공권 예약</h2>
	<hr>
	<br>
	<div class="d-flex align-items-center flex-column" style="width: 100%;">
		<h5>예약이 완료되었습니다.</h5>
		<br>
		<div class="info--div">
			<div class="split--div"></div>
			<ul class="info--ul">
				<li style="font-size: 30px;">
				<li class="material-symbols-outlined" style="margin-bottom: 11px;">
					<c:choose>
						<c:when test="${ticketList.size() == 2}">
							sync_alt				
						</c:when>
						<c:otherwise>
							trending_flat
						</c:otherwise>
					</c:choose>
				<li>${ticketList.get(0).departure}&nbsp;
					<span></span>
					&nbsp;${ticketList.get(0).destination}
			</ul>
			
			<div class="d-flex flex-column align-items-center" style="width: 370px">
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
				
				<br>
				
				<ul class="info--ul">
					<li>결제 번호
					<li>${ticketList.get(0).tid}
				</ul>
				
				<ul class="info--ul">
					 <li>결제 금액
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

	</div>
	

</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
