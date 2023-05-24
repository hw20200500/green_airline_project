<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div class="main--img--div">
	<div class=""></div>
</div>

<!-- 여기 안에 쓰기 -->
<main>
	<h1>마일리지 신청</h1>
	<div class="container">
		<h2>신청 가능한 어쩌구</h2>
		<p>설명 적을거면 적기</p>
		<form action=""method="post">
			<table>
				<thead>

					<tr>
						<th>편명</th>
						<th>${allInfoDto.airplaneName}</th>
					</tr>
					<tr>
						<th>탑승 구간</th>
						<td>${allInfoDto.departure}${allInfoDto.destination}</td>
					</tr>
					<tr>
						<th>탑승 클래스</th>
						<td>${allInfoDto.seatGrade }</td>

					</tr>
					<tr>
						<th>탑승 확인</th>
						<td>${allInfoDto.id}</td>
					</tr>
					<tr>
						<th>탑승일</th>
						<td>${allInfoDto.formatDepartureDate()}</td>
					</tr>
					<tr>
						<th>적립 마일리지</th>
						<td>예상 적립 마일리지</td>
					</tr>
				
				</thead>
			</table>
			<input type="text" value="${allInfoDto.reqStatus}"name="reqStatus">
			<input type="text" value="${allInfoDto.id}"name="id">
				<button type="submit">신청</button>
		</form>
	</div>
</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
