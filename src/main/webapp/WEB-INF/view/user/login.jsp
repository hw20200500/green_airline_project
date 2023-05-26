<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
<<<<<<< HEAD
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
				<label for="id">아이디</label> <input type="text" id="id" name="id" value="abc">
			</div>
			<br>
			<div class="d-flex">
				<label for="password">비밀번호</label> <input type="password" id="password" name="password" value="1234">
			</div>
			<br>
			<div class="d-flex justify-content-center">
				<button type="submit" class="btn btn-primary">로그인</button>
			</div>
		</form>
		<a href="https://kauth.kakao.com/oauth/authorize?client_id=ce88cf20b78f9552fe8f49e224822cf8&redirect_uri=http://localhost:80/auth/kakao/callback&response_type=code"><img alt=""
			src="/images/kakao_login_medium.png" style="margin-top: 10px;"> </a>
	</div>
</main>



=======

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
					<label for="id">아이디</label>
					<input type="text" id="id" name="id" value="abc">
				</div>
				<br>
				<div class="d-flex">
					<label for="password">비밀번호</label>
					<input type="password" id="password" name="password" value="1234">
				</div>
				<br>
				<div class="d-flex justify-content-center">
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
			</form>
		</div>
	</main>
>>>>>>> feature/board

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
