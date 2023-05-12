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
	
	.seat--list img {
		width: 70px;
		height: 70px;
	}
</style>

<div>
	
	<!-- 여기 안에 쓰기 -->
	<main class="d-flex">
		<div class="seat--list">
			<p> 좌석 ${seatCount}개 선택 가능 </p>
			<c:forEach var="i" begin="1" end="30">
				<img alt="" src="/images/economy_not.png" class="economy--seat--${i}" onclick="selectSeat(${i});">
				<c:choose>
					<c:when test="${i % 6 == 0}">
						<div style="margin: 20px;"></div>
					</c:when>
					<c:when test="${i % 3 == 0}">
						<span style="margin: 50px;"> </span>
					</c:when>
				</c:choose>
			</c:forEach>
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
