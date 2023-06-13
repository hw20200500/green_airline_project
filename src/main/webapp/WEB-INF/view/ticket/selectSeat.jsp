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

<link rel="stylesheet" href="/css/seat.css">

<!-- 좌석 선택 페이지 -->

<main class="d-flex flex-column">
	<h2 class="page--title">항공권 예약</h2>
	<hr>
	<br>
	<div class="d-flex" style="width: 100%;">
		<div class="airplane--div" id="sch1Airplane">
			<div class="airplane--background airplane--${ticketList.get(0).airplaneId}">
				<div class="seat--list">
					<div class="top--blank--div"></div>
					<!-- 퍼스트 좌석 -->
					<c:if test="${sch1FiList.isEmpty() == false}">
						<div class="f--seat">
							<c:set var="f" value="1" />
							<c:forEach var="first" items="${sch1FiList}">
								<c:choose>
									<%-- 홀수 번째라면 --%>
									<c:when test="${f % 2 == 1}">
										<c:if test="${f == 1}">
											<span style="margin: 13px;"> </span>
										</c:if>
										<c:choose>
											<c:when test="${ticketList.get(0).seatGrade.equals(\"퍼스트\") == false}">
												<img alt="" src="/images/ticket/first_r_false.png" class="seat--1--${first.name}" onclick="selectSeat(1, 'f', '${first.name}');">
											</c:when>
											<c:when test="${first.status == true}">
												<img alt="" src="/images/ticket/first_r_pre.png" class="seat--1--${first.name}" onclick="selectSeat(1, 'f', '${first.name}');">
											</c:when>
											<c:otherwise>
												<img alt="" src="/images/ticket/first_r_not.png" class="seat--1--${first.name}" onclick="selectSeat(1, 'f', '${first.name}');">
											</c:otherwise>
										</c:choose>
									</c:when>
									<%-- 짝수 번째라면 --%>
									<c:otherwise>
										<c:choose>
											<c:when test="${ticketList.get(0).seatGrade.equals(\"퍼스트\") == false}">
												<img alt="" src="/images/ticket/first_l_false.png" class="seat--1--${first.name}" onclick="selectSeat(1, 'f', '${first.name}');">
											</c:when>
											<c:when test="${first.status == true}">
												<img alt="" src="/images/ticket/first_l_pre.png" class="seat--1--${first.name}" onclick="selectSeat(1, 'f', '${first.name}');">
											</c:when>
											<c:otherwise>
												<img alt="" src="/images/ticket/first_l_not.png" class="seat--1--${first.name}" onclick="selectSeat(1, 'f', '${first.name}');">
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<%-- 좌석별 여백 --%>
								<c:choose>
									<c:when test="${f == 1}">
										<span style="margin: 160px;"> </span>
									</c:when>
									<c:when test="${f % 2 == 1}">
										<span style="margin: 184px;"> </span>
									</c:when>
									<c:otherwise>
										<div style="height: 25px;"></div>
									</c:otherwise>
								</c:choose>
								<c:set var="f" value="${f + 1}" />
							</c:forEach>
						</div>
						<div class="f--blank--div"></div>
					</c:if>

					<!-- 비즈니스 좌석 -->
					<c:if test="${sch1BuList.isEmpty() == false}">
						<div class="b--seat">
							<c:set var="b" value="1" />
							<c:forEach var="business" items="${sch1BuList}">
								<c:choose>
									<c:when test="${ticketList.get(0).seatGrade.equals(\"비즈니스\") == false}">
										<img alt="" src="/images/ticket/business_false.png" class="seat--1--${business.name}" onclick="selectSeat(1, 'b', '${business.name}');">
									</c:when>
									<c:when test="${business.status == true}">
										<img alt="" src="/images/ticket/business_pre.png" class="seat--1--${business.name}" onclick="selectSeat(1, 'b', '${business.name}');">
									</c:when>
									<c:otherwise>
										<img alt="" src="/images/ticket/business_not.png" class="seat--1--${business.name}" onclick="selectSeat(1, 'b', '${business.name}');">
									</c:otherwise>
								</c:choose>
								<%-- 좌석별 여백 --%>
								<c:choose>
									<c:when test="${b % 6 == 0}">
										<div style="height: 53px;"></div>
									</c:when>
									<c:when test="${b % 2 == 0}">
										<span style="margin: 37px;"> </span>
									</c:when>
									<c:when test="${b % 2 == 1}">
										<span style="margin: 1px;"> </span>
									</c:when>
								</c:choose>
								<c:set var="b" value="${b + 1}" />
							</c:forEach>
						</div>
						<div class="b--blank--div"></div>
					</c:if>

					<!-- 이코노미 좌석 -->
					<div class="e--seat">
						<c:set var="e" value="1" />
						<c:forEach var="economy" items="${sch1EcList}">
							<c:choose>
								<c:when test="${ticketList.get(0).seatGrade.equals(\"이코노미\") == false}">
									<img alt="" src="/images/ticket/economy_false.png" class="seat--1--${economy.name}" onclick="selectSeat(1, 'e', '${economy.name}');">
								</c:when>
								<c:when test="${economy.status == true}">
									<img alt="" src="/images/ticket/economy_pre.png" class="seat--1--${economy.name}" onclick="selectSeat(1, 'e', '${economy.name}');">
								</c:when>
								<c:otherwise>
									<img alt="" src="/images/ticket/economy_not.png" class="seat--1--${economy.name}" onclick="selectSeat(1, 'e', '${economy.name}');">
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${e % 9 == 0}">
									<div style="height: 26px;"></div>
								</c:when>
								<c:when test="${e % 3 == 0}">
									<span style="margin: 25px;"> </span>
								</c:when>
							</c:choose>
							<c:set var="e" value="${e + 1}" />
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	
		<c:if test="${ticketList.size() == 2}">
		<!-- 왕복 시 2번째 여정 좌석 선택 -->
			<div class="airplane--div" id="sch2Airplane">
				<div class="airplane--background airplane--${ticketList.get(1).airplaneId}">
	
					<div class="seat--list">
						<div class="top--blank--div"></div>
						<!-- 퍼스트 좌석 -->
						<c:if test="${sch2FiList.isEmpty() == false}">
							<div class="f--seat">
								<c:set var="f" value="1" />
								<c:forEach var="first" items="${sch2FiList}">
									<c:choose>
										<%-- 홀수 번째라면 --%>
										<c:when test="${f % 2 == 1}">
											<c:if test="${f == 1}">
												<span style="margin: 13px;"> </span>
											</c:if>
											<c:choose>
												<c:when test="${ticketList.get(1).seatGrade.equals(\"퍼스트\") == false}">
													<img alt="" src="/images/ticket/first_r_false.png" class="seat--2--${first.name}" onclick="selectSeat(2, 'f', '${first.name}');">
												</c:when>
												<c:when test="${first.status == true}">
													<img alt="" src="/images/ticket/first_r_pre.png" class="seat--2--${first.name}" onclick="selectSeat(2, 'f', '${first.name}');">
												</c:when>
												<c:otherwise>
													<img alt="" src="/images/ticket/first_r_not.png" class="seat--2--${first.name}" onclick="selectSeat(2, 'f', '${first.name}');">
												</c:otherwise>
											</c:choose>
										</c:when>
										<%-- 짝수 번째라면 --%>
										<c:otherwise>
											<c:choose>
												<c:when test="${ticketList.get(1).seatGrade.equals(\"퍼스트\") == false}">
													<img alt="" src="/images/ticket/first_l_false.png" class="seat--2--${first.name}" onclick="selectSeat(2, 'f', '${first.name}');">
												</c:when>
												<c:when test="${first.status == true}">
													<img alt="" src="/images/ticket/first_l_pre.png" class="seat--2--${first.name}" onclick="selectSeat(2, 'f', '${first.name}');">
												</c:when>
												<c:otherwise>
													<img alt="" src="/images/ticket/first_l_not.png" class="seat--2--${first.name}" onclick="selectSeat(2, 'f', '${first.name}');">
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									<%-- 좌석별 여백 --%>
									<c:choose>
										<c:when test="${f == 1}">
											<span style="margin: 160px;"> </span>
										</c:when>
										<c:when test="${f % 2 == 1}">
											<span style="margin: 184px;"> </span>
										</c:when>
										<c:otherwise>
											<div style="height: 25px;"></div>
										</c:otherwise>
									</c:choose>
									<c:set var="f" value="${f + 1}" />
								</c:forEach>
							</div>
							<div class="f--blank--div"></div>
						</c:if>
	
						<!-- 비즈니스 좌석 -->
						<c:if test="${sch2BuList.isEmpty() == false}">
							<div class="b--seat">
								<c:set var="b" value="1" />
								<c:forEach var="business" items="${sch2BuList}">
									<c:choose>
										<c:when test="${ticketList.get(1).seatGrade.equals(\"비즈니스\") == false}">
											<img alt="" src="/images/ticket/business_false.png" class="seat--2--${business.name}" onclick="selectSeat(2, 'b', '${business.name}');">
										</c:when>
										<c:when test="${business.status == true}">
											<img alt="" src="/images/ticket/business_pre.png" class="seat--2--${business.name}" onclick="selectSeat(2, 'b', '${business.name}');">
										</c:when>
										<c:otherwise>
											<img alt="" src="/images/ticket/business_not.png" class="seat--2--${business.name}" onclick="selectSeat(2, 'b', '${business.name}');">
										</c:otherwise>
									</c:choose>
									<%-- 좌석별 여백 --%>
									<c:choose>
										<c:when test="${b % 6 == 0}">
											<div style="height: 53px;"></div>
										</c:when>
										<c:when test="${b % 2 == 0}">
											<span style="margin: 37px;"> </span>
										</c:when>
										<c:when test="${b % 2 == 1}">
											<span style="margin: 1px;"> </span>
										</c:when>
									</c:choose>
									<c:set var="b" value="${b + 1}" />
								</c:forEach>
							</div>
							<div class="b--blank--div"></div>
						</c:if>
	
						<!-- 이코노미 좌석 -->
						<div class="e--seat">
							<c:set var="e" value="1" />
							<c:forEach var="economy" items="${sch2EcList}">
								<c:choose>
									<c:when test="${ticketList.get(1).seatGrade.equals(\"이코노미\") == false}">
										<img alt="" src="/images/ticket/economy_false.png" class="seat--2--${economy.name}" onclick="selectSeat(2, 'e', '${economy.name}');">
									</c:when>
									<c:when test="${economy.status == true}">
										<img alt="" src="/images/ticket/economy_pre.png" class="seat--2--${economy.name}" onclick="selectSeat(2, 'e', '${economy.name}');">
									</c:when>
									<c:otherwise>
										<img alt="" src="/images/ticket/economy_not.png" class="seat--2--${economy.name}" onclick="selectSeat(2, 'e', '${economy.name}');">
									</c:otherwise>
								</c:choose>
	
								<c:choose>
									<c:when test="${e % 9 == 0}">
										<div style="height: 25.5px;"></div>
									</c:when>
									<c:when test="${e % 3 == 0}">
										<span style="margin: 25px;"> </span>
									</c:when>
								</c:choose>
								<c:set var="e" value="${e + 1}" />
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<!-- 오른쪽 -->
		<div style="width: 100%; margin-left: 20px" class="d-flex flex-column">
			<!-- 스케줄 정보 -->
			<!-- 첫 번째 스케줄 -->
			<div class="schedule--info" id="scheduleInfo1">
				<div>
					<ul class="info--title">
						<li><span class="material-symbols-outlined">flight</span>
						<li id="firstScheduleTitle">
							<c:choose>
								<c:when test="${ticketList.size() == 2}">
									첫 번째 여정
								</c:when>
								<c:otherwise>
									편도
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
					<div class="departure--destination--airport">
						<ul>
							<li>출발지
							<li>${sch1Info.departureAirport}
						</ul>
						<span>▶</span>
						<ul>
							<li>도착지
							<li>${sch1Info.destinationAirport}
						</ul>
					</div>
					<p class="departure--destination--date">
						${sch1Info.strDepartureDate} ~ ${sch1Info.strArrivalDate}
					</p>
					<p class="seat--grade">
						${ticketList.get(0).seatGrade}					
					</p>
					<p class="seat--count">
						성인 ${ticketList.get(0).adultCount}&nbsp;<span style="color:#585858">ㅣ</span>&nbsp;
						소아 ${ticketList.get(0).childCount}&nbsp;<span style="color:#585858">ㅣ</span>&nbsp;
						유아 ${ticketList.get(0).infantCount}
					</p>
				</div>
			</div>
			<!-- 두 번째 스케줄 -->
			<c:if test="${ticketList.size() == 2}">
				<div class="schedule--info" id="scheduleInfo2">
					<div>
						<ul class="info--title">
							<li><span class="material-symbols-outlined">flight</span>
							<li>두 번째 여정
						</ul>
						<div class="departure--destination--airport">
							<ul>
								<li>출발지
								<li>${sch2Info.departureAirport}
							</ul>
							<span>▶</span>
							<ul>
								<li>도착지
								<li>${sch2Info.destinationAirport}
							</ul>
						</div>
						<p class="departure--destination--date">
							${sch2Info.strDepartureDate} ~ ${sch2Info.strArrivalDate}
						</p>
						<p class="seat--grade">
							${ticketList.get(1).seatGrade}					
						</p>
						<p class="seat--count">
							성인 ${ticketList.get(1).adultCount}&nbsp;<span style="color:#585858">ㅣ</span>&nbsp;
							소아 ${ticketList.get(1).childCount}&nbsp;<span style="color:#585858">ㅣ</span>&nbsp;
							유아 ${ticketList.get(1).infantCount}
						</p>
					</div>
				</div>
			</c:if>
				
			<hr>
			<!-- 선택된 좌석 정보 -->
			<!-- 첫 번째 스케줄 -->
			<div class="seat--info" id="seatInfo1">
				<ul class="info--title">
					<li><span class="material-symbols-outlined">airline_seat_recline_extra</span>
					<li>선택된 좌석 정보 <span class="seat--count--span">(현재 <span id="seatCount1" class="seat--count--span">0</span>석)</span>
				</ul>
				<div class="seat--name--list"></div>
			</div>
			<div class="seat--info" id="seatInfo2">
				<ul class="info--title">
					<li><span class="material-symbols-outlined">airline_seat_recline_extra</span>
					<li>선택된 좌석 정보 <span class="seat--count--span">(현재 <span id="seatCount2" class="seat--count--span">0</span>석)</span>
				</ul>
				<br>
				<div class="seat--name--list"></div>
			</div>
			
			<!-- 다음 페이지 or 선택 완료 버튼 -->
			<div class="btn--div">
				<button type="button" class="blue--btn--middle" id="nextSeatBtn">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li style="margin-right: 4px;">다음
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">arrow_forward</span>
					</ul>
				</button>
				<button type="button" class="blue--btn--middle" id="prevSeatBtn">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">arrow_back</span>
						<li style="margin-left: 4px;">이전
					</ul>
				</button>
				<form action="/ticket/payment" method="get">
					<input type="hidden" name="adultCount">
					<input type="hidden" name="childCount">
					<input type="hidden" name="infantCount">
					<input type="hidden" name="scheduleId">
					<input type="hidden" name="seatNames">
					<input type="hidden" name="seatGrade">
					<!-- 왕복일 때에만 -->
					<c:if test="${ticketList.size() == 2}">
						<input type="hidden" name="scheduleId2">
						<input type="hidden" name="seatNames2">
						<input type="hidden" name="seatGrade2">
					</c:if>
					
					<button type="submit" class="blue--btn--middle" id="choiceCompleteBtn">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li style="margin-right: 4px;">선택 완료
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">done</span>
						</ul>
					</button>
				</form>
			</div>		
		</div>
	</div>

</main>

<script>
	// 좌석 선택 완료 버튼 누르면 같이 보낼 데이터들
	let adultCount = ${ticketList.get(0).adultCount};
	let childCount = ${ticketList.get(0).childCount};
	let infantCount = ${ticketList.get(0).infantCount};
	let scheduleId1 = ${ticketList.get(0).scheduleId};
	let seatNames1 = new Array();
	let seatGrade1 = `${ticketList.get(0).seatGrade}`;

	// 1번 스케줄에 운항하는 비행기
	let airplaneId1 = ${ticketList.get(0).airplaneId};
	// 스케줄별로 선택할 좌석 수
	let totalSeatCount = ${totalSeatCount};
	// 1번 스케줄에 현재 선택한 좌석 개수
	let seatCount1 = 0;
	// 여정 개수 (1 == 편도, 2 == 왕복)
	let scheduleCount = ${ticketList.size()};
	// 현재 여정 순서
	let scheduleNumber = 1;
	
	// 예외 방지
	let airplaneId2;
	let scheduleId2;
	let seatNames2;
	let seatGrade2;
	let seatCount2 = 0;
</script>

<!-- 왕복인 경우 -->	
<c:if test="${ticketList.size() == 2}">
	<script>
		$("#nextSeatBtn").show();
		$("#choiceCompleteBtn").hide();
	
		// 좌석 선택 완료 버튼 누르면 같이 보낼 데이터들
		scheduleId2 = ${ticketList.get(1).scheduleId};
		seatNames2 = new Array();
		seatGrade2 = `${ticketList.get(1).seatGrade}`;
		// 2번 스케줄에 운항하는 비행기
		airplaneId2 = ${ticketList.get(1).airplaneId};
		
		// 2번 스케줄에 현재 선택한 좌석 개수
		seatCount2 = 0;
	</script>
</c:if>

<script src="/js/ticket.js"></script>
<script src="/js/seat.js"></script>

<input type="hidden" name="menuName" id="menuName" value="항공권 예약">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
