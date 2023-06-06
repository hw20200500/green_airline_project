<%@page import="com.green.airline.utils.Define"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<link rel="stylesheet" href="/css/ticket.css">
<link rel="stylesheet" href="/css/voc.css">

<input type="hidden" name="menuName" id="menuName" value="고객의 말씀">


<main class="d-flex flex-column">
	<h2 class="page--title">고객의 말씀 작성</h2>
	<hr>
	<br>
	<div class="d-flex justify-content-center" style="width: 100%;">
		<form action="/voc/write" method="post">
			<div class="d-flex flex-column" style="width: 1000px">
				<h5 class="middle--title" style="margin-left: -4px;">
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
						<td><input type="tel" name="phoneNumber" value="${member.phoneNumber}" class="info--input" required></td>
					</tr>
					<tr>
						<th>이메일&nbsp;<span style="color: #d91818">*</span></th>
						<td><input type="email" name="email" value="${member.email}" class="info--input" required></td>
					</tr>
				</table>
	
				<br> <br>
	
				<h5 class="middle--title" style="margin-left: -4px;">
					<span style="font-size: 28px; margin-right: 5px;" class="material-symbols-outlined">edit_document</span> 
					<span>내용 작성</span>
				</h5>
				<table border="1" class="list--table--reverse">
					<tr>
						<th>유형&nbsp;<span style="color: #d91818">*</span></th>
						<td><label><input type="radio" name="type" value="문의" checked>&nbsp;문의</label>&nbsp;&nbsp;&nbsp; <label><input type="radio" name="type" value="칭찬">&nbsp;칭찬</label>&nbsp;&nbsp;&nbsp;
							<label><input type="radio" name="type" value="불만">&nbsp;불만</label>&nbsp;&nbsp;&nbsp; <label><input type="radio" name="type" value="건의">&nbsp;건의</label></td>
					</tr>
					<tr>
						<th>분야&nbsp;<span style="color: #d91818">*</span></th>
						<td>
							<select name="categoryId">
								<option value="-1" style="color: gray">분야 선택</option>
								<c:forEach var="category" items="${categoryList}">
									<option value="${category.id}">${category.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>제목&nbsp;<span style="color: #d91818">*</span></th>
						<td><input type="text" name="title" autocomplete="false" maxlength="50" required></td>
					</tr>
					<tr>
						<th>내용&nbsp;<span style="color: #d91818">*</span></th>
						<td><textarea name="content" id="contentArea" required></textarea>
							<p class="textarea--p">
								<span id="currentLen">0</span>/${Define.MAX_TEXTAREA_LENGTH}자
							</p></td>
					</tr>
					<tr>
						<th>예약번호</th>
						<td>
							<select name="ticketId">
								<option value="" style="color: gray">예약 관련 상담 시 선택 바랍니다.</option>
								<c:forEach var="ticket" items="${ticketList}">
									<option value="${ticket.id}">
										${ticket.id}&nbsp;&nbsp;ㅣ&nbsp;&nbsp;${ticket.departure} → ${ticket.destination}&nbsp;&nbsp;ㅣ&nbsp;&nbsp;${ticket.formatDepartureDate()}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<div style="margin-top: 40px;" class="d-flex justify-content-center">
					<button type="button" class="blue--btn--small" style="margin-right: 60px; padding-left: 9px; background-color: gray" onclick="location.href='/voc/list/1'">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
							<li>취소
						</ul>
					</button>
					<button type="submit" class="blue--btn--small" id="writeBtn">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li style="margin-right: 4px;">입력 완료
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">done</span>
						</ul>
					</button>
				</div>
			</div>
		</form>
	</div>

</main>

<script>
	// 최대 글자 수 2000자
	let maxByte = ${Define.MAX_TEXTAREA_LENGTH};
</script>

<script src="/js/voc.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
