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
<!--
.tab_wrap6 li {
	float: left;
}

.title {
	text-align: center;
}

#tab_title {
	text-align: center;
	margin-top: 20px;
}

strong {
	margin-right: 240px;
}

.sortation {
	margin-right: 255px;
}

#checkboxList {
	margin-top: 20px;
	font-size: 20px;
}

form {
	background-color: rgb(240, 240, 240);
	padding: 30px 50px;
	
}

.container {
	margin-top: 20px;
}

table.table-bordered {
	border-collapse: collapse;
	width: 100%;
}

table.table-bordered th, table.table-bordered td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

table.table-bordered th {
	background-color: #f2f2f2;
}

.mileage--list {
	margin-top: 20px;
}

h4#tab_title {
	text-align: center;
	margin-top: 20px;
}

.searchKind, input[type=radio] {
	width: 17px;
	height: 14px;
}

table#savemileage--List, table#usemileage--List, table#expirationDatemileage--List {
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
}

table#savemileage--List th, table#savemileage--List td, table#usemileage--List th, table#usemileage--List td, table#expirationDatemileage--List th, table#expirationDatemileage--List td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

table#savemileage--List th, table#usemileage--List th, table#expirationDatemileage--List th {
	background-color: #f2f2f2;
}

.li--period, .li--period--s {
	width: 105px;
	height: 46px;
	background-color: white;
	text-align: center;
	padding: 10px;
	border: 1px solid #ccc;
}

.tab_wrap6 ul {
	height: 60px;
}

.tab_wrap6 {
	margin-left: 300px;
}

.calendar_wrap {
	margin-left: 300px;
}
.btn-light{
padding-top: 0;
margin-bottom2px;
	height: 30px;
	text-align: center;
}
#sCalendar01,#sCalendar02{
	width: 191px;
}
-->
</style>

<!-- 마일리지 조회 페이지 -->
<main>
	<h2 class="page--title">마일리지 조회</h2>
	<hr>
	<br>
	
	<div class="container">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>구분</th>
					<th>적립 마일리지</th>
					<th>사용 마일리지</th>
					<th>소멸 마일리지</th>
					<th>잔여 마일리지</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>마일리지</td>
					<td>${saveMileage.totalMileage}</td>
					<td>${useMileage.useMileage}</td>
					<td>${extinctionMileage.extinctionMileage}</td>
					<td>${saveMileage.totalMileage - useMileage.useMileage - extinctionMileage.extinctionMileage}</td>
				</tr>

			</tbody>
		</table>
	</div>
	<div class="mileage--list">
		<h4 class="hidden" id="tab_title">적립/사용 상세내역조회</h4>
		<form action="mileageList" method="post" id="form">
			<div id="checkboxList">
				<strong class="sortation">구분</strong> <input type="checkbox" class="searchKind" id="mileageType0" name="isAllSearch" value="isAllSearch"/> <label for="mileageType0">전체</label> <input
					type="checkbox" class="searchKind" id="mileageType1" name="isUpSearch" value="isUpSearch" /> <label for="mileageType1">적립</label> <input type="checkbox" class="searchKind" id="mileageType2"
					name="isUseSearch" value="isUseSearch" /> <label for="mileageType2">사용</label> <input type="checkbox" class="searchKind" id="mileageType3" name="isExpireSearch" value="isExpireSearch" /> <label
					for="mileageType3">소멸</label>
			</div>

			<dl>
				<dd>
					<strong>조회기간</strong><input type="radio" name="searchType" id="searchType1" value="P" checked="checked" /> <label for="searchType1">기간으로 조회</label> <input type="radio" name="searchType"
						id="searchType2" value="R" /> <label for="searchType2">가입일로부터 조회</label>
				</dd>
			</dl>
			<dl>
				<dd id="dd_period_detail">
					<div class="tab_wrap6">
						<ul>
							<li id="liPeriod1" class="li--period"><a>1개월</a></li>
							<li id="liPeriod3" class="li--period"><a>3개월</a></li>
							<li id="liPeriod6" class="li--period"><a>6개월</a></li>
							<li id="liPeriod12" class="li--period"><a>1년</a></li>
							<li id="liPeriods" class="li--period--s"><a>직접 선택</a></li>
							<br>
						</ul>
					</div>
				</dd>
			</dl>
			<dl>
				<dd>

					<div class="relative_calendar">
						<div class="calendar_wrap">
							<input type="text" name="startTime" title="시작일" id="sCalendar01" class="datepicker input_cal" placeholder="시작일 선택" data-dateformat="y.mm.dd D" data-type="single_infinite"> <span
								class="mid_txt">부터 ~</span> 
								<input type="text" name="endTime" title="종료일" id="sCalendar02" class="datepicker input_cal" placeholder="종료일 선택" data-dateformat="y.mm.dd D"
								data-type="single_infinite_last"> <a href="#none" class="btn_airport type2 calendar_focus"></a>
								<button id="mileage--search" type="button" class="btn btn-light">조회하기</button>
						</div>
					</div>

					
				</dd>
			</dl>
		</form>
	</div>
	<div id="">
		<table id="savemileage--List" class="table table-bordered">
			<thead id="savemileageList--tr--thead">
				<!-- jquery로 만드는거라 일부러 비워둠 -->
			</thead>
			<tbody id="savemileageList--tr--tbody">
				<!-- jquery로 만드는거라 일부러 비워둠 -->
			</tbody>
		</table>
		<table id="usemileage--List" class="table table-bordered">
			<thead id="usemileageList--tr--thead">
				<!-- jquery로 만드는거라 일부러 비워둠 -->
			</thead>
			<tbody id="usemileageList--tr--tbody">
				<!-- jquery로 만드는거라 일부러 비워둠 -->
			</tbody>
		</table>
		<table id="expirationDatemileage--List" class="table table-bordered">
			<thead id="expirationDatemileageList--tr--thead">
				<!-- jquery로 만드는거라 일부러 비워둠 -->
			</thead>
			<tbody id="expirationDatemileageList--tr--tbody">
				<!-- jquery로 만드는거라 일부러 비워둠 -->
			</tbody>
		</table>
	</div>
</main>




<script src="/js/mileage.js"></script>

<input type="hidden" name="menuName" id="menuName" value="마일리지 조회">


<script src="/js/mileage.js">
</script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
