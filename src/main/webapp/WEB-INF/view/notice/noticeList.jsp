<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
.btn-primary {
	background-color: #174481;
	border: none;
}

.notice--header {
	margin-bottom: 20px;
	display: flex;
	justify-content: center;
}

.keyword--search--wrap {
	padding: 20px;
	margin-bottom: 50px;
}

.keyword--search--form {
	display: flex;
	justify-content: center;
}

#keyword {
	width: 500px;
	display: flex;
	justify-content: center;
	border: none;
	border-bottom: 2px solid black;
	font-size: 30px;
}

.notice--category--wrap {
	display: flex;
	justify-content: space-between;
	margin-bottom: 30px;
}

.noticeList--name--wrap {
	font-size: 20px;
}
</style>

<div>

	<main>
		<div class="noticeHeader--keyword--wrap">

			<div class="notice--header">
				<h2>공지사항</h2>
			</div>

			<div class="keyword--search--wrap">
				<form action="/notice/noticeSearch" method="get" class="keyword--search--form">
					<input type="text" id="keyword" name="keyword" placeholder="키워드 검색">
					<button class="search--btn btn btn-primary" type="submit">검색</button>
				</form>
			</div>

		</div>
		<div class="notice--category--wrap">
			<c:forEach var="categoryList" items="${categoryList}">
				<h4>
					<a href="/notice/noticeCategory/${categoryList.id}">${categoryList.name}</a>
				</h4>
			</c:forEach>
		</div>


		<div class="notice--noticeList--wrap">
			<c:forEach var="noticeList" items="${noticeList}">
			<input type="hidden" name="id" value="${noticeList.id}">
				<div class="noticeList--name--wrap">
					<a href="/notice/noticeDetail/${noticeList.id}"> [ ${noticeList.name} ] ${noticeList.title}</a>
				</div>
			</c:forEach>
		</div>
		
		<!-- 페이지 숫자(< 3 4 5 >) -->
		<div style="display: block; text-align: center;">		
			<c:if test="${paging.startPage != 1}">
				<a href="/notice/noticeList?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage}">
						<b>${p}</b>
					</c:when>
					<c:when test="${p != paging.nowPage}">
						<a href="/notice/noticeList?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<a href="/notice/noticeList?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">&gt;</a>
			</c:if>
		</div>

		<c:if test="${principal.userRole.equals(\"관리자\")}">
			<div>
				<button class="btn btn-primary" onclick="location.href='/notice/noticeInsert'">글 작성</button>
			</div>
		</c:if>
	</main>

	<script src="/js/notice.js"></script>
</div>



<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
