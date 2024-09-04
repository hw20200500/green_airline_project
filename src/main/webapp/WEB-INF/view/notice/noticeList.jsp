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
.btn--primary {
	border: none;
	background-color: #8ABBE2;
	color: white;
	width: 80px
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
	height: 60px;
	display: flex;
	justify-content: center;
	border: none;
	border-bottom: 1px solid #ddd;
	font-size: 30px;
}

.notice--category--wrap {
	border-radius: 10px;
	display: flex;
	justify-content: space-between;
	margin-bottom: 30px;
	width: 1180px;
}

.noticeList--name--wrap {
	font-size: 20px;
	margin-bottom: 5px;
	display: flex;
	justify-content: space-between;
}

.notice--h4 {
	display: flex;
	flex-direction: column;
	width: 234px;
	height: 79px;
}

.category--id--st {
	display: block;
	width: 240px;
	height: 70px;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #f8f9fc;
	color: black;
}

.category--id--st:hover {
	background-color: #ddd;
	color: black;
}

.selected--category {
	background-color: #8ABBE2;
	color: white;
}

.noticeList--title--date--wrap a{
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.search--btn{
	font-size: 22px;
}
</style>

<div>

	<main>
		<h2 class="page--title">공지사항</h2>
		<hr>
		<br>
		
		<div class="noticeHeader--keyword--wrap">
			<div class="keyword--search--wrap">
				<form action="/notice/noticeSearch" method="get" class="keyword--search--form">
					<input type="text" id="keyword" name="keyword" placeholder="키워드 검색">
					<button class="search--btn btn btn--primary" type="submit">검색</button>
				</form>
			</div>

		</div>


		<div class="notice--category--wrap">
			<c:forEach var="categoryList" items="${categoryList}">
				<c:choose>
					<c:when test="${category == categoryList.id}">
						<h4 class="notice--h4">
							<a href="/notice/noticeCategory/${categoryList.id}" class="category--id--st selected--category" style="background-color: #8ABBE2; color: white;">${categoryList.name}</a>
						</h4>
					</c:when>
					<c:otherwise>
						<h4 class="notice--h4">
							<a href="/notice/noticeCategory/${categoryList.id}" class="category--id--st">${categoryList.name}</a>
						</h4>
					</c:otherwise>
				</c:choose>
			</c:forEach>

		</div>


		<div class="notice--noticeList--wrap">
			<c:forEach var="noticeList" items="${noticeList}">
				<input type="hidden" name="id" value="${noticeList.id}">
				<div class="noticeList--name--wrap">
					<div class="noticeList--title--date--wrap">
						<a href="/notice/noticeDetail/${noticeList.id}"> [ ${noticeList.name} ] ${noticeList.title} </a>
					</div>
					<div class="noticeList--title--date--wrap">
						<a href="/notice/noticeDetail/${noticeList.id}">${noticeList.dateFormatType2()}</a>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- 페이지 숫자(< 3 4 5 >) -->
		<div style="display: block; text-align: center; padding: 10px; color: #174481;">
			<c:if test="${paging.startPage != 1}">
				<a href="/notice/noticeList?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage}">
						<b>${p}</b>
					</c:when>
					<c:when test="${p != paging.nowPage}">
						<a href="/notice/noticeList?nowPage=${p}&cntPerPage=${paging.cntPerPage}" style="padding: 10px; color: #174481;">${p}</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<a href="/notice/noticeList?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">&gt;</a>
			</c:if>
		</div>

		<c:if test="${principal.userRole.equals(\"관리자\")}">
			<div>
				<button class="btn btn--primary" onclick="location.href='/notice/write'">글 작성</button>
			</div>
		</c:if>
	</main>

	<script src="/js/notice.js"></script>
</div>



<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
