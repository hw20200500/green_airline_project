<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.tab_wrap6 li {
	float: left;
}
</style>
<!-- 여기 안에 쓰기 -->
<main>
	<h1>마일리지샵 이용 내역 조회</h1>
	<div class="container">
		<h2>
			<a href="/gifticon/list?type=0">구매 리스트</a>
		</h2>
		<h2>
			<a href="/gifticon/list?type=1">환불 리스트</a>
		</h2>
		
		
		
		
		
		<form action="mileageList" method="get" id="form">
			<div id="checkboxList">
				
			</div>

			<dl>
				<dt>조회기간</dt>
				<dd>
				<input type="radio" name="chk" value="buy">구매내역
				<input type="radio" name="chk" value="revoke">취소내역
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

					<button id="gifticon--search" type="button" class="btn_M red">조회하기</button>
				</dd>
			</dl>
			<a href="javascript:sharpNothig();" class="lang_close top25"><span class="hidden">닫기</span></a>
		</form>
		<form action="/gifticon/deleteGifticonById" method="post">
		<table class="table">
			<thead id="gifticonList--tr--thead">

			</thead>
			<tbody id="gifticonList--tr--tbody">
				
			</tbody >
		</table>
		<button onclick="refundGifticon()">환불</button>
		<input type="hidden" name="gifticonId" value="" id="gifticonId">
		<input type="text" name="productId" value="" id="productId">
    <input type="hidden" name="amount" value="" id="gifticonAmount">
    <input type="hidden" name="name" value="" id="gifticonName">
    <input type="hidden" name="brand" value="" id="gifticonBrand">
			</form>
	</div>
</main>

<script src="/js/gifticon.js">
	
</script>

<input type="hidden" name="menuName" id="menuName" value="마일리지샵 이용 내역">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
