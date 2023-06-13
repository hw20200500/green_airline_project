<%@page import="com.green.airline.utils.Define"%>
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

<!-- 회원/비회원용 고객센터 페이지 -->

<style>
.main--img--div {
	min-width: 100%;
	height: 360px;
	background-size: 100%;
	position: relative;
	background: url("/images/customer_center.jpg");
	background-size: cover;
	margin-top: -30px;
}
main {
	padding: 0;
	margin-bottom: -26px;
	width: 100%;
}
.main--img--div::before {
	content: "";
	opacity: 0.55;
	position: absolute;
	top: 0px;
	left: 0px;
	right: 0px;
	bottom: 0px;
	background-color: #000;
	color: initial;
}

.center--menu--btn--div {
	padding: 20px 0 90px;
	margin: 0 auto;
	background-color: #f0f0f0;
	height: 310px;
	text-align: center;
}

.img--inner--title {
	color: white;
	position: absolute;
	left: 380px;
	top: 80px;
	text-shadow: 0 0 3px 3px rgba(0, 0, 0, 0.2);
	font-size: 35px;
}

.center--menu--btn {
	border: none;
	background-color: white;
	width: 260px;
	height: 150px;
	position: relative;
	margin: 50px 15px;
}

.center--menu--btn .material-symbols-outlined {
	position: absolute;
	font-size: 60px;
	bottom: 15px;
	right: 15px;
	color: #A3A6AD;
}

.center--menu--btn h4 {
	position: absolute;
	top: 20px;
	left: 20px;
	font-size: 23px;
	color: #404040;
}

</style>

<main class="d-flex flex-column">
	<div>
		<div class="main--img--div">
			<h1 class="img--inner--title">고객센터</h1>
		</div>
		<div class="center--menu--btn--div">
			<div class="d-flex justify-content-center align-items-center">
				<button class="center--menu--btn" onclick="location.href='/notice/noticeList'">
					<h4>공지사항</h4>
					<p></p>
					<span class="material-symbols-outlined" >campaign</span>
				</button>
				<button class="center--menu--btn" onclick="location.href='/faq/faqList'">
					<h4>자주 묻는 질문</h4>
					<span class="material-symbols-outlined" >live_help</span>
				</button>
				<button class="center--menu--btn" onclick="location.href='/voc/list/1'">
					<h4>고객의 말씀</h4>
					<span class="material-symbols-outlined" >mark_as_unread</span>
				</button>
			</div>
		</div>
	</div>

</main>

<input type="hidden" name="menuName" id="menuName" value="고객센터">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
