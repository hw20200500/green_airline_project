<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<h1>게시판 화면</h1>
<c:choose>
	<c:when test="${boardList!=null}">
		<!-- 게시글이 있는 경우 -->
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="board" items="${boardList}">
				<tr>
					<td>${board.id}</td>
					<td>${board.title}</td>
					<td>${board.userId}</td>
					<td>${board.createdAt}</td>
					<td>${board.viewCount}</td>
				</tr>
			</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
	<!-- 게시물이 없는 경우 -->
		<p>게시물이 없습니다.</p>
	</c:otherwise>
</c:choose>





<!-- 
=== todo ===
페이징처리
제품 상세보기(페이지 이동)
 - 찜, 조회수
파일 업로드 
createdAt 시간 yyyy-MM-dd로 변경
-->

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
