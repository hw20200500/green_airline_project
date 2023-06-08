<%@page import="com.green.airline.utils.Define"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
.login--head--wrap {
	margin-bottom: 40px;
}

#login--form {
	border: 1px solid white;
	background: white;
	padding: 50px;
	width: 500px;
	height: 600px;
}

#login--form label {
	flex: 1;
}

#login--form input {
	flex: 2;
}

main {
	width: 100%;
	/* background: linear-gradient(to bottom, #8bbdf8 -75%, #e9f3fb 89%); */
	margin-top: -30px;
}

.join--btn:hover {
    color: white;
}

.login--wrap {
	display: flex;
	flex-direction: column;
	/* margin-top: 20px; */
}

input[type=text], input[type=password] {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 400px;
	background: #f8f9fc;
	padding: 10px;
	outline: none;
}

.login--btn {
	background: #8ABBE2;
	border: none;
	width: 400px;
	padding: 10px;
	color: white;
}

.login--btn:hover {
	background: #8ABBE2;
	color: white;
	border: none;
	width: 400px;
	padding: 10px;
}

.login--idPwSearch--class {
	margin-top: 10px;
	display: flex;
	justify-content: space-between;
}

.login--content {
	margin-top: 20px;
	justify-content: center;
	display: flex;
}

.login--kakao--btn--wrap {
	display: flex;
}

.btn--primary {
	background-color: #8ABBE2;
	color: white;
}

.btn--primary:hover {
	background-color: #8ABBE2;
	color: white;
}

.join--btn--wrap {
	display: flex;
}

.join--btn {
	color: white;
	background-color: #314f79;
}
</style>


<!-- 여기 안에 쓰기 -->
<main>
	<div class="d-flex justify-content-center">
		<form id="login--form" action="/login" method="post">
			<div class="login--head--wrap">
				<h2>로그인</h2>
			</div>
			<div class="d-flex login--wrap">
				<div class="login--id--class">
					<label for="id">아이디</label>
				</div>
				<div class="login--id--input--class">
					<input type="text" id="id" name="id">
				</div>
			</div>
			<br>
			<div class="d-flex login--wrap">
				<div>
					<label for="password">비밀번호</label> <br>
				</div>
				<div>
					<input type="password" id="password" name="password">
				</div>
			</div>
			<br>
			<div class="justify-content-center">
				<div class="login--kakao--btn--wrap">
					<button type="submit" class="btn btn--primary login--btn">로그인</button>
				</div>
				<div class="login--idPwSearch--class">
						<a href="/userIdSearch" style="font-size: 15px;">아이디/비밀번호 찾기 </a> 
					<div>
						<a href="https://kauth.kakao.com/oauth/authorize?client_id=9761c68538850881c74f5d9643d99c09&redirect_uri=http://${Define.IP_ADDRESS}/auth/kakao/callback&response_type=code">
						<img alt="" src="/images/kakao_login_medium.png" style="margin-left: 70px;"> </a>
					</div>
					<div>
						<button type="button" class="btn join--btn" onclick="location.href='/join'" style="width: 90px; height: 45px;">회원가입</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</main>

<input type="hidden" name="menuName" id="menuName" value="">
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
