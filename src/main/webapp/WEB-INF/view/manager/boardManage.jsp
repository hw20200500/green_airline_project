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


<!-- 게시판관리 메인 페이지 -->

<main>
	<h2 class="page--title">게시판 관리</h2>
	<hr>
	<br>
	
	<div class="service--div">
		<ul class="service--ul" onclick="location.href='/board/list/1'">
			<li><span class="material-symbols-outlined">edit_calendar</span>
			<li>여행일지 게시판
		</ul>
	</div>

</main>



<input type="hidden" name="menuName" id="menuName" value="게시판 관리">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
