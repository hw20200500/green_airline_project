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
#login--form {
	border: 1px solid #ccc;
	padding: 20px;
	width: 400px;
}

#login--form label {
	flex: 1;
}

#login--form input {
	flex: 2;
}
</style>


<!-- 여기 안에 쓰기 -->
<main>
	<div class="d-flex justify-content-center">
		<form id="login--form" action="/login" method="post">
			<div class="d-flex">
				<label for="id">아이디</label> <input type="text" id="id" name="id" value="asdf">
			</div>
			<br>
			<div class="d-flex">
				<label for="password">비밀번호</label> <input type="password" id="password" name="password" value="1234">
			</div>
			<br>
			<div class="d-flex justify-content-center">
				<button type="submit" class="btn btn-primary">로그인</button>
				<a href="/userIdSearch" class="btn btn-primary">아이디/비밀번호 찾기</a>
				<a href="https://kauth.kakao.com/oauth/authorize?client_id=91cf28839247e9924114aeb1a23b8852&redirect_uri=http://localhost:80/auth/kakao/callback&response_type=code"><img alt=""
					src="/images/kakao_login_medium.png" style="margin-left: 10px;"> </a>
			</div>
		</form>
	</div>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
