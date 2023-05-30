<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
					<%-- validation 처리에 걸려서 돌아왔을 때 --%>
					<c:when test="${socialJoinFormDto != null}">
						아이디 <input type="text" name="id" value="${socialJoinFormDto.id}" readonly="readonly">
						<div style="color: red;">
							<c:if test="${valid_id != null}">
							${valid_id}
						</c:if>
						</div>
					</c:when>
					<%-- 소셜 회원가입 처리 --%>
					<c:otherwise>
						아이디 <input type="text" name="id" value="${id}" readonly="readonly">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				한국 이름 <input type="text" name="korName" required="required" value="${socialJoinFormDto.korName}">
						<div style="color: red;">
							<c:if test="${valid_korName != null}">
							${valid_korName}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				한국 이름 <input type="text" name="korName" required="required">
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				영어 이름 <input type="text" name="engName" required="required" value="${socialJoinFormDto.engName}">
						<div style="color: red;">
							<c:if test="${valid_engName != null}">
							${valid_engName}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				영어 이름 <input type="text" name="engName" required="required">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required" value="${socialJoinFormDto.birthDate}">
						<div style="color: red;">
							<c:if test="${valid_birthDate != null}">
							${valid_birthDate}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required">
					</c:otherwise>
				</c:choose>

				<div class="gender--wrap">
					<c:choose>
						<c:when test="${socialJoinFormDto != null}">
							성별 <label> <input type="radio" name="gender" value="M" required="required"> 남
							</label>
							<label> <input type="radio" name="gender" required="required" value="F"> 여
							</label>
							<div style="color: red;">
								<c:if test="${valid_gender != null}">
								${valid_gender}
								</c:if>
							</div>
						</c:when>
						<c:when test="${gender.equals(\"none\")}">
								성별 <label> <input type="radio" name="gender" value="M" required="required"> 남
							</label>
							<label> <input type="radio" name="gender" required="required" value="F"> 여
							</label>
						</c:when>
						<c:otherwise>
								성별 <label> <input type="radio" name="gender" value="M" required="required"> 남
							</label>
							<label> <input type="radio" name="gender" required="required" value="F"> 여
							</label>
						</c:otherwise>
					</c:choose>
				</div>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
						<div style="color: red;">
							<c:if test="${valid_phoneNumber != null}">
							${valid_phoneNumber}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						이메일 <input type="text" name="email" value="${email}" required="required">
						<div style="color: red;">
							<c:if test="${valid_email != null}">
							${valid_email}
						</c:if>
						</div>
					</c:when>
					<c:when test="${email.equals(\"none\")}">
								이메일 <input type="email" name="email" required="required">
					</c:when>
					<c:otherwise>
								이메일 <input type="email" name="email" value="${email}" required="required">
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<input type="text" id="postcode" name="postcode" value="${socialJoinFormDto.postcode}" placeholder="우편번호" required="required">
						<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
						<br>
						<input type="text" id="address" name="address" placeholder="주소" value="${socialJoinFormDto.address}">
						<br>
						<input type="text" id="detailAddress" name="detailAddress" value="${socialJoinFormDto.detailAddress}" placeholder="상세주소">
						<div style="color: red;">
							<c:if test="${valid_address != null}">
							${valid_address}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<input type="text" id="postcode" name="postcode" placeholder="우편번호" required="required">
						<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
						<br>
						<input type="text" id="address" name="address" placeholder="주소">
						<br>
						<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				국적 <select name="nationality" required="required">
							<c:forEach var="countryNm" items="${countryNm}">
								<option value="${countryNm}" <c:if test="${countryNm.equals(\'대한민국\')}"> selected </c:if>>${countryNm}</option>
							</c:forEach>
						</select>
						<div style="color: red;">
							<c:if test="${valid_address != null}">
							${valid_address}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				국적 <select name="nationality" required="required">
							<c:forEach var="countryNm" items="${countryNm}">
								<option value="${countryNm}" <c:if test="${countryNm.equals(\'대한민국\')}"> selected </c:if>>${countryNm}</option>
							</c:forEach>
						</select>
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="grade">


				<button type="submit" class="btn btn-primary">회원가입</button>
				<button type="button" onclick="location.href='/'" class="btn btn-danger">취소</button>
			</div>
		</form>
	</div>

	<script src="/js/join.js"></script>
</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>