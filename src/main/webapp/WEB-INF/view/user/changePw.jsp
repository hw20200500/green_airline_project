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

.changePw--wrap{
	border: 1px solid #ddd;
	padding: 30px;
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

.chagnePw--pw{
	padding: 10px;
}

.btn--primary{
	background-color: #8ABBE2;
	color: white;
	width: 180px;
	height: 55px;
}

.changePw--btn--wrap{
	display: flex;
	justify-content: center;
}

.changePw--content--wrap{
	margin-bottom: 10px;
}
</style>

<main>
	<div>
		<h2 class="page--title">비밀번호 변경</h2>
		<p class="page--title--description">회원님의 개인 정보를 안전하게 보호하기 위해 그린항공은 비밀번호를 암호화하여 저장, 관리하고 있습니다.</p>
		<hr>
		<br>
	</div>

	<div class="changePw--content--wrap">
		<h4>새로운 비밀번호로 변경해 주세요.</h4>
	</div>

	<form action="/changePw" method="post"  onsubmit="confirm('정말 변경하시겠습니까?')">
		<div class="changePw--wrap">
			<div class="chagnePw--pw">
				기존 비밀번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="password" name="password" placeholder="기존 비밀번호를 입력">
			</div>
			<div class="chagnePw--pw">
				신규 비밀번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="password" name="newPassword" placeholder="7~20자리">
			</div>
			<div class="chagnePw--pw">
				신규 비밀번호 확인 &nbsp;&nbsp; <input type="password" name="newPasswordCheck" placeholder="7~20자리">
			</div>
		</div>

		<div class="changePw--btn--wrap">
			<button type="submit" class="btn btn--primary">확인</button>
		</div>
	</form>
</main>

<input type="hidden" name="menuName" id="menuName" value="비밀번호 변경">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>