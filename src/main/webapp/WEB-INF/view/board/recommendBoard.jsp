<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.tr--boardList, tr--boardList--title {
	text-align: center;
}
</style>
<main>
	<h1>게시판 화면</h1>
	<div class="container">
		<table class="table table-bordered">
			<c:choose>
				<c:when test="${boardList!=null}">
					<%-- 게시글이 있는 경우 --%>
					<table>
						<tr class="tr--boardList--title">
							<th>번호</th>
							<th>제목</th>
							<th>작성자id</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
						<c:forEach var="board" items="${boardList}">
							<tr class="tr--boardList" data-toggle="modal"
								data-target="#modalDetail" id="boardDetail${board.id}"
								style="cursor: pointer;">
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
		<button type="button" class="btn btn-primary"
			onclick="location.href='/board/insert'">글 쓰기</button>
	</div>
</main>

<%-- Modal --%>
<form action="/board/detail/${board.id}" method="get">
	<div class="modal fade" id="modalDetail" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">디테일한 여행 일지</h5>
					<button type="button" class="close" aria-label="Close"
						data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<%-- 모달 내용 입력 --%>
					<table class="table_detail" border="1">
						<tbody>
							<tr>
								<td class="board--title"></td>
							</tr>
							<tr>
								<td class="board--content"></td>
							</tr>
							<tr>
								<td class="board--userId"></td>
							</tr>
							<tr>
								<td class="board--viewCount"></td>
							</tr>
							<tr>
								<td class="board--date"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</form>
<script src="/js/board.js"></script>
<!-- 
=== TODO ===
페이징처리
찜, 조회수
조회수 : 쿠키시간 24시간(다른 게시글을 들어가도 24시-현재시간)만큼 유지시켜서
쿠키 유지시간 늘어나는 경우 방지
파일 업로드 (드래그앤드롭)
추천순, 조회수 많은순 필터링 기능
-->

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
