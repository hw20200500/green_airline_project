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

label {
	margin: 0;
}

input[name="title"], .info--input, textarea[name="content"], select {
	border: none;
	outline: none;
	background-color: #eee;
	padding: 3px 5px;
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
	padding: 7px 10px;
	font-size: 16px;
	resize: none;
	height: 400px;
}

select[name="categoryId"] {
	width: 300px;
}

select[name="ticketId"] {
	width: 550px;
}

.textarea--p {
	text-align: right;
	color: gray;
	font-size: 14px;
}

label:hover {
	cursor: pointer;
}
</style>

<script>

// 최대 글자 수 2000자
let maxByte = ${Define.MAX_TEXTAREA_LENGTH};
$(document).ready(function() {
	
	$("#contentArea").on("keyup change keydown", function() {
		checkMaxByte($(this));
		let text = $(this).val();
		let totalByte = 0;
		
		if (text.length != 0) {
			for (let i = 0; i < text.length; i++) {
				// 한글은 1글자당 2byte
				totalByte += (text.charCodeAt(i) > 128) ? 2 : 1;
			}
		}
		$("#currentLen").text(totalByte);
	});
	
	function checkMaxByte(obj) {
		let text = obj.val();
		
		let rbyte = 0;
		let rlen = 0;
		let char1 = "";
		let resultStr = "";
		
		for (let i = 0; i < text.length; i++) {
			char1 = text.charAt(i);
			if (escape(char1).length > 4) {
				rbyte += 2;
			} else {
				rbyte ++;
			}
			
			if (rbyte <= maxByte) {
				rlen = i + 1;
			}
		}
		if (rbyte > maxByte) {
			resultStr = text.substr(0, rlen);
			obj.val(resultStr);
			checkMaxByte(obj);
		}
	}
});
</script>

<!-- 구매한 항공권 상세 페이지 -->

<main class="d-flex flex-column">
	<h2>고객의 말씀 작성</h2>
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
						<td><input type="tel" name="phoneNumber" value="${member.phoneNumber}" class="info--input"></td>
					</tr>
					<tr>
						<th>이메일&nbsp;<span style="color: #d91818">*</span></th>
						<td><input type="email" name="email" value="${member.email}" class="info--input"></td>
					</tr>
				</table>
	
				<br> <br>
	
				<h5 class="middle--title" style="margin-left: -4px; font-size: 21px;">
					<span style="font-size: 28px; margin-right: 5px;" class="material-symbols-outlined">edit_document</span> <span>내용 작성</span>
				</h5>
				<table border="1" class="list--table--reverse">
					<tr>
						<th>유형&nbsp;<span style="color: #d91818">*</span></th>
						<td><label><input type="radio" name="type" value="문의" checked>&nbsp;문의</label>&nbsp;&nbsp;&nbsp; <label><input type="radio" name="type" value="칭찬">&nbsp;칭찬</label>&nbsp;&nbsp;&nbsp;
							<label><input type="radio" name="type" value="불만">&nbsp;불만</label>&nbsp;&nbsp;&nbsp; <label><input type="radio" name="type" value="건의">&nbsp;건의</label></td>
					</tr>
					<tr>
						<th>분야&nbsp;<span style="color: #d91818">*</span></th>
						<td><select name="categoryId">
								<option value="" style="color: gray">분야 선택</option>
								<c:forEach var="category" items="${categoryList}">
									<option value="${category.id}">${category.name}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th>제목&nbsp;<span style="color: #d91818">*</span></th>
						<td><input type="text" name="title" autocomplete="false" maxlength="50"></td>
					</tr>
					<tr>
						<th>내용&nbsp;<span style="color: #d91818">*</span></th>
						<td><textarea name="content" id="contentArea"></textarea>
							<p class="textarea--p">
								<span id="currentLen">0</span>/${Define.MAX_TEXTAREA_LENGTH}자
							</p></td>
					</tr>
					<tr>
						<th>예약번호</th>
						<td><select name="ticketId">
								<option value="" style="color: gray">예약 관련 상담 시 선택 바랍니다.</option>
								<c:forEach var="ticket" items="${ticketList}">
									<option value="${ticket.id}">
										${ticket.id}&nbsp;&nbsp;ㅣ&nbsp;&nbsp;${ticket.departure} → ${ticket.destination}&nbsp;&nbsp;ㅣ&nbsp;&nbsp;${ticket.formatDepartureDate()}
									</option>
								</c:forEach>
						</select></td>
					</tr>
				</table>
				<div style="text-align: center; margin-top: 40px;">
					<button type="submit" class="search--btn--middle">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li style="margin-right: 4px;">입력 완료
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 25px; margin-top: 3px;">done</span>
						</ul>
					</button>
				</div>
			</div>
		</form>
	</div>

</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
