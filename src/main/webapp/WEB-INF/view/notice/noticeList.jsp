<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div>

	<main>
			<div>
				<h1>공지사항</h1>
			</div>

			<div>
				<c:forEach var="categoryList" items="${categoryList}">
					<a href="#">${categoryList.name}</a>
				</c:forEach>
			</div>

			<div>
			<form action="/notice" method="get">
				<h3>키워드 검색</h3>
				<input type="text" name="keyword" placeholder="검색어를 입력해주세요">
				<button class="search--btn" type="submit">검색하기</button>
			</form>
		</div>

			<div>
				<c:forEach var="noticeList" items="${noticeList}">
					<div>
						<a href="/notice/noticeDetail/${noticeList.id}">${noticeList.title}</a>
					</div>
					<div>
						<a href="/notice/noticeDetail/${noticeList.id}">${noticeList.name}</a> | <a href="/notice/noticeDetail/${noticeList.id}">${noticeList.dateFormat()}</a>
					</div>
				</c:forEach>
			</div>
	</main>

	<script src="/js/notice.js"></script>
</div>



<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
