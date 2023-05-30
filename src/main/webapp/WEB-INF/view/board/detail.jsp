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
<div>
	<main>
		<h1>게시글 상세보기</h1>
		
		<div>${boardDto.title}</div>
		<div>${boardDto.content}</div>
		
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
