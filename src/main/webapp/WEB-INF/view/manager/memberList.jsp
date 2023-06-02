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


<!-- 회원정보 조회 -->

<main>

	<h2>회원정보 조회</h2>
	<hr>
	<br>
	<div>
		회원정보 조회, 관리자 등록
	</div>

</main>



<input type="hidden" name="menuName" id="menuName" value="회원정보 조회">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
