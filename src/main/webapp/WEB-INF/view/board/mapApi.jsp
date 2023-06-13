<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script defer src="/js/mapApi.js"></script>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAjjGP2VKpJKLym7EhCy_7fAFXxPOBuxL0&callback=initMap"></script>
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

</style>

<main>
	<h2 class="page--title">공항 위치 정보</h2>
	<hr>
	<br>

	<div class="choice--airport">
		<div class="visual--banner">
			취항지 공항의 위치 및 시설 정보, 주변 시설 정보를<br> 확인하실 수 있습니다.
		</div>
	</div>

	<div class="list--searchOpt">
		<form action="/map" method="post">
			<div class="d-flex justify-content-center align-items-end" style="margin-bottom: 40px;">
				<div class="form-group" style="width: 300px; margin: 0 30px">
					<label for="selectContinent">지역</label> <select class="form-control"
						name="selectContinent" id="id--selectContinent">
						<option value="">공항을 선택해주세요</option>
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
	
				<div class="form-group" style="width: 300px; margin: 0 30px">
					<label for="airport">공항</label> 
					<select name="selectAirport" class="form-control" id="id--selectAirport">
						<option value="">전체</option>
					</select>
				</div>
				<button type="button" class="btn--search blue--btn--small" id="searchAirport">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li style="margin-right: 4px;">조회
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 20px; margin-top: 3px;">search</span>
					</ul>
				</button>
				<br>
			</div>
			<div id="result"></div>
		</form>
	</div>

	<div id="map" style="height: 600px;"></div>

</main>

<input type="hidden" name="menuName" id="menuName" value="공항 위치 정보">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
