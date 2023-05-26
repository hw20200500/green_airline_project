<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
>>>>>>> feature/board
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
</style>
<div>
	<main>
<<<<<<< HEAD
		<div>
			<h1>공지사항 상세 페이지</h1>

			<div>${noticeResponseDto.title}</div>
			<div>${noticeResponseDto.name}|${noticeResponseDto.dateFormat()}</div>
			<div>${noticeResponseDto.content}</div>
		</div>
=======
		<h1>공지사항 상세 페이지</h1>

		<div>${noticeResponseDto.title}</div>
		<div>${noticeResponseDto.name}|${noticeResponseDto.dateFormat()}</div>
		<div>${noticeResponseDto.content}</div>
>>>>>>> feature/board
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
