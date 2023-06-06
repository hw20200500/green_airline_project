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
	.list--table--reverse th {
		width: 30%;
	}
	
	.list--table--reverse td {
		width: 70%;
		padding: 0 10px;
		height: 45px;
	}
	
	input[type="email"], input[type="tel"], input[type="text"] {
		border: none;
		outline: none;
		background-color: #eee;
		padding: 3px 5px;
		border-radius: 5px;
		width: 100%;
	}
	
	label {
		margin: 0;
	}
	
	.ui-datepicker select.ui-datepicker-year {
		width: 70px !important;	
		margin-right: -20px !important;
	}

	.ui-datepicker select.ui-datepicker-month {
		width: 60px !important;	
	}

	.ui-datepicker .ui-datepicker-title {
		display: flex;
		justify-content: space-around;
	}
</style>

<!-- 관리자 등록 -->

<main class="d-flex flex-column">
	<h2 class="page--title">관리자 등록</h2>
	<hr>
	<br>
	
	<form action="/manager/registration" method="post">
		<div class="d-flex flex-column align-items-center">
			<table class="list--table--reverse" border="1" style="width: 600px;">
				<tr>
					<th>이름</th>
					<td><input type="text" name="managerName" required class="reg--input"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="birthDate" required class="reg--input" id="datepicker"></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<label><input type="radio" name="gender" value="M" required class="reg--input">&nbsp;남성</label> 
						&nbsp;&nbsp;
						<label><input type="radio" name="gender" value="F" required class="reg--input">&nbsp;여성</label> 
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="tel" name="phoneNumber" required class="reg--input"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" required class="reg--input"></td>
				</tr>
			</table>
			
			<div style="margin-top: 40px" class="d-flex align-items-end">
				<button type="button" class="blue--btn--small" style="padding-left: 9px; background-color: gray; margin: 0 20px" onclick="location.href='/manager/list/1'">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
						<li>취소
					</ul>
				</button>
				<button type="submit" class="blue--btn--small" id="regBtn">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li style="margin-right: 4px;">입력 완료
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">done</span>
					</ul>
				</button>
			</div>
		</div>
	</form>
	
</main>

<script>

$(document).ready(function(){
	$("#datepicker").datepicker(
		{
			dateFormat: "yy-mm-dd",
			changeMonth: true,
			changeYear: true,
			yearRange: '1900:2023',
			maxDate: '0',
			showMonthAfterYear: true,
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			onSelect: function() {
				let date = $.datepicker.formatDate("yy-mm-dd", 
						$("#datepicker").datepicker("getDate"));
		}
	});
	
	$("#regBtn").on("click", function() {
		let birthDate = stringToDate($("input[name=\"birthDate\"]").val());
	
		if (birthDate == "error") {
			alert("유효하지 않은 생년월일입니다.");
			return false;
		}
	});	
});


</script>

<input type="hidden" name="menuName" id="menuName" value="관리자 등록">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
