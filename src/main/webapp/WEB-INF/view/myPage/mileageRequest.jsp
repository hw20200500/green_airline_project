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

<div class="main--img--div">
	<div class=""></div>
</div>

<!-- 여기 안에 쓰기 -->
<main>
	<h1>마일리지 신청</h1>
	<div class="container">
		<h2>신청 가능한 어쩌구</h2>
		<p>설명 적을거면 적기</p>
		<table>
			<thead>
				<tr>
					<th>편명</th>
					<td>편명</td>
				</tr>
				<tr>
					<th>탑승 구간</th>
					<td>탑승구간 출발 도착</td>
				</tr>
				<tr>
					<th>탑승 클래스</th>
					<td>선택 만들기</td>

				</tr>
				<tr>
					<th>탑승 확인</th>
					<td>좌벅번호 티켓번호</td>
				</tr>
				<tr>
					<th>탑승일</th>
					<td>탑승일</td>
				</tr>
				<tr>
					<th>적립 마일리지</th>
					<td>적립 마일리지</td>
				</tr>
			</thead>
		</table>
	</div>
</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
