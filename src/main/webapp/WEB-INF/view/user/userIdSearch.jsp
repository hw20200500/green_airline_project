<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
main{
text-align: center;
	border: 1px solid #ccc;
}
.title{
	text-align: center;
	margin-top: 10px;
}
.form-control{
margin-left:320px;
text-align: center;
	width: 550px;
	background-color: rgb(243, 243, 243);
	border: none;
}
.btn{
	width: 550px;
	margin-left: 10px;
	margin-top: 30px;
}
.findId{
	margin-top: 50px;
	margin-left:320px;
	background-color: rgb(243, 243, 243);
	width: 550px;
	height: 100px;
	padding: 30px;
}

</style>


<!-- 여기 안에 쓰기 -->
<main>
	<form action="/findByUserId" method="post">
		<div>
			<h2 class="title">
				<a href="userIdSearch">아이디 찾기/ </a>
				<a href="userPwSearch">비밀번호 찾기</a>
			</h2>
			<div class="form-group">
				<label for="usr">Name:</label> <input type="text" class="form-control" id="korName" value="김홍아" name="korName">
			</div>

			<div class="form-group">
				<label for="usr">email:</label> <input type="text" class="form-control" id="email" value="os010312@naver.com" name="email">
			</div>
			<div class="form-group">
				<label for="usr">birthDay:</label> <input type="text" class="form-control" id="birthDate" value="2000-01-05" name="birthDate">
			</div>
			<button type="submit"class="btn btn-light">전송</button>
		</div>
	</form>
	<div class="findId">
		<p>${response.korName}의 아이디 ${response.id} 입니다</p>
	</div>

</main>

<script>
	$('.findId').hide();
	
</script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
