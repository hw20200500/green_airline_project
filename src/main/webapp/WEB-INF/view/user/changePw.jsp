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
</style>

<main>
	<div>
		<h1>비밀번호 변경</h1>
	</div>

	<div>
		<p>회원님의 개인 정보를 안전하게 보호하기 위해 그린항공은 비밀번호를 암호화하여 저장, 관리하고 있습니다.</p>
	</div>

	<div>
		<h3>새로운 비밀번호로 변경해 주세요.</h3>
	</div>

	<form action="/changePw" method="post">
		<div>
			<p>
				기존 비밀번호 <input type="password" name="password" placeholder="기존 비밀번호를 입력">
			</p>
			<p>
				신규 비밀번호 <input type="password" name="newPassword" placeholder="8~20자리">
			</p>
			<p>
				신규 비밀번호 확인 <input type="password" name="newPasswordCheck" placeholder="8~20자리">
			</p>
		</div>

		<div>
			<button type="submit" class="btn btn-primary">확인</button>
			<button type="button" onclick="location.href='/'" class="btn btn-danger">취소</button>
		</div>
	</form>
</main>

<input type="hidden" name="menuName" id="menuName" value="비밀번호 변경">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>