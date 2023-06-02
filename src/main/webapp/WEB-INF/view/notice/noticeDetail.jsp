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

<input type="hidden" name="menuName" id="menuName" value="공지사항">

<style>
</style>
<div>
	<main>
		<div>
			<input type="hidden" name="id" value="${noticeList.id}">
			<h1>공지사항 상세 페이지</h1>

			<div>${noticeList.title}</div>
			<div>${noticeList.name}</div>
			<div>${noticeList.content}</div>
		</div>
		<c:if test="${principal.userRole.equals(\"관리자\")}">
			<div>
				<button class="btn btn-primary"
					onclick="location.href='/notice/noticeUpdate?id=${id}'">수정</button>
				<button class="btn btn-danger"
					onclick="location.href='/notice/noticeDelete?id=${id}'">삭제</button>
			</div>
		</c:if>
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
