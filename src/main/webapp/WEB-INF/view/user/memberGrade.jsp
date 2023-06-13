<%@page import="com.green.airline.utils.Define"%>
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

<!-- 회원 등급 안내 -->

<style>
	.list--table td:first-of-type {
		width: 40%;
	}
	
	.list--table td:last-of-type {
		width: 60%;
	}
	
	.miles--description--p {
		text-align: left; 
		font-size: 14px; 
		color: gray; 
		margin-top: 5px; 
		margin-right: 30px;
	}
	
	.middle--title {
		margin-left: 0px;
	}
	
	.middle--title span:first-of-type {
		margin-right: 7px;
		font-size: 32px;
	}
</style>

<main class="d-flex flex-column">
	<h2 class="page--title">회원 안내</h2>
	<hr>
	<br>
		
	<div class="d-flex flex-column align-items-center" style="width: 100%;">
		<div style="width: 900px;">
			<h4 class="middle--title">
				<span class="material-symbols-outlined">stars</span>
				<span>회원 혜택</span>
			</h4>
			<table border="1" class="list--table">
				<thead>
					<tr>
						<th>회원 등급</th>
						<th>마일리지 적립 비율</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="memberGrade" items="${memberGradeList}">
						<tr>
							<td>${memberGrade.name}</td>
							<td>${memberGrade.mileageRate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p class="miles--description--p">
				적립된 마일리지의 유효기간은 10년입니다.
			</p>
			<br><br>
			<hr style="width: 1000px; margin-left: -50px;">
			<br><br>
			<h4 class="middle--title">
				<span class="material-symbols-outlined">airplane_ticket</span>
				<span>회원 승급 기준</span>
			</h4>
			<table border="1" class="list--table">
				<thead>
					<tr>
						<th>회원 등급</th>
						<th>승급 기준</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="memberGrade" items="${memberGradeList}">
						<c:if test="${memberGrade.rankUpMileage != null}">
							<tr>
								<td>${memberGrade.name}</td>
								<td><fmt:formatNumber value="${memberGrade.rankUpMileage / 10000}" pattern="#,###"/>만&nbsp;탑승 마일리지 적립</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</main>

<input type="hidden" name="menuName" id="menuName" value="회원 안내">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
