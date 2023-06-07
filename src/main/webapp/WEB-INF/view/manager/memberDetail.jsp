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

<style>

.list--table--reverse th {
	border-left: 1px solid #ddd;
	width: 20%;
}

.list--table--reverse td {
	border-right: 1px solid #ddd;
	width: 30%;
}

.list--table--reverse td {
	padding: 0 10px;
}

</style>

<!-- 특정 회원 정보 조회 -->

<main class="d-flex flex-column">
	<h2 class="page--title">회원 정보 조회</h2>
	<hr>
	<br>

	<div class="d-flex flex-column align-items-center">
		<c:if test="${member.status == 1}">
			<p class="no--list--p">
				${member.formatWithdrawAt()}에 탈퇴한 회원입니다.
			</p>
			<br>
		</c:if>
		<table class="list--table--reverse" border="1" style="width: 900px;">
			<tr>
				<th>아이디</th>
				<td>${member.id}
					<c:if test="${member.userRole.equals(\"소셜회원\")}">
						&nbsp;(소셜회원)
					</c:if>
				</td>
				<th>회원등급</th>
				<td>${member.grade}</td>
			</tr>
			<tr>
				<th>가입일자</th>
				<td>${member.formatJoinAt()}</td>
				<th>국적</th>
				<td>${member.nationality}</td>
			</tr>
			<tr>
				<th>한글이름</th>
				<td>${member.korName}</td>
				<th>영문이름</th>
				<td>${member.engName}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${member.gender}</td>
				<th>생년월일</th>
				<td>${member.birthDate}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${member.phoneNumber}</td>
				<th>이메일</th>
				<td>${member.email}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">${member.address}</td>
			</tr>
		</table>
		
		<div style="margin-top: 40px">
			<button type="button" class="blue--btn--small" style="padding-left: 9px; background-color: gray; margin: 0 20px" onclick="location.href='/manager/memberList/1'">
				<ul class="d-flex justify-content-center" style="margin: 0;">
					<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
					<li>회원 목록
				</ul>
			</button>
			<c:if test="${member.status == 0}">
				<button type="button" class="blue--btn--small" id="withdrawBtn" style="padding-left: 9px; background-color: #911614; margin: 0 20px">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">close</span>
						<li>탈퇴 처리
					</ul>
				</button>
			</c:if>
		</div>
	</div>
	
</main>


<script>
	$("#withdrawBtn").on("click", function() {
		let withdraw = confirm("해당 회원을 탈퇴 처리하시겠습니까?");
		
		if (withdraw) {
			$.ajax({
				type: 'PUT',
				url: '/manager/memberWithdraw/' + `${member.id}`
			}).done((res) => {
				// ResponseDto에 담아둔 메세지를 alert으로 출력
				alert(res.message);
				// 새로고침
				location.reload();
			}).fail((error) => {
				console.log(error);
			});
		}
		
	});
</script>

<input type="hidden" name="menuName" id="menuName" value="회원 정보 조회">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
