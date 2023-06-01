<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<style>
</style>
<main>
	<div>
		<h1>위탁 수하물 신청 내역 (수정 및 삭제)</h1>
		<c:if test="">
		
		</c:if>		
	</div>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>