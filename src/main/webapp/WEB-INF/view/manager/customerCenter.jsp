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

<link rel="stylesheet" href="/css/manager.css">


<!-- 고객센터 메인 페이지 -->

<main>
	<h2 class="page--title">고객센터</h2>
	<hr>
	<br>
	
	<div class="service--div">
		<ul class="service--ul" onclick="location.href='/notice/noticeList'">
			<li><span class="material-symbols-outlined">campaign</span>
			<li>공지사항
		</ul>
		<ul class="service--ul" onclick="location.href='/faq/faqList'">
			<li><span class="material-symbols-outlined">live_help</span>
			<li>자주 묻는 질문
		</ul>
		<ul class="service--ul" onclick="location.href='/voc/list/not/1'">
			<li><span class="material-symbols-outlined">mark_as_unread</span>
			<li>고객의 말씀
		</ul>
	</div>

</main>



<input type="hidden" name="menuName" id="menuName" value="고객센터">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
