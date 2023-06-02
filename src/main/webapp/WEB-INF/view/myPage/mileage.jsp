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
-->
</style>

<!-- 마일리지 조회 페이지 -->
<main>

	<h1>마일리지 조회</h1>
	<div class="container">
		<h3>회원이름 회원님의 사용가능 마일리지</h3>
		<h3>숫자나오게 마일(글자 중앙 이동 해야함)</h3>
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
					<td>${saveMileage.balance}</td>
					<td>${useMileage.useMileage}</td>
					<td>${extinctionMileage.extinctionMileage}</td>
					<td>${saveMileage.balance - useMileage.useMileage}</td>
				</tr>

			</tbody>
		</table>
	</div>
	<div class="mileage--list">
		<h4 class="hidden" id="tab_title">적립/사용 상세내역조회</h4>
		<form action="mileageList" method="post" id="form">
			<div id="checkboxList">
				<input type="checkbox" class="searchKind" id="mileageType0" name="isAllSearch" value="isAllSearch" /> 
				<label for="mileageType0">전체</label> 
				<input type="checkbox" class="searchKind" id="mileageType1"name="isUpSearch" value="isUpSearch" /> 
					<label for="mileageType1">적립</label>
					 <input type="checkbox" class="searchKind" id="mileageType2" name="isUseSearch" value="isUseSearch" />
					  <label for="mileageType2">사용</label>
				<input type="checkbox" class="searchKind" id="mileageType3" name="isExpireSearch" value="isExpireSearch" />
				 <label for="mileageType3">소멸된 마일리지</label>
			</div>

			<dl>
				<dt>조회기간</dt>
				<dd>
					<input type="radio" name="searchType" id="searchType1" value="P" checked="checked" /> <label for="searchType1">기간으로 조회</label> <input type="radio" name="searchType" id="searchType2" value="R" />
					<label for="searchType2">가입일로부터 조회</label>
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
							<li id="liPeriods" class="li--period--s"><a>직접 선택</a></li><br>
						</ul>
					</div>
				</dd>
			</dl>
			<dl>
				<dd>

					<div class="relative_calendar">
						<div class="calendar_wrap">
							<input type="text" name="startTime" title="시작일" id="sCalendar01" class="datepicker input_cal" placeholder="시작일 선택" data-dateformat="y.mm.dd D" data-type="single_infinite">
						</div>

						<div class="calendar_layer">


							<div class="compareCalendar"></div>
							<a href="#none" class="cal_status02">시작일</a> <a href="#none" class="cal_reset"> <span class="hidden">달력 새로고침</span></a> <a href="#none" class="btn_cal_close"> <span class="hidden">닫기</span></a>
						</div>

					</div>

					<span class="mid_txt">부터 ~</span>
					<div class="relative_calendar">
						<div class="calendar_wrap">
							<input type="text" name="endTime" title="종료일" id="sCalendar02" class="datepicker input_cal" placeholder="종료일 선택" data-dateformat="y.mm.dd D" data-type="single_infinite_last"> <a
								href="#none" class="btn_airport type2 calendar_focus"></a>
						</div>

						<div class="calendar_layer">

							<div class="compareCalendar"></div>
							<a href="#none" class="cal_status02">종료일</a> <a href="#none" class="cal_reset"><span class="hidden">달력 새로고침</span></a> <a href="#none" class="btn_cal_close"><span class="hidden">닫기</span></a>
						</div>

					</div>

					<span class="mid_txt">까지</span>

					<button id="mileage--search" type="button" class="btn_M red">조회하기</button>
				</dd>
			</dl>
			<a href="javascript:sharpNothig();" class="lang_close top25"><span class="hidden">닫기</span></a>
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

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
