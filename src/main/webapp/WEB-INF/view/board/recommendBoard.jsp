<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<link rel="stylesheet" href="/css/recommendBoard.css">

<main>
	<h2 class="page--title">여행일지</h2>
	<hr>
	<br>

	<div class="container">
		<div class="popular--board">
			<h4 class="h4--title">인기 게시물</h4>
			<div class="board--table d-flex">
				<c:forEach var="board" items="${popularBoard}">
					<div class="popular--board--content">
						<div class="tr--boardList" data-toggle="modal" data-target="#modalDetail" id="boardDetail${board.id}" style="cursor: pointer;">
							<div class="td--img">
								<img src="<c:url value="${board.thumbnailImage()}"/>" alt="" class="popular--img">
							</div>
							<div class="td--board">
								<div class="board--title">${board.title}</div>
								<div>
									<img src="/images/like/eye.png">&nbsp;${board.numberFormat()}
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

		</div>
		<div class="basic--board">
			<h4 class="h4--title" style="margin-top: 50px;">여행일지</h4>
			<c:choose>
				<c:when test="${boardList != null && not empty boardList}">
					<div class="board--table d-flex">
						<c:forEach var="board" items="${boardList}">
							<div class="tr--boardList" data-toggle="modal" data-target="#modalDetail" id="boardDetail${board.id}" style="cursor: pointer;">
								<div class="td--img">
									<img src="<c:url value="${board.thumbnailImage()}"/>" alt="" class="img">
								</div>
								<div class="td--board">
									<div class="board--title">${board.title}</div>
									<div>
										<img src="/images/like/eye.png">&nbsp;${board.numberFormat()}</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<p>게시물이 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>
		<c:choose>
			<c:when test="${principal != null and !\"관리자\".equals(principal.userRole)}">
				<div class="btn--write d-flex flex-row-reverse" style="padding: 20px;">
					<button type="button" class="btn btn-primary p-2" onclick="location.href='/board/insert'">글 쓰기</button>
				</div>
			</c:when>
			<c:otherwise>

			</c:otherwise>
		</c:choose>
	</div>

	<div style="display: block; text-align: center;">

		<c:if test="${pageCount != null}">
			<ul class="page--list">
				<c:forEach var="i" begin="1" end="${pageCount}" step="1">
					<c:choose>
						<c:when test="${i == page}">
							<li><a href="/board/list/${i}" style="font-weight: 700; color: #007bff">${i}</a>
						</c:when>
						<c:otherwise>
							<li><a href="/board/list/${i}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</c:if>
	</div>

</main>
<%-- Modal --%>
<div class="modal fade" id="modalDetail" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="myFullsizeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title">그린에어 여행일지</h2>
				<button type="button" class="close" aria-label="Close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<%-- 모달 내용 입력 --%>
				<input type="hidden" name="boardId">
				<div class="board--user--date">

					<p style="color: #808080;">작성자 &ensp;</p>
					<div class="board--userId" style="justify-content: right; padding-right: 5px; color: #808080;"></div>

					<div class="board--date" style="justify-content: right; padding-right: 5px; color: #808080;"></div>
				</div>
				<div class="board--heart-eye d-flex align-items-center">

					<h2 class="board--title--modal p-2 mr-auto"></h2>

					<div>
						<img src="/images/like/eye.png">
					</div>
					<div class="board--viewCount p-2"></div>

					<img src="/images/like/like.png" class="board--heartCount d-flex jflex-row-reverse" style="cursor: pointer; width: 25px; height: 25px;">
					<div class="board--heartCount p-2"></div>
				</div>

				<div class="board--content" style="text-align: center;"></div>


				<%-- 비동기통신으로 값 넘겨주기 --%>
				<input type="hidden" id="userRole" value="${principal.userRole}"> <input type="hidden" id="managerRole" value="관리자"> <input type="hidden" id="loginUserId" value="${principal.id}">
				<br> <br> <br> <br> <br> <br>
				<div class="modal--upDelete">
					<button type="button" class="btn btn-primary" id="updateButton" style="display: none; margin-right: 10px;">수정하기</button>
					<button type="button" class="btn btn-primary" id="deleteButton" style="display: none;">삭제하기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="/js/board.js"></script>

<!-- 
=== TODO ===
1. 페이징처리

2. 찜 + 조회수 / 게시물 = 높은 숫자 게시물 5개만
상위에 보여주기


3. css 제목 ...처리 

4. 추천순, 조회수 많은순 필터링 기능

5. 내가 작성한 게시물만 조회

-->

<input type="hidden" name="menuName" id="menuName" value="여행일지">
<%-- 회원만 찜 누를 수 있음 --%>
<c:if test="${principal == null}">
	<script>
		$(".board--heartCount").on("click", function() {
			let loginConfirm = confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?');
			
			if (loginConfirm) {
				location.href = '/login';
			} else {
				return false;
			}
		});
	</script>
</c:if>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
