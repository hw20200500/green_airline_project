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

.validation--check {
	color: red;
}

.password--validation {
	color: black;
}
input[type=text]:focus {
	outline: none;
}
input[type=password]:focus {
	outline: none;
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
<script>
	let gender = `${joinFormDto.gender}`;
</script>
<main>
	<div>
		<h1>회원가입</h1>
		<form action="/joinProc" method="post">
			<div class="join--all--wrap">
				<c:choose>
					<%-- validation에 걸려서 돌아왔을 때 --%>
					<c:when test="${joinFormDto != null}">
						<div>
							아이디 <input type="text" name="id" value="${joinFormDto.id}" class="join--id--class" placeholder="Todo 수정 8~20자리">
							<button type="button" id="exists--id">아이디 중복확인</button>
							<div class="validation--check">
								<c:if test="${idValid != null}">
							${idValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<%-- 일반 회원가입 처리 --%>
					<c:otherwise>
						<div>
							아이디 <input type="text" name="id" id="member--id" placeholder="Todo 수정 8~20자리" value="asdfasdfas">
							<button type="button" id="exists--id">아이디 중복확인</button>
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${joinFormDto != null}">
						<div class="password--wrap">
							비밀번호 <input type="password" name="password" required="required" id="password"  placeholder="Todo 수정 8~20자리">
							<div class="validation--check">
								<c:if test="${passwordValid != null}">
							${passwordValid}
							</c:if>
							</div>
							비밀번호 확인 <input type="password" required="required" id="password--check">
						</div>
					</c:when>
					<c:otherwise>
						<div class="password--wrap">
							비밀번호 <input type="password" name="password" required="required" id="password" placeholder="Todo 수정 8~20자리"> 비밀번호 확인 <input type="password" required="required" id="password--check">
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${joinFormDto != null}">
						<div>
							한글 이름 <input type="text" name="korName" required="required" value="${joinFormDto.korName}">
							<div class="validation--check">
								<c:if test="${korNameValid != null}">
							${korNameValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							한글 이름 <input type="text" name="korName" required="required" value="강강">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${joinFormDto != null}">
						<div>
							영어 이름 <input type="text" name="engName" required="required" value="${joinFormDto.engName}">
							<div class="validation--check">
								<c:if test="${engNameValid != null}">
							${engNameValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							영어 이름 <input type="text" name="engName" required="required" value="KK">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${joinFormDto != null}">
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required" value="${joinFormDto.birthDate}">
						<div class="validation--check">
							<c:if test="${birthDateValid != null}">
							${birthDateValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required" value="2023-06-14">
					</c:otherwise>
				</c:choose>

				<div>
					<c:choose>
						<c:when test="${joinFormDto != null}">
								성별 <label> <input type="radio" name="gender" value="M" required="required" value="${joinFormDto.gender}" class="gender--input"> 남
							</label>
							<label> <input type="radio" name="gender" value="F" required="required" value="${joinFormDto.gender}" class="gender--input"> 여
							</label>
							<div class="validation--check">
								<c:if test="${genderValid != null}">
							${genderValid}
							</c:if>
							</div>
						</c:when>
						<c:otherwise>
								성별 <label> <input type="radio" name="gender" value="M" required="required"> 남
							</label>
							<label> <input type="radio" name="gender" value="F" required="required"> 여
							</label>
						</c:otherwise>
					</c:choose>

				</div>
				<c:choose>
					<c:when test="${joinFormDto != null}">
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required" value="${joinFormDto.phoneNumber}">
						<div class="validation--check">
							<c:if test="${phoneNumberValid != null}">
							${phoneNumberValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required" value="010-1234-1234">
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${joinFormDto != null}">
						이메일 <input type="text" name="email" required="required" value="${joinFormDto.email}">
						<div class="validation--check">
							<c:if test="${emailValid != null}">
							${emailValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						이메일 <input type="text" name="email" required="required" value="kmg1151@naver.com">
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${joinFormDto != null}">
						<div>
							<input type="text" id="address" name="address" placeholder="주소" required="required" value="${joinFormDto.address}"> <input type="button" onclick="execDaumPostcode()" value="주소 찾기"
								required="required"> <br> <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
							<div class="validation--check">
								<c:if test="${addressValid != null}">
							${addressValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							<input type="button" onclick="execDaumPostcode()" value="주소 찾기" > <br> <input type="text" id="address" name="address" placeholder="주소" value="부산 사상구 가야대로 1"> <br> <input type="text"
								id="detailAddress" name="detailAddress" placeholder="상세주소">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${joinFormDto != null}">
						국적 <select name="nationality" required="required">
							<c:forEach var="countryNm" items="${countryNm}">
								<option value="${countryNm}" <c:if test="${countryNm.equals(\'대한민국\')}"> selected </c:if>>${countryNm}</option>
							</c:forEach>
						</select>
						<div class="validation--check">
							<c:if test="${nationalityValid != null}">
							${nationalityValid}
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
				<button type="submit" class="btn btn-primary" id="join--btn">회원가입</button>
				<button type="button" onclick="location.href='/'" class="btn btn-danger">취소</button>
			</div>
		</form>
	</div>

	<script src="/js/join.js"></script>
</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>