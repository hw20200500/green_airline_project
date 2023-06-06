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

<link rel="stylesheet" href="/css/payment.css">

<!-- 탑승객 정보 입력 및 결제 페이지 -->

<main class="d-flex flex-column">
	<h2 class="page--title">항공권 예약</h2>
	<hr>
	<br>
	
	<div class="d-flex justify-content-center" style="width: 100%;">
		<div style="width: 900px;">
			<h5 class="small--title">
				<span class="material-symbols-outlined">airplane_ticket</span>
				<span>여정 정보</span>
			</h5>
			<div>
				<div class="ticket--div" id="ticketDiv1">
					<h6>
						<c:choose>
							<c:when test="${ticket.scheduleId2 != null}">
								가는 편
							</c:when>
							<c:otherwise>
								편도
							</c:otherwise>
						</c:choose>
					</h6>
					<p class="destination--departure">
						<span>${sch1Info.departureAirport}</span>
						<span>▶</span>
						<span>${sch1Info.destinationAirport}</span>
					</p>
					<p class="flight--date">${sch1Info.strDepartureDate}&nbsp;~&nbsp;${sch1Info.strArrivalDate}&nbsp;(${sch1Info.flightTime})</p>
					<p class="seat--list">
						<span>${sch1Info.airplaneName}</span>
						&nbsp;<span style="color: rgba(0, 0, 0, 0.6)">ㅣ</span>&nbsp;
						<span>${ticket.seatGrade}석</span>
						&nbsp;<span style="color: rgba(0, 0, 0, 0.6)">ㅣ</span>&nbsp;&nbsp;
						<span>좌석번호</span>&nbsp;
						<c:forEach var="seat" items="${ticket.seatNames}">
							<span style="color: #505050; font-weight: 400">${seat}</span>&nbsp;
						</c:forEach>
					</p>
				</div>
				<c:if test="${ticket.scheduleId2 != null}">
				<br>
				<div class="ticket--div" id="ticketDiv1">
					<h6>오는 편</h6>
					<p class="destination--departure">
						<span>${sch2Info.departureAirport}</span>
						<span>▶</span>
						<span>${sch2Info.destinationAirport}</span>
					</p>
					<p class="flight--date">${sch2Info.strDepartureDate}&nbsp;~&nbsp;${sch2Info.strArrivalDate}&nbsp;(${sch1Info.flightTime})</p>
					<p class="seat--list">
						<span>${sch2Info.airplaneName}</span>
						&nbsp;<span style="color: rgba(0, 0, 0, 0.6)">ㅣ</span>&nbsp;
						<span>${ticket.seatGrade2}석</span>
						&nbsp;<span style="color: rgba(0, 0, 0, 0.6)">ㅣ</span>&nbsp;&nbsp;
						<span>좌석번호</span>&nbsp;
						<c:forEach var="seat" items="${ticket.seatNames2}">
							<span style="color: #505050; font-weight: 400">${seat}</span>&nbsp;
						</c:forEach>
					</p>
				</div>
				</c:if>
			</div>
			<br>
			<hr style="width: 1000px; margin-left: -50px;">
			<br>
			<!-- 여기서부터 탑승객 정보 입력 -->
			<h5 class="small--title">
				<span class="material-symbols-outlined">group</span>
				<span>탑승객 정보</span>
			</h5>
			<label id="checkCurrentUserLabel"><input type="checkbox" id="checkCurrentUser">&nbsp;&nbsp;예약자 본인을 탑승객에 포함</label>
			<div class="passenger--info--list">
				<!-- 성인 -->
				<table border="1">
					<tr>
						<th>구분</th>
						<th>성별</th>
						<th>성명</th>
						<th>생년월일</th>
					</tr>
					<c:forEach var="i" begin="0" end="${ticket.adultCount - 1}">
						<tr class="passenger--tr" id="passenger${i + 1}">
							<td class="age--td">
								성인 ${i + 1}
							</td>
							<td class="gender--td">
								<input type="radio" value="M" name="gender${i + 1}" id="genderM${i + 1}" checked>
								<label for="genderM${i + 1}">남성</label>
								&nbsp;&nbsp;
								<input type="radio" value="F" name="gender${i + 1}" id="genderF${i + 1}">
								<label for="genderF${i + 1}">여성</label>
							</td>
							<td class="name--td">
								<input type="text" name="name${i + 1}" value="d">
							</td>
							<td class="birth--td">
								<input type="text" name="birth${i + 1}" placeholder="yyyy-mm-dd" value="2000-01-05">
							</td>
						</tr>
					</c:forEach>
				</table>
				<!-- 소아 -->
				<c:if test="${ticket.childCount != 0}">
					<br>
					<table border="1">
						<tr>
							<th>구분</th>
							<th>성별</th>
							<th>성명</th>
							<th>생년월일</th>
						</tr>
						<c:forEach var="i" begin="0" end="${ticket.childCount - 1}">
							<tr class="passenger--tr" id="passenger${ticket.adultCount + i + 1}">
								<td class="age--td">
									소아 ${i + 1}
								</td>
								<td class="gender--td">
									<input type="radio" value="M" name="gender${ticket.adultCount + i + 1}" id="genderM${ticket.adultCount + i + 1}" checked>
									<label for="genderM${ticket.adultCount + i + 1}">남성</label>
									&nbsp;&nbsp;
									<input type="radio" value="F" name="gender${ticket.adultCount + i + 1}" id="genderF${ticket.adultCount + i + 1}">
									<label for="genderF${ticket.adultCount + i + 1}">여성</label>
								</td>
								<td class="name--td">
									<input type="text" name="name${ticket.adultCount + i + 1}" value="d">
								</td>
								<td class="birth--td">
									<input type="text" name="birth${ticket.adultCount + i + 1}" placeholder="yyyy-mm-dd" value="2020-01-05">
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				<!-- 유아 -->
				<c:if test="${ticket.infantCount != 0}">
					<br>
					<table border="1">
						<tr>
							<th>구분</th>
							<th>성별</th>
							<th>성명</th>
							<th>생년월일</th>
						</tr>
						<c:forEach var="i" begin="0" end="${ticket.infantCount - 1}">
							<tr class="passenger--tr" id="passenger${ticket.adultCount + ticket.childCount + i + 1}">
								<td class="age--td">
									유아 ${i + 1}
								</td>
								<td class="gender--td">
									<input type="radio" value="M" name="gender${ticket.adultCount + ticket.childCount + i + 1}" id="genderM${ticket.adultCount + ticket.childCount + i + 1}" checked>
									<label for="genderM${ticket.adultCount + ticket.childCount + i + 1}">남성</label>
									&nbsp;&nbsp;
									<input type="radio" value="F" name="gender${ticket.adultCount + ticket.childCount + i + 1}" id="genderF${ticket.adultCount + ticket.childCount + i + 1}">
									<label for="genderF${ticket.adultCount + ticket.childCount + i + 1}">여성</label>
								</td>
								<td class="name--td">
									<input type="text" name="name${ticket.adultCount + ticket.childCount + i + 1}" value="d">
								</td>
								<td class="birth--td">
									<input type="text" name="birth${ticket.adultCount + ticket.childCount + i + 1}" placeholder="yyyy-mm-dd">
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</div>
			<br>
			<div class="d-flex justify-content-center" style="width: 100%; margin: 30px 0 40px;">
				<button class="blue--btn--middle" id="passengerInfoBtn">
					<ul class="d-flex justify-content-center">
						<li style="margin-right: 4px;">입력 완료
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">done</span>
					</ul>
				</button>
			</div>
			<!-- 여기서부터 결제 정보 -->
			<div id="paymentDiv">
			<hr style="width: 1000px; margin-left: -50px;">
			<br>
				<h5 class="small--title">
					<span class="material-symbols-outlined">credit_card</span>
					<span>결제 정보</span>
				</h5>
				<div style="width: 100%; text-align: center;">
					<label><input type="radio" name="paymentType" value="0" checked>&nbsp;카카오페이</label>
					<span style="margin: 20px;"></span>
					<label><input type="radio" name="paymentType" value="1">&nbsp;마일리지</label>
				</div>
				<br>
				<div id="kakaoPayDiv">
					<table border="1" class="payment--table">
						<tr class="payment--tb--depth--1">
							<th colspan="2">
								<c:choose>
									<c:when test="${ticket.scheduleId2 != null}">
										여정 1 요금	
									</c:when>
									<c:otherwise>
										편도 요금
									</c:otherwise>
								</c:choose>
							</th>
						</tr>
						<tr class="payment--tb--depth--2">
							<td>${ticket.seatGrade}</td>
							<td><td>
						<tr class="payment--tb--depth--3">
							<td>성인 ${ticket.adultCount}인</td>
							<!-- 콤마 찍어서 나타내기 -->
							<td><fmt:formatNumber value="${sch1AdultPrice}" pattern="#,###"/>&nbsp;원</td>
						</tr>
						<c:if test="${ticket.childCount != 0}">
							<tr class="payment--tb--depth--3">
								<td>소아 ${ticket.childCount}인</td>
								<td><fmt:formatNumber value="${sch1ChildPrice}" pattern="#,###"/>&nbsp;원</td>
							</tr>
						</c:if>
						<c:if test="${ticket.infantCount != 0}">
							<tr class="payment--tb--depth--3">
								<td>유아 ${ticket.infantCount}인</td>
								<td><fmt:formatNumber value="${sch1InfantPrice}" pattern="#,###"/>&nbsp;원</td>
							</tr>
						</c:if>
						
						<!-- 왕복이라면 -->
						<c:if test="${ticket.scheduleId2 != null}">
							<tr class="payment--tb--depth--1">
								<th colspan="2">여정 2 요금</th>
							</tr>
							<tr class="payment--tb--depth--2">
								<td>${ticket.seatGrade2}</td>
								<td><td>
							</tr>
							<tr class="payment--tb--depth--3">
								<td>성인 ${ticket.adultCount}인</td>
								<!-- 콤마 찍어서 나타내기 -->
								<td><fmt:formatNumber value="${sch2AdultPrice}" pattern="#,###"/>&nbsp;원</td>
							</tr>
							<c:if test="${ticket.childCount != 0}">
								<tr class="payment--tb--depth--3">
									<td>소아 ${ticket.childCount}인</td>
									<td><fmt:formatNumber value="${sch2ChildPrice}" pattern="#,###"/>&nbsp;원</td>
								</tr>
							</c:if>
							<c:if test="${ticket.infantCount != 0}">
								<tr class="payment--tb--depth--3">
									<td>유아 ${ticket.infantCount}인</td>
									<td><fmt:formatNumber value="${sch2InfantPrice}" pattern="#,###"/>&nbsp;원</td>
								</tr>
							</c:if>
						</c:if>
						<tr>
							<th>총액</th>
							<th>
								<c:choose>
									<c:when test="${ticket.scheduleId2 != null}">
										<fmt:formatNumber value="${ticket.price + ticket.price2}" pattern="#,###"/>&nbsp;원
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${ticket.price}" pattern="#,###"/>&nbsp;원
									</c:otherwise>
								</c:choose>
							</th>
						</tr>
					</table>
					<br>
					
					<div id="kakaoPayImgDiv">
						<img src="/images/kakao_pay.png" id="kakaoPayImg">
					</div>
				</div>
				
				<div id="milesPayDiv">
					<table border="1" class="payment--table">
						<tr class="payment--tb--depth--1">
							<th colspan="2">
								<c:choose>
									<c:when test="${ticket.scheduleId2 != null}">
										여정 1 요금	
									</c:when>
									<c:otherwise>
										편도 요금
									</c:otherwise>
								</c:choose>
							</th>
						</tr>
						<tr class="payment--tb--depth--2">
							<td>${ticket.seatGrade}</td>
							<td><td>
						<tr class="payment--tb--depth--3">
							<td>성인 ${ticket.adultCount}인</td>
							<!-- 콤마 찍어서 나타내기 -->
							<td><fmt:formatNumber value="${ticket.milesPrice(sch1AdultPrice)}" pattern="#,###"/>&nbsp;마일</td>
						</tr>
						<c:if test="${ticket.childCount != 0}">
							<tr class="payment--tb--depth--3">
								<td>소아 ${ticket.childCount}인</td>
								<td><fmt:formatNumber value="${ticket.milesPrice(sch1ChildPrice)}" pattern="#,###"/>&nbsp;마일</td>
							</tr>
						</c:if>
						<c:if test="${ticket.infantCount != 0}">
							<tr class="payment--tb--depth--3">
								<td>유아 ${ticket.infantCount}인</td>
								<td><fmt:formatNumber value="${ticket.milesPrice(sch1InfantPrice)}" pattern="#,###"/>&nbsp;마일</td>
							</tr>
						</c:if>
						
						<!-- 왕복이라면 -->
						<c:if test="${ticket.scheduleId2 != null}">
							<tr class="payment--tb--depth--1">
								<th colspan="2">여정 2 요금</th>
							</tr>
							<tr class="payment--tb--depth--2">
								<td>${ticket.seatGrade2}</td>
								<td><td>
							</tr>
							<tr class="payment--tb--depth--3">
								<td>성인 ${ticket.adultCount}인</td>
								<!-- 콤마 찍어서 나타내기 -->
								<td><fmt:formatNumber value="${ticket.milesPrice(sch2AdultPrice)}" pattern="#,###"/>&nbsp;마일</td>
							</tr>
							<c:if test="${ticket.childCount != 0}">
								<tr class="payment--tb--depth--3">
									<td>소아 ${ticket.childCount}인</td>
									<td><fmt:formatNumber value="${ticket.milesPrice(sch2ChildPrice)}" pattern="#,###"/>&nbsp;마일</td>
								</tr>
							</c:if>
							<c:if test="${ticket.infantCount != 0}">
								<tr class="payment--tb--depth--3">
									<td>유아 ${ticket.infantCount}인</td>
									<td><fmt:formatNumber value="${ticket.milesPrice(sch2InfantPrice)}" pattern="#,###"/>&nbsp;마일</td>
								</tr>
							</c:if>
						</c:if>
						<tr>
							<th>총액</th>
							<th>
								<c:choose>
									<c:when test="${ticket.scheduleId2 != null}">
										<fmt:formatNumber value="${ticket.milesPrice(ticket.price) + ticket.milesPrice(ticket.price2)}" pattern="#,###"/>&nbsp;마일
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${ticket.milesPrice(ticket.price)}" pattern="#,###"/>&nbsp;마일
									</c:otherwise>
								</c:choose>
							</th>
						</tr>
					</table>
					<br>
					<div id="milesBtnDiv">
						<button type="submit" id="milesPayBtn" class="blue--btn--small" onclick="return confirm('마일리지 결제를 진행하시겠습니까?');">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">flight</span>
								<li style="margin-left: 4px;">Miles Pay
							</ul>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</main>

<script>

	let adultCount = ${ticket.adultCount};
	let childCount = ${ticket.childCount};
	let infantCount = ${ticket.infantCount};
	let scheduleId1 = ${ticket.scheduleId};
	let seatGrade1 = `${ticket.seatGrade}`;
	let seatNames1 = new Array();
	let price = ${ticket.price};
	let milesPrice = ${milesPrice};
	
	// 여정 개수 (1 == 편도, 2 == 왕복)
	let scheduleCount = 1;
	
	// 예외 방지
	let scheduleId2;
	let seatGrade2;
	let seatNames2;
	
	// 탑승객 연령 타입을 확인하기 위해 스케줄 1의 출발 날짜/시간에서 날짜만
	let testSch1DepartureDate = `${sch1Info.departureDate}`.substr(0, 10);
	
	// 모든 탑승객 정보 (티켓 정보와 함께 보낼 것)
	let passengerInfos = new Array();
	
</script>

<c:forEach var="seat" items="${ticket.seatNames}">
	<script>
		seatNames1.push(`${seat}`);
	</script>
</c:forEach>
	
<!-- 왕복이라면 -->
<c:if test="${ticket.scheduleId2 != null}">
	<script>
		scheduleCount = 2;
		let price2 = ${ticket.price2};
		let milesPrice2 = ${milesPrice2};
		scheduleId2 = ${ticket.scheduleId2};
		seatGrade2 = `${ticket.seatGrade2}`;
		seatNames2 = new Array();
		// 탑승객 타입을 확인하기 위해 스케줄 2의 출발 날짜/시간에서 날짜만
		let testSch2DepartureDate = `${sch2Info.departureDate}`.substr(0, 10);
	</script>
	<c:forEach var="seat" items="${ticket.seatNames2}">
		<script>
			seatNames2.push(`${seat}`);
		</script>
	</c:forEach>
</c:if>

<script src="/js/payment.js"></script>
<script src="/js/ticket.js"></script>

<input type="hidden" name="menuName" id="menuName" value="항공권 예약">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
