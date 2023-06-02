<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script defer src="/js/mapApi.js"></script>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
.visual--banner {
	display: inline-block;
	height: 100%;
	width: 100%;
	min-height: 200px;
	padding: 40px 440px 40px 50px;
	background-color: #e6e2df;
	background-repeat: no-repeat;
	background-position: right bottom;
	margin-bottom: 30px;
	background-image: url(../images/tourAirport.png);
	font-size: 20px;
}

.list--searchOpt .btn--search {
	position: relative;
	right: auto;
	top: auto;
	width: 100%;
	height: 40px;
	background: #a70638;
	margin: 0;
	padding: 0;
	border: none;
	cursor: pointer;
	color: white;
	margin-bottom: 30px;
}
</style>

<main>
	<h1>공항 정보</h1>

	<div class="choice--airport">
		<div class="visual--banner">
			취항지 공항의 카운터 위치 및 시설 정보, 공항서비스를<br> 확인하실 수 있습니다.
		</div>
	</div>

	<div class="list--searchOpt">
		<form action="/map" method="post">
			<div class="form-group col-sm-5">
				<label for="selectContinent">지역</label> <select class="form-control"
					name="selectContinent" id="id--selectContinent">
					<option>공항을 선택해주세요</option>
					<option value="대한민국">대한민국</option>
					<option value="동북아시아">동북아시아</option>
					<option value="동남아시아/서남아시아">동남아시아/서남아시아</option>
					<option value="미국">미국</option>
					<option value="유럽">유럽</option>
					<option value="대양주/괌">대양주/괌</option>
					<option value="러시아/몽골/중앙아시아">러시아/몽골/중앙아시아</option>
					<option value="중동/아프리카">중동/아프리카</option>
				</select>
			</div>

			<div class="form-group col-sm-5">
				<label for="airport">공항</label> <select name="selectAirport"
					class="form-control" id="id--selectAirport">
					<option value="">전체</option>
				</select>

			</div>
			<button type="button" class="btn--search" id="searchAirport">조회</button>
			<div id="result"></div>
		</form>
	</div>

	<div id="map" style="height: 600px;"></div>

</main>

<input type="hidden" name="menuName" id="menuName" value="공항 위치 정보">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
