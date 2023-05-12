<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<!-- 좌석 선택 페이지 -->
<style>
	main {
		padding: 30px;
	}
	
	.seat--list {
		min-width: 600px;
	}
	
	.e--seat img {
		width: 70px;
		height: 70px;
	}
	
	.b--seat img {
		width: 89px;
		height: 135px;
	}
</style>

<div>
	
	<!-- 여기 안에 쓰기 -->
	<main class="d-flex">
		<div class="seat--list">
			<p> 좌석 ${seatCount}개 선택 가능 </p>
			<div class="b--seat">
				<c:set var="b" value="1"/>
				<c:forEach var="business" items="${businessList}">
					<c:choose>
						<%-- 홀수 번째라면 왼쪽 문 --%>
						<c:when test="${b%2 == 1}">
							<c:choose>
								<c:when test="${business.status == true}">
									<img alt="" src="/images/ticket/business_l_pre.png" class="business--seat--${business.name}" onclick="selectSeat('b', '${business.name}');">
								</c:when>
								<c:otherwise>
									<img alt="" src="/images/ticket/business_l_not.png" class="business--seat--${business.name}" onclick="selectSeat('b', '${business.name}');">
								</c:otherwise>
							</c:choose>
						</c:when>
						<%-- 짝수 번째라면 오른쪽 문 --%>
						<c:otherwise>
							<c:choose>
								<c:when test="${business.status == true}">
									<img alt="" src="/images/ticket/business_r_pre.png" class="business--seat--${business.name}" onclick="selectSeat('b', '${business.name}');">
								</c:when>
								<c:otherwise>
									<img alt="" src="/images/ticket/business_r_not.png" class="business--seat--${business.name}" onclick="selectSeat('b', '${business.name}');">
								</c:otherwise>
							</c:choose>
							<span style="margin: 30px;"> </span>
						</c:otherwise>
					</c:choose>
					<c:set var="b" value="${b + 1}"/>
				</c:forEach>
			</div>
			
			<br>
			
			<div class="e--seat">
				<c:set var="e" value="1"/>
				<c:forEach var="economy" items="${economyList}">
					<c:choose>
						<c:when test="${economy.status == true}">
							<img alt="" src="/images/ticket/economy_pre.png" class="economy--seat--${economy.name}" onclick="selectSeat('e', '${economy.name}');">
						</c:when>
						<c:otherwise>
							<img alt="" src="/images/ticket/economy_not.png" class="economy--seat--${economy.name}" onclick="selectSeat('e', '${economy.name}');">
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${e % 6 == 0}">
							<div style="margin: 20px;"></div>
						</c:when>
						<c:when test="${e % 3 == 0}">
							<span style="margin: 50px;"> </span>
						</c:when>
					</c:choose>
					<c:set var="e" value="${e + 1}"/>
				</c:forEach>
				</div>
		</div>
		
		<div class="seat--info">
			<br>
			<br>
			
		</div>
		
	</main>

</div>

<script>
	let seatCount = ${seatCount};
	let scheduleId = ${scheduleId};
</script>

<script src="/js/ticket.js"></script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
