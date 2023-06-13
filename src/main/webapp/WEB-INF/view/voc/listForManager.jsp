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

.option--h5 {
	color: gray;
}

.option--h5:hover {
	color: #1A3C7E;
	font-weight: 600;
}

.selected--option {
	color: #1A3C7E !important;
	font-weight: 600;
}

.list--table th:nth-of-type(1) {
	width: 15%;
}

.list--table th:nth-of-type(2) {
	width: 5%;
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
	<ul class="d-flex" style="margin-bottom: 20px;">
		<li style="margin-right: 40px"><h5><a href="/voc/list/not/1" class="option--h5">답변 미완료</a></h5>
		<li><h5><a href="/voc/list/processed/1" class="option--h5">답변 완료</a></h5>
	</ul>
	<c:choose>
		<c:when test="${vocList.isEmpty()}">
			<br>
			<p class="no--list--p">내역이 존재하지 않습니다.</p>
		</c:when>
		<c:otherwise>
			<table class="list--table" border="1">
				<thead>
					<tr>
						<th>작성자</th>
						<th>유형</th>
						<th>분야</th>
						<th>제목</th>
						<th>작성일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${vocList}" var="voc">
						<tr id="tr${voc.id}">
							<td>${voc.memberId}</td>
							<td>${voc.type}</td>
							<td>${voc.categoryName}</td>
							<td>${voc.title}</td>
							<td>${voc.formatCreatedAt()}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${pageCount != null}">
				<ul class="page--list">
					<c:forEach var="i" begin="1" end="${pageCount}" step="1">
						<c:choose>
							<c:when test="${i == page}">
								<c:choose>
									<c:when test="${processed == 0}">
										<li><a href="/voc/list/not/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
									</c:when>
									<c:otherwise>
										<li><a href="/voc/list/processed/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${processed == 0}">
										<li><a href="/voc/list/not/${i}">${i}</a>									
									</c:when>
									<c:otherwise>
										<li><a href="/voc/list/processed/${i}">${i}</a>									
									</c:otherwise>
								</c:choose>						
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
			</c:if>
		</c:otherwise>
	</c:choose>

	
</main>

<script>
	$(document).ready(function(){
		let pageType = ${processed};
		
		$(".option--h5").eq(pageType).addClass("selected--option");
		
		$(".list--table tbody tr").on("click", function() {
			let id = $(this).attr("id").split("tr")[1];
			
			location.href="/voc/detail/" + id;
			
		});
	});
</script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
