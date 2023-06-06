<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

<link rel="stylesheet" href="/css/ticket.css">
<link rel="stylesheet" href="/css/dashboard.css">

<!-- 대시보드 (관리자 페이지 메인) -->

<main class="d-flex flex-column">
	<h4 id="dashboardTitle">Dashboard</h4>
	<div class="d-flex justify-content-between" style="width: 100%; margin-bottom: 20px;">
		<div class="small--board">
			<div>
				<h5 class="small--board--title"><%=LocalDateTime.now().getMonth().getValue() %>월 매출액</h5>
				<p class="number--value--p">
					<fmt:formatNumber value="${thisMonthSales}" pattern="#,###"/>원
				</p>
			</div>
			<div class="icon--div">
				<span style="margin-left: 2px;" class="material-symbols-outlined material-symbols-outlined-fill">database</span>
			</div>
		</div>	
		<div class="small--board">
			<div>
				<h5 class="small--board--title"><%=LocalDateTime.now().getMonth().getValue() %>월 신규 회원 수</h5>
				<p class="number--value--p">
					<fmt:formatNumber value="${newUserCount}" pattern="#,###"/>명
				</p>
			</div>
			<div class="icon--div">
				<span style="margin-left: 5px;" class="material-symbols-outlined material-symbols-outlined-fill">person_add</span>
			</div>
		</div>	
		<div class="small--board">
			<div>
				<h5 class="small--board--title"><%=LocalDateTime.now().getMonth().getValue() %>월 탈퇴 회원 수</h5>
				<p class="number--value--p">
					<fmt:formatNumber value="${withdrawUserCount}" pattern="#,###"/>명
				</p>
			</div>
			<div class="icon--div">
				<span style="margin-left: 5px;" class="material-symbols-outlined material-symbols-outlined-fill">person_remove</span>
			</div>
		</div>	
		<div class="small--board">
			<div>
				<h5 class="small--board--title"><%=LocalDateTime.now().getMonth().getValue() %>월 고객의 말씀</h5>
				<p class="number--value--p">
					<fmt:formatNumber value="${vocCount}" pattern="#,###"/>건
				</p>
			</div>
			<div class="icon--div">
				<span class="material-symbols-outlined material-symbols-outlined-fill">volunteer_activism</span>
			</div>
		</div>	
	</div>
	<div class="d-flex justify-content-between" style="width: 100%; margin-bottom: 20px;">
		<div class="middle--board">
			<h5 class="board--title">도착지별 이용객 수 순위</h5>
			<canvas id="routeChart"></canvas>
		</div>	
		<div class="long--board">
			<h5 class="board--title">월별 매출액 그래프</h5>
			<canvas id="salesChart"></canvas>
		</div>	
		<div class="middle--board">	
			<h5 class="board--title">개인 메모</h5>
			<textarea id="memoArea" placeholder="간단한 메모를 작성하세요.">${memo.content}</textarea>
		</div>	
	</div>
	<div class="d-flex justify-content-between" style="width: 100%;">
		<div class="middle--board" style="height: 260px;">
			<h5 class="board--title">마일리지샵 인기 브랜드</h5>
			<canvas id="brandChart"></canvas>
		</div>	
		<div class="middle--board" style="height: 260px;">
			<h5 class="board--title">지난 달 고객의 말씀 비율</h5>
			<canvas id="vocChart"></canvas>
		</div>	
		<div class="long--board" style="height: 260px;">
			<h5 class="board--title">처리되지 않은 고객의 말씀 내역</h5>
			
			<c:choose>
				<c:when test="${vocListCount != 0}">
					<p class="description--p">
						<a href="/voc/list/not/1" class="d-flex">
							<span>답변을 기다리는 고객의 말씀이</span>&nbsp;
							<span class="important--span">${vocListCount}</span>
							<span>건 존재합니다.</span>&nbsp;
							<span class="material-symbols-outlined" style="font-size: 21px; margin-top: 2px;">link</span>
						</a>
					</p>
					<table class="list--table" border="1">
						<thead>
							<tr>
								<th>유형</th>
								<th>분야</th>
								<th>제목</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${vocList}" var="voc">
								<tr id="tr${voc.id}">
									<td>${voc.type}</td>
									<td>${voc.categoryName}</td>
									<td>${voc.title}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>				
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
			
		</div>	
	</div>

</main>

<script type="text/javascript">

	// 월별 매출액 그래프 
	let salesData = JSON.parse(JSON.stringify(${salesData}));
	
	// 고객의 말씀 비율
	let vocData = JSON.parse(JSON.stringify(${vocData}));
	
	// 도착지별 이용객 수 순위
	let routeData = JSON.parse(JSON.stringify(${routeData}));
	
	// 마일리지샵 구매량 상위 n개 브랜드
	let brandData = JSON.parse(JSON.stringify(${brandData}));
	
</script>

<script src="/js/dashboard.js"></script>

<input type="hidden" name="menuName" id="menuName" value="">
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
