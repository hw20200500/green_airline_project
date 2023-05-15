<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.tr--boardList {
	text-align: center;
}
</style>

<h1>게시판 화면</h1>

<div class="container">
	<table class="table table-bordered">
		<c:choose>
			<c:when test="${boardList!=null}">
				<%-- 게시글이 있는 경우 --%>
				<table>
					<tr class="tr--boardList">
						<th>번호</th>
						<th>제목</th>
						<th>작성자id</th>
						<th>조회수</th>
						<th>작성일</th>
					</tr>
					 <c:forEach var="board" items="${boardList}">
						<tr class="tr--boardList${id}" data-toggle="modal"
							data-target="#modalDetailSelect" style="cursor: pointer;">
							<td>${board.id}</td>
							<td>${board.title}</td>
							<td>${board.userId}</td>
							<td>${board.viewCount}</td>
							<td>${board.formatDate()}</td>
						</tr>
					</c:forEach> 
					
					
				</table>
			</c:when>
			<c:otherwise>
				<%-- 게시글이 없는 경우 --%>
				<p>게시물이 없습니다.</p>
			</c:otherwise>
		</c:choose>
	</table>
	<%-- Button trigger modal --%>
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#modalWrite">글 쓰기</button>

	<jsp:include page="/WEB-INF/view/board/modal.jsp" flush="false" />
	<jsp:include page="/WEB-INF/view/board/modalDetail.jsp" flush="false" />

</div>
<!-- 
=== todo ===
페이징처리
제품 상세보기(페이지 이동)
 - 찜, 조회수
파일 업로드 
createdAt 시간 yyyy-MM-dd로 변경
-->

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
