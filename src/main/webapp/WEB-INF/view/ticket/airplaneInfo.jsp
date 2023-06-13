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

<link rel="stylesheet" href="/css/airplane.css">

<!-- 항공기 좌석 배치도 -->

<main>
	<h2 class="page--title">항공기 정보</h2>
	<hr>
	<br>
	
	<div style="width: 100%; position: relative; margin-bottom: 70px;">
		<h1 class="airplane--name">
			<span class="material-symbols-outlined">flight</span>&nbsp;
			<span>${airplaneName}</span>
		</h1>
		<h5 class="total--seat--count">좌석 배치도&nbsp;(${totalSeatCount}석)</h5>
		<div class="select--div">
			<select class="select--airplane--name">
				<option>다른 기종 선택</option>
				<c:forEach var="airplane" items="${airplaneList}">
					<option>${airplane.name}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="d-flex justify-content-center align-items-start" style="width: 100%;">
		<div class="airplane--img--div">
			<img alt="" src="/images/airplane/airplane${id}.png">
		</div>
		<div class="airplane--description">
			<h6>
				<span style="font-size: 18px;">범례</span>&nbsp;
				<span class="material-symbols-outlined material-symbols-outlined-fill" style="font-size: 20px;">bookmark</span>&nbsp;
			</h6>
			<ul>
				<li>
					<img alt="" src="/images/airplane/icon1.png">
					<span>갤리</span>
				</li>
				<li>
					<img alt="" src="/images/airplane/icon2.png">
					<span>화장실</span>
				</li>
				<li>
					<img alt="" src="/images/airplane/icon3.png">
					<span>장애인용 화장실</span>
				</li>
			</ul>
				
			<hr>
			<ul>
				<c:if test="${economy != null}">
					<li class="ec--li"><img alt="" src="/images/ticket/economy_not.png"><span>이코노미 좌석&nbsp;(총 ${economy}석)</span>
				</c:if>
				<c:if test="${business != null}">
					<li class="bu--li"><img alt="" src="/images/ticket/business_not.png"><span>비즈니스 좌석&nbsp;(총 ${business}석)</span>
				</c:if>
				<c:if test="${first != null}">
					<li class="fi--li"><img alt="" src="/images/ticket/first_r_not.png"><span>퍼스트 좌석&nbsp;(총 ${first}석)</span>
				</c:if>
			</ul>
		</div>
	</div>
</main>

<script>
$(".select--airplane--name").on("change", function() {
	let index = $(this).prop("selectedIndex");
	location.href=`/airplane/info/\${index}`;
});

let id = ${id};

if (id == 1 || id == 4 || id == 5) {
	$(".airplane--img--div img").css("margin-left", "3px");
	
}
</script>

<input type="hidden" name="menuName" id="menuName" value="항공기 정보">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
