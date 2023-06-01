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
.container {
	text-align: center;
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.modal-dialog.modal-fullsize {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

.modal-content.modal-fullsize {
	height: auto;
	min-height: 100%;
	border-radius: 0;
}

.img {
	width: 150px;
	height: 150px;
}

.td--img {
	padding: 5px 20px;
}

.td--board {
	padding: 10px 20px;
}

.board--table {
	flex-wrap: wrap;
}
</style>
<main>
	<h1>게시판 화면</h1>
	<div class="container">
		<c:choose>
			<c:when test="${boardList!=null}">
				<%-- 게시글이 있는 경우 --%>
				<div class="board--table d-flex">
					<c:forEach var="board" items="${boardList}">
						<div class="tr--boardList" data-toggle="modal"
							data-target="#modalDetail" id="boardDetail${board.id}"
							style="cursor: pointer;">
							<div class="td--img">
								<img src="<c:url value="${board.thumbnailImage()}"/>" alt=""
									class="img">
							</div>
							<div class="td--board d-flex justify-content-between">
								<div>${board.viewCount}</div>
								<div>${board.title}</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<%-- 게시글이 없는 경우 --%>
				<p>게시물이 없습니다.</p>
			</c:otherwise>
		</c:choose>
	</div>
	<c:choose>
		<c:when test="${principal != null}">
			<button type="button" class="btn btn-primary"
				onclick="location.href='/board/insert'">글 쓰기</button>
		</c:when>
		<c:otherwise>
			<%-- 미로그인시 버튼 안보이게 처리 --%>
		</c:otherwise>
	</c:choose>
</main>
<%-- Modal --%>
<div class="modal fade" id="modalDetail" data-backdrop="static"
	data-keyboard="false" tabindex="-1"
	aria-labelledby="myFullsizeModalLabel" aria-hidden="true">
	<div
		class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
		<div class="modal-content modal-fullsize">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">그린에어 여행일지</h5>
				<button type="button" class="close" aria-label="Close"
					data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<%-- 모달 내용 입력 --%>
				<!-- 
				TODO
				1. id null 값 확인해서 고치기
				2. 수정 할 화면 불러오기 (게시물 번호로 title, content 불러오기)
				3. principal == userId 확인해서 내가 쓴 게시물만 수정, 삭제버튼 나오게하기
				 -->
				<c:choose>
					<c:when test="${principal != null}">
						<input type="hidden" name="boardId">
						<button type="button" class="btn btn-primary" id="updateButton">수정하기</button>
						<button type="button" class="btn btn-primary" id="deleteButton">삭제하기</button>
					</c:when>
					<c:otherwise>

					</c:otherwise>
				</c:choose>
				<div class="board--title"></div>
				<div class="board--content"></div>
				<div class="board--userId"></div>
				<div class="board--viewCount"></div>
				<!-- 게시물id 가져와서 경로에 넣어주기 -->
				<%
				String boardId = request.getParameter("boardId");
				%>
				<img src="/images/like/like.png" class="board--heartCount"
					id="boardDetail<%=boardId%>"
					style="cursor: pointer; width: 30px; height: 30px;"></img>
				<div class="board--heartCount" id="boardDetail<%=boardId%>"></div>
			</div>
		</div>
	</div>
</div>

<script src="/js/board.js"></script>

<!-- 
=== TODO ===
1. 페이징처리

2-1. 찜 + 조회수 / 게시물 = 높은 숫자 게시물 5개만
상위에 보여주기

2-2 회원만 찜 누를 수 있게하기
// principal이 null이 아닐때만 img태그가 보이게하기
// 비회원은 찜 누르면 로그인창으로

4. 추천순, 조회수 많은순 필터링 기능
-->

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
