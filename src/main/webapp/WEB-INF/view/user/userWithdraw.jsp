<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.userWithdraw--head--wrap {
	margin-bottom: 30px;
}

.userWithdraw--member--name--id--wrap {
	border: 1px solid #ebebeb;
	padding: 30px;
}

.btn--primary {
	background-color: #c0c0c0;
	color: white;
	margin-top: 20px;
	font-size: 18px;
}

.btn--primary:hover {
	background-color: #c0c0c0;
	color: white;
	margin-top: 20px;
}

.btn--withdraw {
	background-color: #000;
	color: white;
	margin-top: 20px;
	margin-right: 10px;
	font-size: 18px;
}
.btn--withdraw:hover {
	background-color: #000;
	color: white;
	margin-top: 20px;
}

.userWithdraw--member--name--wrap {
	margin-bottom: 20px;
	border-bottom: 1px solid #ddd;
	background-color: #f8f9fc;
	padding: 10px;
	font-size: 22px;
}

.userWithdraw--member--id--wrap {
	border-bottom: 1px solid #ddd;
	background-color: #f8f9fc;
	padding: 10px;
	font-size: 22px;
}

.btn--wrap{
	display: flex;
	justify-content: center;
}
</style>
<main>
	<div>
		<div>
			<h2 class="page--title">회원 탈퇴</h2>
			<hr>
			<br>
		</div>

		<div class="userWithdraw--head--wrap">
			<h4>회원 탈퇴 신청 전 유의사항</h4>
			<ul>
				<li>회원님의 개인정보 및 적립하신 마일리지까지 모든 개인정보 기록이 삭제됩니다.</li>
			</ul>
		</div>

		<div class="userWithdraw--member--name--id--wrap">
			<div class="userWithdraw--member--name--wrap">
				<b>회원 이름</b>&nbsp;&nbsp;&nbsp; ${member.korName}
			</div>
			<div class="userWithdraw--member--id--wrap">
				<b>아이디</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${principal.id}
			</div>
		</div>

		<form action="/userWithdraw" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?')">
			<input type="hidden" name="status"> <input type="hidden" name="id">

			<div class="btn--wrap">
				<button type="submit" class="btn btn--withdraw">탈퇴</button>
				<button type="button" class="btn btn--primary" onclick="location.href='/'">취소</button>
			</div>
		</form>
	</div>
</main>

<input type="hidden" name="menuName" id="menuName" value="회원 탈퇴">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>

