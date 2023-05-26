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
				아이디 <input type="text" name="id"> 한국 이름 <input type="text" name="korName" value="강ㄱ"> 영어 이름 <input type="text" name="engName" value="KK">
				<%-- 데이트피커 가져오기 --%>
				생년월일
				<p>
					Date <input type="text" id="datepicker" value="2023-05-09" name="birthDate">
				</p>
				<div>
					<c:choose>
						<c:when test="${gender.equals(\"none\")}">
								성별 <label> <input type="radio" name="gender" value="${gender}" checked="checked"> 남
							</label>
							<label> <input type="radio" name="gender"> 여
							</label>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="gender" value="${gender}">
						</c:otherwise>
					</c:choose>
				</div>
				휴대전화 <input type="text" name="phoneNumber" value="010-1245-1324" placeholder="예:010-0000-0000">
				<c:choose>
					<c:when test="${email.equals(\"none\")}">
								이메일 <input type="email" name="email" value="kmg1151@naver.com">
					</c:when>
					<c:otherwise>
								이메일 <input type="hidden" name="email" value="${email}">
					</c:otherwise>
				</c:choose>
				주소 <input type="text" name="address" value="부산"> 국적 <select name="nationality" value="대한민국">

					<option>대한민국</option>
				</select> <input type="hidden" name="grade">

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