<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
</style>
<div>
	<main>
		<div>
			<h1>공지사항 상세 페이지</h1>

			<div>${noticeResponseDto.title}</div>
			<div>${noticeResponseDto.name}|${noticeResponseDto.dateFormat()}</div>
			<div>${noticeResponseDto.content}</div>
		</div>
		<c:if test="${principal.userRole.equals(\"관리자\")}">
			<div>
				<button class="btn btn-primary" onclick="location.href='/notice/noticeUpdate?id=${id}'">수정</button>
				<button class="btn btn-danger" onclick="location.href='/notice/noticeDelete?id=${id}'">삭제</button>
			</div>
		</c:if>
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
