<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.myInfo--all--wrap {
	display: flex;
	flex-direction: column;
}

.myInfo--div--wrap {
	display: flex;
}

.myInfo--ul--wrap {
	margin-left: 20px;
	width: 150px;
	font-size: 25px;
}

.myInfo--ul--li--wrap {
	text-align: center;
}

.myInfo--member--wrap {
	margin-left: 20px;
}
</style>
<main>
	<div class="myInfo--all--wrap">
		<h1>myInfo</h1>
		<hr>
		<div class="myInfo--div--wrap">
			<ul class="myInfo--ul--wrap">
				<li class="myInfo--ul--li--wrap">메뉴</li>
				<li><a href="#">#</a></li>
				<li><a href="#">#</a></li>
				<li><a href="#">#</a></li>
				<li><a href="#">#</a></li>
				<li><a href="#">#</a></li>
				<li><a href="#">#</a></li>
				<li><a href="#">#</a></li>
				<li><a href="#">회원 탈퇴</a></li>
			</ul>

			<div class="myInfo--member--wrap">
				<h3>회원 정보 들어올 곳</h3>
			</div>

		</div>
	</div>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>