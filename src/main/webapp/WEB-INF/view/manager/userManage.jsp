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


<!-- 회원관리 메인 페이지 -->

<main>
	<h2 class="page--title">회원 및 관리자 관리</h2>
	<hr>
	<br>
	
	<div class="service--div">
		<ul class="service--ul" onclick="location.href='/manager/memberList/1'">
			<li><span class="material-symbols-outlined">person_search</span>
			<li>회원 정보 조회
		</ul>
		<ul class="service--ul" onclick="location.href='/manager/list/1'">
			<li><span class="material-symbols-outlined">manage_accounts</span>
			<li>관리자 정보 조회
		</ul>
		<ul class="service--ul" onclick="location.href='/manager/registration'">
			<li style="margin-left: 13px;"><span class="material-symbols-outlined">person_add</span>
			<li>관리자 등록
		</ul>
	</div>

</main>



<input type="hidden" name="menuName" id="menuName" value="회원 관리">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
