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
	.service--ul {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		cursor: pointer;
		padding: 15px 25px;
		border-radius: 10px;
		box-shadow: 0 0 3px 3px #ebebeb;
	}
	
	.service--ul:hover {
		background-color: #eee
	}
	
	.service--ul span {
		font-size: 70px;
		color: #657788;
	}
	
	.service--ul span:hover {
		color: #657788;
	}
	
	.service--ul li:last-of-type {
		font-size: 23px;
		font-weight: 600;
		color: #475462;
		margin-top: 5px;
	}
</style>


<!-- 항공 서비스 메인 페이지 -->

<main>
	<h2>항공권 관련 내역 조회</h2>
	<hr>
	<br>
	<div class = "d-flex justify-content-around align-items-end" style="height: 280px; padding: 0 20px">
		<ul class="service--ul" onclick="location.href='/manager/scheduleList'">
			<li><span class="material-symbols-outlined">flight</span>
			<li>운항 스케줄 목록
		</ul>
		<ul class="service--ul" onclick="location.href='/manager/ticketList/1'">
			<li><span class="material-symbols-outlined">airplane_ticket</span>
			<li>항공권 구매 내역
		</ul>
		<ul class="service--ul" onclick="location.href='#'">
			<li><span class="material-symbols-outlined">restaurant</span>
			<li>기내식 신청 내역
		</ul>
		<ul class="service--ul" onclick="location.href='#'">
			<li><span class="material-symbols-outlined">luggage</span>
			<li>수하물 신청 내역
		</ul>
	</div>

</main>



<input type="hidden" name="menuName" id="menuName" value="항공서비스">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
