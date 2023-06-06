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

<link rel="stylesheet" href="/css/manager.css">


<!-- 항공 서비스 메인 페이지 -->

<main>
	<h2 class="page--title">항공 서비스</h2>
	<hr>
	<br>
	
	<div class="service--div">
		<ul class="service--ul" onclick="location.href='/manager/scheduleList'">
			<li><span class="material-symbols-outlined">flight</span>
			<li>운항 스케줄 목록
		</ul>
		<ul class="service--ul" onclick="location.href='/manager/ticketList/1'">
			<li><span class="material-symbols-outlined">airplane_ticket</span>
			<li>항공권 구매 내역
		</ul>
		<ul class="service--ul" onclick="location.href='/manager/inFlightSpecialMeal'">
			<li><span class="material-symbols-outlined">restaurant</span>
			<li>기내식 신청 내역
		</ul>
		<ul class="service--ul" onclick="location.href='/manager/baggageRequest'">
			<li><span class="material-symbols-outlined">luggage</span>
			<li>수하물 신청 내역
		</ul>
	</div>

</main>



<input type="hidden" name="menuName" id="menuName" value="항공 서비스">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
