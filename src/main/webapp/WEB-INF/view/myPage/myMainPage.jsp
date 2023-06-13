<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
.main--img--div {
	width: 100%;
	height: 450px;
	background-size: 100%;
	position: relative;
	background: url("../images/321.jpg");
	background-size: cover;
	margin-top: -30px;
}

main {
	padding: 0;
	margin-bottom: -16px;
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
	Transform: translateX(100%);
}

.my--centor {
	color: #fff;
	position: relative;
	padding-left: 500px;
	padding-top: 125px;
	position: absolute;
	Transform: translateX(50%);
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

.mileage {
	font-size: 1.5em;
}

.my--detail {
	display: block;
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
}

.bottom--my--info {
	display: flex;
	justify-content: center;
	background-color: #f0f0f0;
	align-items: flex-start;
}

.my--detail--top {
	margin-left: 20px;
	width: 1180px;
	padding: 20px 0 30px;
	background-color: #f0f0f0;
	display: flex;
}

.my--detail--top a {
	display: flex;
	padding: 38px;
	width: 285px;
	height: 163px;
	background-color: white;
	display: block;
	font-size: 15px;
	position: relative;
}

.my--detail--tit {
	display: inline-block;
	width: 160px;
	font-size: 16px;
	font-weight: 500;
	color: #404040;
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
	width: 283px;
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
	height: 378px;
	padding: 35px 40px 20px 40px;
}

.my--detail--bottom {
	margin-left: 20px;
	margin-bottom: 20px;
	width: 1180px;
	display: flex;
	justify-content:space-between;
	align-items: flex-start;
}

.my--detail--left {
	width: 580px;
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
	width: 579px;
	padding: 35px 39px 35px 37px;
}

.my--mileage--list td {
	padding: 7px;
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

#add--circle {
	color: white;
}

.balloon_03 {
	position: relative;
	margin: 44px 35px;
	width: 400px;
	background: white;
	border-radius: 10px;
	border: 3px solid #ccc;
}

.balloon_03:after {
	border-top: 20px solid #ccc;
	border-left: 0px solid transparent;
	border-right: 15px solid transparent;
	border-bottom: 0px solid transparent;
	content: "";
	position: absolute;
	background-color: white;
	top: 57px;
	left: 10px;
}

.bulloonText {
	margin: 15px;
}

.trip--origin {
	font-size: 30px;
	color: #808080;
	margin-left: 465px;
	position: relative;
	Transform: translateX(-200%);
	Transform: translateY(-240%);
	font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 48;
}

.rankImg {
	width: 50px;
	height: 52px;
	position: relative;
	margin-left: 3px;
	Transform: translateX(60%);
	Transform: translateY(-60%);
}

.progress {
	height: 10px;
	width: 417px;
	margin-left: 51px;
}

.imgText {
	color: white;
	position: relative;
	margin-left: 16px;
	margin-top: 1px;
	Transform: translateY(-250%);
}

.help {
	font-size: 19px;
}
.mileage--inquiry{
    height: 40px;
    padding-top: 7px;
    margin-top: 11px;
    margin-bottom: 3px;
    width: 145px;
    border-radius: 9px;
    background-color: rgb(240, 240, 240);
}
.mileage--inquiry a{
	padding: 10px;
}
  
.progress-bar {
	background-color: #7CB2D5;
}

.mileageListTable td, .mileageListTable th {
	font-size: 16px;
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
	            <c:choose>
	               <c:when test="${sumNowMileage.balanceNumber() != null}">
	            		<h4>${sumNowMileage.balanceNumber()}</h4>
	               </c:when>
	               <c:otherwise>
	                  <h4>0</h4>
	               </c:otherwise>
           		</c:choose>
	            <br>
	            <h2>누적 마일리지</h2>
	            <c:choose>
	            	<c:when test="${sumNowMileage.totalMileageNumber() != null}">
	           			<h4>${sumNowMileage.totalMileageNumber()}</h4>
	            	</c:when>
	            	<c:otherwise>
	                	<h4>0</h4>
	            	</c:otherwise>
	            </c:choose>
			</div>
			<div class="my--right">
				<div class="mileage">
					<c:choose>
						<c:when test="${mileage.balanceNumber() != null}">
							<p>
								소멸 예정 마일리지 <a href="/mileage/selectAll"><span
									class="material-symbols-outlined" id="add--circle">add_circle</span></a>
							</p>
							<p>${mileage.balanceNumber()}</p>
						</c:when>
						<c:otherwise>
							<p>
								소멸 예정 마일리지 <a href="/mileage/selectAll"><span
									class="material-symbols-outlined" id="add--circle">add_circle</span></a>
							</p>
							<p>예정인 마일리지가 없습니다</p>
						</c:otherwise>
					</c:choose>

				</div>
				<div class="mileage">
					<c:choose>
						<c:when test="${mileage2.balanceNumber() != null}">
							<p>
								적립 예정 마일리지 <a href="/mileage/selectAll"><span
									class="material-symbols-outlined" id="add--circle">add_circle</span></a>
							</p>
							<p>${mileage2.balanceNumber()}</p>
						</c:when>
						<c:otherwise>

							<p>적립 예정 마일리지</p>
							<p>예정인 마일리지가 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="bottom--my--info">
			<div class="my--detail">
				<div class="my--detail--top">
					<a href="/board/list/1"><span class="my--detail--tit">작성한 여행 일지</span> <br>
						<span class="num">${boardDto.count}</span> 
						<span class="material-symbols-outlined" id="edit--calendar">edit_calendar</span>
					</a>
					<span style="margin: 0 5px;"></span>
					<a href="/voc/list/1"><span class="my--detail--tit">작성한 고객의 말씀 수</span> <br> <span class="num">${infoDto.vocCount}</span>
						<span class="material-symbols-outlined" id="clinical--notes">clinical_notes</span>
					</a>
					<span style="margin: 0 5px;"></span>
					<a href="/gifticon/list"><span class="my--detail--tit">구매한 기프티콘 조회</span> <br> <span class="num">${gifticonCount.count}</span>
						<span class="material-symbols-outlined" id="barcode--scanner">shopping_cart_checkout</span>
					</a>
					<a href="/ticket/list/1" class="my--detail--gray"
						id="my--detail--gray"><span>항공권 예약 현황</span> <br> 
						<span class="material-symbols-outlined" id="airplane--ticket">airplane_ticket
					</span></a>
				</div>
				<div class="my--detail--bottom">
					<div class="my--detail--left">
						<div class="text--top">
							누적 적립 마일리지 <a href="/memberGrade"><span class="material-symbols-outlined help"> help
							</span></a> <br>
							<c:choose>
								<c:when test="${sumNowMileage.totalMileage < 100000}">
									<span class="important--span"><fmt:formatNumber type="number"
											maxFractionDigits="3"
											value="${100000 - sumNowMileage.totalMileage}" /></span> 마일 이상 적립 시 <strong>Gold</strong> 회원으로 승급됩니다.<br>
											<div class="mileage--inquiry">
									<a href="/mileage/selectAll" >마일리지 조회하기</a>
									</div>
									<hr>
									<div class="balloon_03">

										<p class="bulloonText">
											Gold 등급 까지
											<fmt:formatNumber type="number" maxFractionDigits="3"
												value="${100000 - sumNowMileage.totalMileage}" />
											마일 남았습니다.
										</p>
									</div>
									<div class="progress">
										<div class="progress-bar"
											style="width: <fmt:formatNumber type="number" maxFractionDigits="0"  value="${sumNowMileage.totalMileage * 100 / 100000}"/>%"></div>
									</div>
									<img alt="" src="../images/rank.png" class="rankImg">
									<span class="material-symbols-outlined trip--origin">
										radio_button_checked</span>
									<h1 class="imgText">S</h1>
								</c:when>
								<c:when
									test="${sumNowMileage.totalMileage > 100000 && sumNowMileage.totalMileage < 500000}">
										<span class="important--span"><fmt:formatNumber type="number"
											maxFractionDigits="3"
											value="${500000 - sumNowMileage.totalMileage}" /></span> 마일 이상 적립 시 <strong>Platinum</strong> 회원으로 승급됩니다.<br>
									<a href="/mileage/selectAll">마일리지 조회</a>
									<hr>
									<div class="balloon_03">

										<p class="bulloonText">
											Platinum 등급 까지
											<fmt:formatNumber type="number" maxFractionDigits="3"
												value="${500000 - sumNowMileage.totalMileage}" />
											마일 남았습니다.
										</p>
									</div>
									<div class="progress">
									</div>
									<img alt="" src="../images/rank.png" class="rankImg">
									<span class="material-symbols-outlined trip--origin ">
										radio_button_checked</span>
									<h1 class="imgText">G</h1>
								</c:when>
								<c:when
									test="${sumNowMileage.totalMileage > 500000 && sumNowMileage.totalMileage < 1000000}">
									<span class="important--span"><fmt:formatNumber type="number"
											maxFractionDigits="3"
											value="${1000000 - sumNowMileage.totalMileage}" /></span> 마일 이상 적립 시 <strong>Diamond</strong> 회원으로 승급됩니다.<br>
									<a href="/mileage/selectAll">마일리지 조회</a>
									<hr>
									<div class="balloon_03">

										<p class="bulloonText">
											Diamond 등급 까지
											<fmt:formatNumber type="number" maxFractionDigits="3"
												value="${1000000 - sumNowMileage.totalMileage}" />
											마일 남았습니다.
										</p>
									</div>
									<div class="progress">
										<div class="progress-bar"
											style="width: <fmt:formatNumber type="number" maxFractionDigits="0"  value="${sumNowMileage.totalMileage * 100 / 1000000}"/>%"></div>
									</div>
									<img alt="" src="../images/rank.png" class="rankImg">
									<span class="material-symbols-outlined trip--origin ">
										radio_button_checked</span>
									<h1 class="imgText">P</h1>
								</c:when>
							</c:choose>


						</div>
					</div>
					<div class="my--detail--right">
						<div class="my--mileage--list">
							<h3 class="d-flex justify-content-between align-items-end">
								<span>최근 마일리지 현황</span>
								<a href="/mileage/selectAll" class="d-flex align-items-end">
									<span class="material-symbols-outlined add">add</span>
								</a>
							</h3>
							<br>
							<table class="mileageListTable list--table" border="1">
								<tr>
									<th>날짜</th>
									<th>마일리지</th>
									<th>비고</th>
								</tr>
								<c:forEach items="${mileages}" var="mileages">
									<tr>

										<td><c:set var="mileages.mileageDate"
												value="<%=new java.util.Date()%>" /> <fmt:formatDate
												value="${mileages.mileageDate}" pattern="YYYY-MM-dd"
												type="date" /></td>
										<c:choose>
											<c:when test="${mileages.useMileage != null}">
												<td>- ${mileages.useMileage}</td>
											</c:when>
											<c:otherwise>
												<td>+ ${mileages.saveMileage}</td>
											</c:otherwise>
										</c:choose>
										<td>${mileages.description}</td>
									</tr>
								</c:forEach>
							</table>
						</div>

					</div>

				</div>
			</div>

		</div>
	</div>

</main>


<input type="hidden" name="menuName" id="menuName" value="마이페이지">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
