<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
.main--img--div {
	width: 100vw;
	height: 450px;
	background-size: 100%;
	position: relative;
	background: url("../images/321.jpg");
	background-size: cover;
}

.main--img--div::before {
	content: "";
	opacity: 0.45;
	position: absolute;
	top: 0px;
	left: 0px;
	right: 0px;
	bottom: 0px;
	background-color: #000;
	color: initial;
}

.box01 {
	color: #fff;
	position: relative;
	padding-left: 500px;
	padding-top: 125px;
	position: absolute;
	Transform: translateX(-20%);
}

.my--right {
	color: #fff;
	position: relative;
	padding-left: 500px;
	padding-top: 125px;
	position: absolute;
	Transform: translateX(130%);
}

.my--centor {
	color: #fff;
	position: relative;
	padding-left: 500px;
	padding-top: 125px;
	position: absolute;
	Transform: translateX(40%);
}

#piechart {
	position: relative;
	position: absolute;
	Transform: translateX(-5%);
	Transform: translateY(-40%);
}

.remark {
	position: absolute;
}

.material-symbols-outlined {
	color: white;
}

.mileage {
	font-size: 1.5em;
}

.my--detail {
	padding: 10px 300px;
	display: block;
	display: flex;
	flex-wrap: wrap;
}

.bottom--my--info {
	padding: 20px 0 100px;
	margin: 0 auto;
	background-color: #f0f0f0;
	height: 100vw;
}

.my--detail--top {
	padding: 20px 0 30px;
	margin: 0 auto;
	background-color: #f0f0f0;
	display: flex;
}

.my--detail--top a {
	display: flex;
	padding: 38px;
	width: 290px;
	height: 163px;
	background-color: white;
	display: block;
	font-size: 15px;
	position: relative;
}

.my--detail--tit {
	display: inline-block;
	width: 160px;
	font-size: 15px;
}

.num {
	display: block;
	line-height: 1.1;
	font-size: 40px;
	font-weight: bold;
	color: #d60815;
}

#my--detail--gray {
	display: inline-block;
	width: 280px;
	height: 165px;
	padding: 22px 0 0 24px;
	margin-left: 20px;
	color: #fff;
	background-color: #6d6e70;
	background-position: right 30px bottom 30px;
	background-repeat: no-repeat;
	font-size: 23px;
	box-sizing: border-box;
	position: relative;
}

.text--top {
	background-color: white;
	padding: 35px 40px 20px 40px;
}

.my--detail--bottom {
	display: flex;
	float: left;
	width: 1180px;
	margin-left: 80px;
}

.my--detail--left {
	width: 580px;
	height: 650px;
}

.my--detail--right {
	width: 580px;
	margin-left: 10px;
	height: 300px;
}

#airplane--ticket {
	font-size: 60px;
	position: absolute;
	bottom: 8px;
	right: 16px;
}

#barcode--scanner {
	position: absolute;
	font-size: 60px;
	bottom: 5px;
	right: 16px;
	color: #A3A6AD;
}

#clinical--notes {
	position: absolute;
	font-size: 60px;
	bottom: 5px;
	right: 16px;
	color: #A3A6AD;
}

#edit--calendar {
	position: absolute;
	font-size: 60px;
	bottom: 5px;
	right: 16px;
	color: #A3A6AD;
}

.my--mileage--list {
	background-color: white;
	width: 500px;
	padding: 35px 39px 35px 37px;
}

.etc--box {
	display: flex;
	flex-wrap: wrap;
	margin-top: 20px;
}

.etc--box li {
	float: left;
	width: 279px;
	height: 119px;
	background-color: white;
	padding: 20px 0px 0px 24px;
	margin: 5px;
}
</style>



<main>
	<div>
		<div class="main--img--div">
			<div class="box01">
				<h2>${member.korName}</h2>
				<p>${member.engName}</p>
				<h2>${member.grade}</h2>
			</div>
			<div class="my--centor">
				<h2>현재 마일리지</h2>
				<h4>${sumNowMileage.balanceNumber()}</h4>
			</div>
			<div class="my--right">
				<div class="mileage">
					<c:choose>
						<c:when test="${mileage.balanceNumber() != null}">
							<p>
								소멸 예정 마일리지 <a href="/mileage/selectAll"><span class="material-symbols-outlined">add_circle</span></a>
							</p>
							<p>${mileage.balanceNumber()}</p>
						</c:when>
						<c:otherwise>
							<p>
								소멸 예정 마일리지 <a href="/mileage/selectAll"><span class="material-symbols-outlined">add_circle</span></a>
							</p>
							<p>예정인 마일리지가 없습니다</p>
						</c:otherwise>
					</c:choose>

				</div>
				<div class="mileage">
					<c:choose>
						<c:when test="${mileage2.balanceNumber() != null}">
							<p>
								적립 예정 마일리지 <a href="/mileage/selectAll"><span class="material-symbols-outlined">add_circle</span></a>
							</p>
							<p>${mileage2.balanceNumber()}</p>
						</c:when>
						<c:otherwise>

							<p>적립 예정 마일리지</p>
							<p>예정인 마일리지가 없습니다</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="bottom--my--info">
			<div class="my--detail">
				<div class="my--detail--top">
					<a href="#"><span class="my--detail--tit">작성한 여행 일지</span> <br> <span class="num">0</span> <span class="material-symbols-outlined" id="edit--calendar">edit_calendar</span></a> <a href="#"><span>기내
							서비스 신청 기록??</span> <br> <span class="num">0</span> <span class="material-symbols-outlined" id="clinical--notes">clinical_notes</span></a> <a href="/gifticon/list"><span>구매한 기프티콘 조회</span> <br>
						<span class="num">0</span> <!-- barcode    barcode_scanner --> <span class="material-symbols-outlined" id="barcode--scanner">shopping_cart_checkout</span></a> <a href="/ticket/list/1"
						class="my--detail--gray" id="my--detail--gray"><span>항공권 예약 현황</span> <br> <span class="material-symbols-outlined" id="airplane--ticket">airplane_ticket </span></a>
				</div>
				<div class="my--detail--bottom">
					<div class="my--detail--left">
						<div class="text--top">
							등급 산정 마일리지를 도움말 <br> <span>20,000</span>마일 추가 적립 또는 아시아나항공 골드회원으로 승급됩니다.<br>
							<button type="button" class="btn_XS white">승급 마일리지 조회</button>
							<hr>
							<p>등급 까지 ...마일 남았습니다</p>
							<div class="progress">
								<div class="progress-bar" style="width: 30%"></div>
							</div>
						</div>
					</div>
					<div class="my--detail--right">
						<div class="my--mileage--list">
							<h3>최근 마일리지 현황</h3>
							<hr width="100%" color="#ccc" noshade />

						</div>
						<div class="etc--box">
							<ul>
								<li><a href="#">회원정보 수정</a></li>
								<li><a href="#">회원정보 수정</a></li>
								<li><a href="#">회원정보 수정</a></li>
								<li><a href="#">회원정보 수정</a></li>
							</ul>
							<!-- 							<a href="#">회원정보 수정</a> <a href="#">회원정보 수정</a> <a href="#">회원정보 수정</a> <a href="#">회원정보 수정</a>
 -->
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>

</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
