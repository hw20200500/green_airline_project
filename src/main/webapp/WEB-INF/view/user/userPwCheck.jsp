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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
.userPwCheckk--ul--wrap {
	margin-top: 30px;
}
</style>

<main>

	<div>
		<h2>비밀번호 확인</h2>
		<hr>
	</div>
	<div>
		<p>회원님의 개인 정보를 안전하게 보호하기 위해 비밀번호를 다시 입력하여 주십시오.</p>
	</div>
	<form action="/userPwCheck" method="post">
		<div>
			<input type="hidden" name="id" value="${principal.id}"> 회원 아이디 ${principal.id} <br> 비밀번호 확인 <input type="password" name="password">
			<input type="hidden" name="type" value="${type}">
		</div>
		<div class="userPwCheckk--ul--wrap">
			<ul>
				<li>회원님의 개인 정보를 보호하기 위해, 회원정보 변경 시 비밀번호를 재확인합니다.</li>
				<li>비밀번호는 대/소문자를 구별하여 입력해 주십시오.</li>
			</ul>
		</div>

		<div>
			<button type="submit" class="btn btn-primary">확인</button>
		</div>
	</form>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
