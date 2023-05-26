<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>

</style>

<div class="main--img--div">
	<div class="">
		
	</div>
</div>
	
	<!-- 여기 안에 쓰기 -->
	<main>
		<div>
			<h2><a href="userIdSearch">아이디 찾기</a></h2>
			<h2><a href="userPwSearch">비밀번호 찾기</a></h2>
			<div class="form-group">
				<label for="usr">email:</label> <input type="text" class="form-control" id="email" value="os010312@naver.com" name="email">
			</div>
			<div class="form-group">
				<label for="usr">인증 확인:</label> <input type="text" class="form-control" id="email" value="os010312@naver.com" name="email">
			</div>
		</div>
	</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
