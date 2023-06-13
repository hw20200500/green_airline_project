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

<link rel="stylesheet" href="/css/manager.css">

<style>
.list--table th:nth-of-type(1) {
	width: 180px;
}

.list--table th:nth-of-type(2) {
	width: ;
}

.list--table th:nth-of-type(3) {
	width: 135px;
}

.list--table td:nth-of-type(4) {
	width: 60px;
}

.list--table th:nth-of-type(5) {
	width: 170px;
}

.list--table th:nth-of-type(6) {
	width: 280px;
}

.list--table th:nth-of-type(7) {
	width: 105px;
}

.list--table th:nth-of-type(8) {
	width: 105px;
}

.list--table tbody tr:hover {
	font-weight: 500;
	cursor: pointer;
}

</style>

<!-- 회원정보 조회 -->

<main class="d-flex flex-column">
	<h2 class="page--title">회원 정보 조회</h2>
	<hr>
	<br>
	<!-- 필터 및 검색 -->
	<div class="filter--div">
		<form action="/manager/memberList/search" method="get">
			<div>
				<!-- 회원 아이디 검색 -->
				<label for="memberId">아이디</label> 
				<input type="text" name="memberId" id="memberId" autocomplete="off" value="${search}">
				<!-- 검색 버튼 -->
				<button type="submit" id="searchBtn">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li style="height: 24px; margin-right: 2px;">조회
						<li style="height: 24px;">
							<span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 18px; padding-top: 4px;">search</span>
						</li>
					</ul>
				</button>
			</div>
		</form>
		<c:if test="${search != null}">
			<!-- 전체 조회로 돌아가기 -->
			<button class="white--btn" onclick="location.href='/manager/memberList/1'">
				<ul class="d-flex justify-content-center" style="margin: 0;">
					<li><span class="material-symbols-outlined material--li" style="font-size: 22px">refresh</span>
					<li style="font-size: 15px;">전체 회원 조회로 돌아가기
				</ul>
			</button>
		</c:if>
	</div>
	<c:choose>
		<c:when test="${memberList.isEmpty()}">
			<br>
			<p class="no--list--p">회원이 존재하지 않습니다.</p>
		</c:when>
		<c:otherwise>
			<table class="list--table" border="1">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>생년월일</th>
						<th>성별</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>회원등급</th>
						<th>탈퇴여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${memberList}" var="member">
						<tr id="tr${member.id}">
							<td>${member.id}</td>
							<td>${member.korName}</td>
							<td>${member.birthDate}</td>
							<td>${member.gender}</td>
							<td>${member.phoneNumber}</td>
							<td>${member.email}</td>
							<td>${member.grade}</td>
							<td>
								<c:choose>
									<c:when test="${member.status == 0}">
										N
									</c:when>
									<c:otherwise>
										Y
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${pageCount != null}">
				<ul class="page--list">
					<c:choose>
						<c:when test="${pageCount < 11}">
							<c:forEach var="i" begin="1" end="${pageCount}" step="1">
								<c:choose>
									<c:when test="${i == page}">
										<li><a href="/manager/memberList/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
									</c:when>
									<c:otherwise>
										<li><a href="/manager/memberList/${i}">${i}</a>									
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<%-- 페이지가 11개 이상이라면 --%>
						<c:otherwise>
							<c:choose>
								<c:when test="${page < 11}">
									<c:forEach var="i" begin="1" end="10" step="1">
										<c:choose>
											<c:when test="${i == page}">
												<li><a href="/manager/memberList/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
											</c:when>
											<c:otherwise>
												<li><a href="/manager/memberList/${i}">${i}</a>									
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<li><a href="/manager/memberList/11">></a>		
								</c:when>
								<c:otherwise>
									<li><a href="/manager/memberList/1"><</a>		
									<c:forEach var="i" begin="11" end="${pageCount}" step="1">
										<c:choose>
											<c:when test="${i == page}">
												<li><a href="/manager/memberList/${i}" style="font-weight: 700; color: #007bff">${i}</a>									
											</c:when>
											<c:otherwise>
												<li><a href="/manager/memberList/${i}">${i}</a>									
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</ul>
			</c:if>
		</c:otherwise>
	</c:choose>
</main>

<script>
	
	$(document).ready(function() {
		$(".list--table tbody tr").on("click", function() {
			let id = $(this).attr("id").split("tr")[1];
			
			location.href="/manager/memberDetail/" + id;
			
		});
		
		$("#searchBtn").on("click", function() {
			let search = $("#memberId").val().replaceAll(" ", "");

			if (search == "") {
				return false;
			} 
		});

		$("#memberId").on("keyup", function(e) {
			let search = $("#memberId").val().replaceAll(" ", "");

			if (e.keyCode == '13') {
				if (search == "") {
					e.preventDefault();
				} 
			}
		});
	});
</script>

<input type="hidden" name="menuName" id="menuName" value="회원 정보 조회">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
