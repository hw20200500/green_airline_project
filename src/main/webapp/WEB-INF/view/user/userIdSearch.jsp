<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
main {
	text-align: center;
	border: 1px solid #ccc;
}

.title {
	text-align: center;
	margin-top: 10px;
}

.form-control {
	margin-left: 320px;
	text-align: center;
	width: 550px;
	background-color: rgb(243, 243, 243);
	border: none;
}

.btn--wrap {
	margin-top: 30px;
	display: flex;
	justify-content: center;
	margin-right: 10px;
}

.findId {
	margin-top: 50px;
	margin-left: 320px;
	background-color: rgb(243, 243, 243);
	width: 550px;
	height: 100px;
	padding: 30px;
}

input[type=text]:focus{
	outline: none;
}

input[type=text] {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 520px;
	background: #f8f9fc;
	outline: none;
}

.btn--light {
	background: #c0c0c0;
	width: 520px;
	color: white;
}

</style>


<!-- 여기 안에 쓰기 -->
<main>
	<form action="/findByUserId" method="post">
		<div class="user--id--wrap">
			<h2 class="title">
				<a href="userIdSearch">아이디 찾기</a> &nbsp; ㅣ &nbsp; <a href="userPwSearch">비밀번호 찾기</a>
			</h2>
			<div class="form-group">
				<label for="usr">이름 </label> <input type="text" class="form-control" id="korName" value="김홍아" name="korName">
			</div>

			<div class="form-group">
				<label for="usr">이메일 </label> <input type="text" class="form-control" id="email" value="os010312@naver.com" name="email">
			</div>
			<div class="form-group">
				<label for="usr">생년월일 </label> <input type="text" class="form-control" id="birthDate" value="2000-01-05" name="birthDate">
			</div>
			<div class="btn--wrap">
				<button type="submit" class="btn btn--light">전송</button>
			</div>
		</div>
	</form>
</main>

<script type="text/javascript">
	$(document).ready(function() {
		let korName = '<c:out value="${response.korName}"></c:out>';
		let id = '<c:out value="${response.id}"></c:out>';
		$('.btn-light').on('click', function() {
			alert(korName + '의 아이디는 ' + id + '입니다')
		});
	});
</script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
