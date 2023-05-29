<%@page import="com.green.airline.utils.Define"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/ticket.css">

<style>
.list--table--reverse td {
	font-size: 17px;
	padding: 10px 5px 10px 20px;
}

.list--table--reverse th {
	width: 300px;
	height: 52.5px;
}

input[name="title"], .info--input, textarea[name="content"] {
	border: none;
	outline: none;
	padding: 3px 0;
	border-radius: 5px;
}

.info--input {
	width: 300px;
}

input[name="title"] {
	width: 100%;
}

textarea[name="content"] {
	width: 100%;
	padding: 7px 0px;
	font-size: 16px;
	resize: none;
	height: 400px;
}

</style>

<!-- 고객의 말씀 상세 페이지 -->

<main class="d-flex flex-column">
	<h2>고객의 말씀</h2>
	<hr>
	<br>
	<div class="d-flex justify-content-center" style="width: 100%;">
		<form action="/voc/write" method="post">
			<div class="d-flex flex-column" style="width: 1000px">
				<h5 class="middle--title" style="margin-left: -4px; font-size: 21px;">
					<span style="font-size: 28px; margin-right: 3px;" class="material-symbols-outlined">person</span> <span>고객 정보</span>
				</h5>
				<table border="1" class="list--table--reverse">
					<tr>
						<th>성함</th>
						<td>${member.korName}</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${member.birthDate}</td>
					</tr>
					<tr>
						<th>전화번호&nbsp;<span style="color: #d91818">*</span></th>
						<td><input type="tel" name="phoneNumber" value="${voc.phoneNumber}" class="info--input" readonly></td>
					</tr>
					<tr>
						<th>이메일&nbsp;<span style="color: #d91818">*</span></th>
						<td><input type="email" name="email" value="${voc.email}" class="info--input" readonly></td>
					</tr>
				</table>
	
				<br> <br>
	
				<h5 class="middle--title" style="margin-left: -4px; font-size: 21px;">
					<span style="font-size: 28px; margin-right: 5px;" class="material-symbols-outlined">edit_document</span>
					<span>작성된 내용</span>
				</h5>
				<table border="1" class="list--table--reverse">
					<tr>
						<th>유형&nbsp;<span style="color: #d91818">*</span></th>
						<td>${voc.type}</td>
					</tr>
					<tr>
						<th>분야&nbsp;<span style="color: #d91818">*</span></th>
						<td>${voc.categoryName}</td>
					</tr>
					<tr>
						<th>제목&nbsp;<span style="color: #d91818">*</span></th>
						<td><input type="text" name="title" autocomplete="false" maxlength="50" value="${voc.title}" readonly></td>
					</tr>
					<tr>
						<th>내용&nbsp;<span style="color: #d91818">*</span></th>
						<td>
							<textarea name="content" id="contentArea" readonly>${voc.content}</textarea>
						</td>
					</tr>
					<c:if test="${voc.ticketId != null}">
						<tr>
							<th>예약번호</th>
							<td>${voc.ticketId}</td>
						</tr>
					</c:if>
				</table>
				<div style="margin-top: 40px;" class="d-flex justify-content-center">
					
					<c:choose>
						<c:when test="${principal.userRole.equals(\"관리자\")}">
								<button type="button" class="search--btn--small" style="margin-right: 40px; padding-left: 9px; background-color: gray" onclick="location.href='/voc/list/manager'">
									<ul class="d-flex justify-content-center" style="margin: 0;">
										<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
										<li>목록
									</ul>
								</button>
							<button type="button" class="search--btn--small">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li style="margin-right: 4px;">답변 작성
									<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">edit</span>
								</ul>
							</button>
						</c:when>
						<c:otherwise>
							<%-- 수정은 답변이 달리지 않았을 때에만 가능 --%>
							<c:if test="${voc.answerId == null}">
								<button type="button" class="search--btn--small" style="margin-right: 40px; padding-left: 9px; background-color: gray" onclick="location.href='/voc/list/member'">
									<ul class="d-flex justify-content-center" style="margin: 0;">
										<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
										<li>목록
									</ul>
								</button>
								<button type="button" class="search--btn--small" style="margin: 0 20px">
									<ul class="d-flex justify-content-center" style="margin: 0;">
										<li style="margin-right: 4px;">수정
										<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">edit</span>
									</ul>
								</button>
							</c:if>
							<button type="button" class="search--btn--small" id="vocDeleteBtn">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li style="margin-right: 4px;">삭제
									<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">delete_forever</span>
								</ul>
							</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</form>
	</div>

</main>

<script>
	// 게시글 삭제 버튼
	$("#vocDeleteBtn").on("click", function() {
		
		let isDelete = confirm("해당 내역을 삭제하시겠습니까?");
		
		if (isDelete) {		
			$.ajax({
				type: 'DELETE',
				url: '/voc/delete/' + ${voc.id}
			})
			.done((res) => {
				console.log(res);
				location.href="/voc/list/member";
			})
			.fail((error) => {
				console.log(error);
			});
		}
	});
</script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
