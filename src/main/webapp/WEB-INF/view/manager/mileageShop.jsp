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


<!-- 마일리지샵 메인 페이지 -->

<main>
	<h2 class="page--title">마일리지샵</h2>
	<hr>
	<br>
	<div class="service--div">
		<ul class="service--ul" onclick="location.href='/product/productMain/clasic'">
			<li><span class="material-symbols-outlined">fastfood</span>
			<li>상품 목록
		</ul>
		<ul class="service--ul" onclick="location.href='/product/registration'">
			<li><span class="material-symbols-outlined">add_business</span>
			<li>상품 등록
		</ul>
 		<ul class="service--ul" onclick="location.href='/manager/productBuyList'">
			<li><span class="material-symbols-outlined">shopping_cart</span>
			<li>상품 판매 내역
		</ul> 
	</div>

</main>



<input type="hidden" name="menuName" id="menuName" value="마일리지샵">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
