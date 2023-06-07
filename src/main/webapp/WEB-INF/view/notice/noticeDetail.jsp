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

<input type="hidden" name="menuName" id="menuName" value="공지사항">

<style>
.noticeDetail--title {
	font-size: 35px;
	font-weight: 500;
}

.noticeDetail--name {
	display: flex;
	align-items: flex-end;
	margin-right: 30px;
	font-size: 20px;
}

.noticeDetail--content {
	font-size: 18px;
	background-color: #F3FCFE;
	padding: 20px;
}

.noticeDetail--title--name--wrap {
	display: flex;
	justify-content: space-between;
}

.btn--primary {
	border: none;
	background-color: #8ABBE2;
	color: white;
	margin-right: 10px;
}

.btn--primary:hover {
	border: none;
	background-color: #8ABBE2;
	color: white;
}

.btn--danger {
	background-color: #DC6093;
	color: white;
}

.btn--wrap {
	display: flex;
	margin-top: 20px;
}

.btn--danger:hover {
	background-color: #DC6093;
	color: white;
}

main {
	display: flex;
	flex-direction: column;
}
</style>
<div>
	<main>
		<h2 class="page--title">공지사항</h2>
		<hr>
		<br>

		<div>
			<input type="hidden" name="id" value="${noticeList.id}">
			<div class="noticeDetail--title--name--wrap">
				<div class="noticeDetail--title">${noticeList.title}</div>
				<div class="noticeDetail--name">${noticeList.name}ㅣ${noticeList.dateFormatType2()}</div>
			</div>
			<hr>
			<div class="noticeDetail--content">${noticeList.content}</div>
		</div>
		<c:if test="${principal.userRole.equals(\"관리자\")}">
			<div class="btn--wrap">
				<button class="btn btn--primary" onclick="location.href='/notice/noticeUpdate?id=${id}'">수정</button>
				<button class="btn btn--danger" onclick="deleteBtn('${id}')">삭제</button>
			</div>
		</c:if>
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>

<script>
	function deleteBtn(id) {
		if (confirm('정말 삭제하시겠습니까?') == true) {
			location.href = '/notice/noticeDelete?id=' + id;
		}

	}
</script>