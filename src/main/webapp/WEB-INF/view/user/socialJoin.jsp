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
		<form action="/apiSocialJoinProc" method="post">
			<div class="join--all--wrap">
				<c:choose>
					<%-- 일반 회원가입, 소셜 회원가입 validation 걸렸을 때 --%>
					<c:when test="${joinFormDto != null}">
						아이디 <input type="text" name="id" value="${joinFormDto.id}">
						<c:if test="${key != null}">
							${key}
						</c:if>
					</c:when>
					<%-- 소셜 회원가입 --%>
					<c:otherwise>
						아이디 <input type="text" name="id" value="${id}" readonly="readonly">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${joinFormDto != null}">
					비밀번호 <input type="password" name="password" required="required">
					비밀번호 확인 <input type="password" required="required">
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${joinFormDto != null}">
				한국 이름 <input type="text" name="korName" required="required">
					</c:when>
					<c:otherwise>
				한국 이름 <input type="text" name="korName" required="required">
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${joinFormDto != null}">
				영어 이름 <input type="text" name="engName" required="required">
					</c:when>
					<c:otherwise>
				영어 이름 <input type="text" name="engName" required="required">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${joinFormDto != null}">
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required">
					</c:when>
					<c:otherwise>
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required">
					</c:otherwise>
				</c:choose>

				<div>
					<c:choose>
						<c:when test="${joinFormDto != null}">
								성별 <label> <input type="hidden" name="gender" value="${gender}" required="required"> 남
							</label>
							<label> <input type="hidden" name="gender" value="${gender}" required="required"> 여
							</label>
						</c:when>
						<c:when test="${gender.equals(\"none\")}">
								성별 <label> <input type="hidden" name="gender" value="${gender}" required="required"> 남
							</label>
							<label> <input type="hidden" name="gender" value="${gender}" required="required"> 여
							</label>
						</c:when>
						<c:otherwise>
								성별 <label> <input type="radio" name="gender" value="M" required="required"> 남
							</label>
							<label> <input type="radio" name="gender" value="F" required="required" value="F" checked="checked"> 여
							</label>
						</c:otherwise>
					</c:choose>
				</div>
				<c:choose>
					<c:when test="${joinFormDto != null}">
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
					</c:when>
					<c:otherwise>
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${joinFormDto != null}">
						이메일 <input type="text" name="email" value="${email}" required="required">
					</c:when>
					<c:when test="${email.equals(\"none\")}">
								이메일 <input type="email" name="email" required="required">
					</c:when>
					<c:otherwise>
								이메일 <input type="email" name="email" value="${email}" required="required">
					</c:otherwise>
				</c:choose>
				주소 <input type="text" name="address" required="required" value="부산시"> 국적 <select name="nationality" value="대한민국" required="required">
					<c:forEach var="countryNm" items="${countryNm}">
						<option value="${countryNm}" <c:if test="${countryNm.equals(\'대한민국\')}"> selected </c:if>>${countryNm}</option>
					</c:forEach>
				</select> <input type="hidden" name="grade">
				<button type="submit" class="btn btn-primary">회원가입</button>
				<button type="button" onclick="location.href='/'" class="btn btn-danger">취소</button>
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