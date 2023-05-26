<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
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
