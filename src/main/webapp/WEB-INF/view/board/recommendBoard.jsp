<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<h1>게시판 화면</h1>

<div class="container">
	<jsp:include page="../layout/header.jsp" />
	<table class="table table-bordered">
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
	</table>
	<%-- <jsp:include page="/modal" /> --%>
	<button id="createBtn" type="button" class="btn btn-info btn-sm"
		data-toggle="modal">새 글 쓰기</button>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 id="modal-title" class="modal-title"></h4>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<td>사용자명</td>
						<td><input class="form-control" id="userName" type="text"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control" id="contents" rows="10"></textarea></td>
					</tr>					
				</table>
			</div>
			<div class="modal-footer">
				<button id="modalSubmit" type="button" class="btn btn-success">Submit</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
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
