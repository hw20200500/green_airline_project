<%@page import="com.green.airline.utils.Define"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<link rel="stylesheet" href="/css/ticket.css">

<input type="hidden" name="menuName" id="menuName" value="고객의 말씀">

<style>
.list--table th:nth-of-type(1) {
	width: 14%;
}

.list--table th:nth-of-type(2) {
	width: 6%;
}

.list--table th:nth-of-type(3) {
	width: 17%;
}

.list--table td:nth-of-type(4) {
	width: 50%;
	text-align: left;
	padding-left: 10px;
	max-width: 572px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.list--table th:nth-of-type(5) {
	width: 13%;
}

.list--table tbody tr:hover {
	font-weight: 500;
	cursor: pointer;
}
</style>

<!-- 해당 사용자가 작성한 문의 글 목록 -->

<main class="d-flex flex-column">
	<h2 class="page--title">고객의 말씀</h2>
	<hr>
	<br>
	<h5 class="middle--title" style="margin-left: -3px;">
		<span class="material-symbols-outlined" style="font-size: 27px; margin-right: 4px;">description</span>
		<span>작성한 글 목록</span>
	</h5>
	<c:choose>
		<c:when test="${vocList.isEmpty()}">
			<br>
			<p class="no--list--p">작성 내역이 존재하지 않습니다.</p>
		</c:when>
		<c:otherwise>
			<table class="list--table" border="1">
				<thead>
					<tr>
						<th>작성일자</th>
						<th>유형</th>
						<th>분야</th>
						<th>제목</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${vocList}" var="voc">
						<tr id="tr${voc.id}">
							<td>${voc.formatCreatedAt()}</td>
							<td>${voc.type}</td>
							<td>${voc.categoryName}</td>
							<td>${voc.title}</td>
							<td>
								<c:choose>
									<c:when test="${voc.answerId == null}">
										<span style="font-weight: 500; color: #c6c6c6;">처리중</span>
									</c:when>
									<c:otherwise>
										<span style="font-weight: 500; color: #436195;">답변완료</span>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${pageCount != null}">
				<ul class="page--list">
					<c:forEach var="i" begin="1" end="${pageCount}" step="1">
						<c:choose>
							<c:when test="${i == page}">
								<li><a href="/voc/list/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
							</c:when>
							<c:otherwise>
								<li><a href="/voc/list/${i}">${i}</a>									
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
			</c:if>
		</c:otherwise>
	</c:choose>
	
	<div class="d-flex justify-content-end">
		<button type="button" class="blue--btn--small" onclick="location.href='/voc/write'" style="margin-top: -30px;">
			<ul class="d-flex justify-content-center" style="margin: 0;">
				<li style="margin-right: 4px;">고객의 말씀 작성
				<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">edit</span>
			</ul>
		</button>
	</div>

</main>

<script>
	$(document).ready(function() {
		$(".list--table tbody tr").on("click", function() {
			let id = $(this).attr("id").split("tr")[1];
			
			location.href="/voc/detail/" + id;
			
		});
	});
</script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
