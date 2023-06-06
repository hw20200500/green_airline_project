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

.userPwCheck--id--pw--wrap {
	border: 1px solid #ddd;
	padding: 30px;
}

.userPwCheck--id--wrap {
	margin-bottom: 20px;
}

input[type=password]:focus {
	outline: none;
}

input[type=password] {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 600px;
	background: #f8f9fc;
	padding: 10px;
	position: relative;
}

.userPwCheck--btn{
	display: flex;
	justify-content: center;
}

.btn--primary{
	background-color: #8ABBE2;
	color: white;
	width: 180px;
	height: 55px;
}
</style>

<main>
	<div>
		<h2 class="page--title">비밀번호 확인</h2>
		<p class="page--title--description">
			회원님의 개인 정보를 안전하게 보호하기 위해 그린항공은 비밀번호를 암호화하여 저장, 관리하고 있습니다.
		</p>
		<hr>
		<br>
	</div>

	<form action="/userPwCheck" method="post">
		<div class="userPwCheck--id--pw--wrap">
			<div class="userPwCheck--id--wrap">
				<input type="hidden" name="id" value="${principal.id}"> 회원 아이디 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${principal.id}
			</div>
			<div>
				비밀번호 확인 &nbsp;&nbsp;&nbsp;<input type="password" name="password">
			</div>
			<input type="hidden" name="type" value="${type}">
		</div>
		<div class="userPwCheckk--ul--wrap">
			<ul>
				<li>회원님의 개인 정보를 보호하기 위해, 회원정보 변경 시 비밀번호를 재확인합니다.</li>
				<li>비밀번호는 대/소문자를 구별하여 입력해 주십시오.</li>
			</ul>
			<br>
		</div>

		<div class="userPwCheck--btn">
			<button type="submit" class="btn btn--primary">확인</button>
		</div>
	</form>
</main>

<input type="hidden" name="menuName" id="menuName" value="회원정보 변경">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
