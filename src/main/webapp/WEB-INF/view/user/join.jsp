<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.join--all--wrap {
	display: flex;
	flex-direction: column;
}
</style>

<main>
	<div>
		<h1>회원가입</h1>
		<form action="/joinProc" method="post">
			<div class="join--all--wrap">
				<c:choose>
					<c:when test="${id==null}">
						아이디 <input type="text" name="id" required="required">
					</c:when>
					<c:otherwise>
						아이디 <input type="text" name="id" value="${id}" readonly="readonly" required="required">
					</c:otherwise>
				</c:choose>
				<c:if test="${id==null}">
					비밀번호 <input type="password" name="password" required="required">
					비밀번호 확인 <input type="password" required="required">
				</c:if>
				한국 이름 <input type="text" name="korName" required="required"> 영어 이름 <input type="text" name="engName" required="required">
				<p>
					생년월일 <input type="text" id="datepicker" name="birthDate" required="required">
				</p>
				<div>
					<c:choose>
						<c:when test="${gender eq 'none'}">
								성별 <label> <input type="radio" name="gender" value="${gender}" required="required"> 남
							</label>
							<label> <input type="radio" name="gender" required="required"> 여
							</label>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="gender" value="${gender}" required="required">
						</c:otherwise>
					</c:choose>
				</div>
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
				<c:choose>
					<c:when test="${email.equals(\"none\")}">
								이메일 <input type="email" name="email" required="required">
					</c:when>
					<c:otherwise>
								이메일 <input type="hidden" name="email" value="${email}" required="required">
					</c:otherwise>
				</c:choose>
					주소 <input type="text" name="address" required="required"> 
					국적 <select name="nationality" value="대한민국" required="required">
							<option>대한민국</option>
						</select> 
					<input type="hidden" name="grade">
				<button type="submit" class="btn btn-primary">회원가입</button>
			</div>
		</form>
	</div>

	<script>
		$(function() {
			/* console.log(dateString2); */

			$("#datepicker").datepicker(
					{
						dateFormat : "yy-mm-dd",
						changeMonth : true,
						changeYear : true,
						yearRange : '1900:2023',
						onSelect : function() {
							let date = $.datepicker.formatDate("yy-mm-dd", $(
									"#datepicker").datepicker("getDate"));
						}
					});

		});
	</script>
</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>