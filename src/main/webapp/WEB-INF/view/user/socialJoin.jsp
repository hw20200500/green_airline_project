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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
.join--all--wrap {
	display: flex;
	flex-direction: column;
}
</style>
<script>
	let gender = `${gender}`;
</script>
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
							<c:if test="${idValid != null}">
							${idValid}
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
							<c:if test="${korNameValid != null}">
							${korNameValid}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				한국 이름 <input type="text" name="korName" required="required" value="ㅇㅇ">
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				영어 이름 <input type="text" name="engName" required="required" value="${socialJoinFormDto.engName}">
						<div style="color: red;">
							<c:if test="${engNameValid != null}">
							${engNameValid}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				영어 이름 <input type="text" name="engName" required="required" value="DDD">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required" value="${socialJoinFormDto.birthDate}">
						<div style="color: red;">
							<c:if test="${birthDateValid != null}">
							${birthDateValid}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required" value="2000-01-18">
					</c:otherwise>
				</c:choose>

				<div class="gender--wrap">
					<c:choose>
						<c:when test="${socialJoinFormDto != null}">
							성별 <label> <input type="radio" name="gender" value="M" required="required" class="gender--input"> 남
							</label>
							<label> <input type="radio" name="gender" required="required" value="F" class="gender--input"> 여
							</label>
							<div style="color: red;">
								<c:if test="${genderValid != null}">
								${genderValid}
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
								성별 <label> <input type="radio" name="gender" value="M" required="required" class="gender--input"> 남
							</label>
							<label> <input type="radio" name="gender" required="required" value="F" class="gender--input"> 여
							</label>
						</c:otherwise>
					</c:choose>
				</div>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
						<div style="color: red;">
							<c:if test="${phoneNumberValid != null}">
							${phoneNumberValid}
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required" value="010-1234-123">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						이메일 <input type="text" name="email" value="${email}" required="required">
						<div style="color: red;">
							<c:if test="${emailValid != null}">
							${emailValid}
						</c:if>
						</div>
					</c:when>
					<c:when test="${email.equals(\"none\")}">
								이메일 <input type="email" name="email" required="required">
					</c:when>
					<c:otherwise>
								이메일 <input type="email" name="email" value="${email}" required="required" value="kmg1151@naver.com">
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<input type="text" id="address" name="address" placeholder="주소" required="required" value="${socialJoinFormDto.address}">
						<input type="button" onclick="execDaumPostcode()" value="주소 찾기" required="required">
						<br>
						<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
						<div style="color: red;">
							<c:if test="${addressValid != null}">
							${addressValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<input type="text" id="address" name="address" placeholder="주소" required="required" value="부산 사상구 가야대로 1">
						<input type="button" onclick="execDaumPostcode()" value="주소 찾기" required="required">
						<br>
						<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" value="1">
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
							<c:if test="${addressValid != null}">
							${addressValid}
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
