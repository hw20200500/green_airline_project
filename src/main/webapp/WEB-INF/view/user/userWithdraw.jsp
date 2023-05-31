<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
</style>
<main>
	<div>
		<h1>회원 탈퇴</h1>
		<h3>비밀번호 확인을 한 사람만 들어올 수 있음</h3>

		<div>
			<h4>회원 탈퇴 신청 전 유의사항</h4>
			<ul>
				<li>회원님의 개인정보 및 적립하신 마일리지까지 모든 개인정보 기록이 삭제됩니다.</li>
			</ul>
		</div>

		<div>
			<p>회원 이름 ${member.korName} | 아이디 ${principal.id}</p>
		</div>

		<form action="/userWithdraw" method="post">
			<input type="hidden" name="status">
			 <input type="hidden" name="id">

			<div>
				<button type="submit" class="btn btn-primary">탈퇴</button>
			</div>
		</form>
	</div>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>

