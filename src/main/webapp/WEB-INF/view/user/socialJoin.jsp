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
.join--head--wrap {
	margin-bottom: 20px;
}

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

input[type=text], input[type=password], input[type=email] {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 600px;
	background: #f8f9fc;
	padding: 10px;
	position: relative;
}

input[type=text]:focus, input[type=password]:focus {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 600px;
	background: #f8f9fc;
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

.join--id--class {
	margin-bottom: 20px;
}

main {
	display: flex;
	justify-content: center;
}

.join--border--wrap {
	display: flex;
	justify-content: center;
	flex-direction: column;
	width: 600px;
	border-radius: 5px;
	padding: 20px;
}

/* input[type=text], input[type=password] {
	border: 1px solid #ebebeb;
	border-radius: 10px;
	width: 680px;
	padding: 10px;
} */
.join--input--btn--class {
	display: flex;
	justify-content: space-between;
}

/* main {
	width: 100%;
	margin-top: -20px;
} */
#join--nation--select {
	border: 1px solid #ebebeb;
	padding: 10px;
	border-radius: 5px;
	width: 600px;
	outline: none;
}

.btn--primary {
	border: none;
	width: 290px;
	color: white;
	margin-top: 20px;
	background-color: #8ABBE2;
}

.btn--primary:hover {
	width: 290px;
	background-color: #8ABBE2;
	color: white;
	margin-top: 20px;
}

/* 색상 수정 예정 */
.btn--danger {
	background: #c0c0c0;
	color: white;
	margin-top: 20px;
	margin-left: 10px;
	width: 100px;
	padding: 20px;
	width: 290px;
}

.btn--danger:hover {
	background: #ebebeb;
	color: white;
	margin-top: 20px;
	margin-left: 10px;
	width: 100px;
	padding: 20px;
	width: 290px;
}

.join--btn--wrap {
	width: 600px;
	display: flex;
	justify-content: flex-end;
}

#join--btn {
	width: 300px;
}

main {
	font-size: 18px;
}

.password--wrap, .korName--wrap, .engName--wrap, .birthDate--wrap,
	.gender--wrap, .phoneNumber--wrap, .email--wrap, .address--wrap,
	.nationality--wrap {
	margin-bottom: 20px;
}
</style>
<script>
	let gender = `${gender}`;
</script>
<main>
	<div class="join--border--wrap">
		<div class="join--head--wrap">
			<h2>회원가입</h2>
			<p>회원이 되어 다양한 혜택을 경험해 보세요!</p>
		</div>
		<form action="/apiSocialJoinProc" method="post">
			<div class="join--all--wrap">
				<c:choose>
					<%-- validation 처리에 걸려서 돌아왔을 때 --%>
					<c:when test="${socialJoinFormDto != null}">
						<div class="join--id--class">
							<div class="join--id--class2">
								아이디 <br>
								<div class="join--input--btn--class">
									<div style="position: relative;">
										<input type="text" name="id" value="${socialJoinFormDto.id}" readonly="readonly">
										<div style="color: red;">
											<c:if test="${idValid != null}">
												${idValid}
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<%-- 소셜 회원가입 처리 --%>
					<c:otherwise>
						<div class="join--id--class">
							<div class="join--id--class2">
								아이디 <br> <input type="text" name="id" value="${id}" readonly="readonly">
							</div>
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<div class="korName--wrap">
							한국 이름<br> <input type="text" name="korName" required="required" value="${socialJoinFormDto.korName}">
							<div style="color: red;">
								<c:if test="${korNameValid != null}">
									${korNameValid}
								</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="korName--wrap">
							한국 이름 <input type="text" name="korName" required="required">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<div class="engName--wrap">
							영어 이름 <br> <input type="text" name="engName" required="required" value="${socialJoinFormDto.engName}">
							<div style="color: red;">
								<c:if test="${engNameValid != null}">
									${engNameValid}
								</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="engName--wrap">
							영어 이름 <input type="text" name="engName" required="required">
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<div class="birthDate--wrap">
							생년월일 <br> <input type="text" id="datepicker" name="birthDate" required="required" value="${socialJoinFormDto.birthDate}">
							<div style="color: red;">
								<c:if test="${birthDateValid != null}">
							${birthDateValid}
						</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="birthDate--wrap">
							생년월일 <input type="text" id="datepicker" name="birthDate" required="required">
						</div>
					</c:otherwise>
				</c:choose>

				<div class="gender--wrap">
					<c:choose>
						<c:when test="${socialJoinFormDto != null}">
							<div class="gender--wrap">
								성별 <label> <input type="radio" name="gender" value="M" required="required" class="gender--input"> 남성
								</label> <label> <input type="radio" name="gender" required="required" value="F" class="gender--input"> 여성
								</label>
								<div style="color: red;">
									<c:if test="${genderValid != null}">
								${genderValid}
								</c:if>
								</div>
							</div>
						</c:when>
						<c:when test="${gender.equals(\"none\")}">
							<div class="gender--wrap">
								성별 <label> <input type="radio" name="gender" value="M" required="required"> 남
								</label> <label> <input type="radio" name="gender" required="required" value="F"> 여
								</label>
							</div>
						</c:when>
						<c:otherwise>
							<div class="gender--wrap">
								성별 <label> <input type="radio" name="gender" value="M" required="required" class="gender--input"> 남
								</label> <label> <input type="radio" name="gender" required="required" value="F" class="gender--input"> 여
								</label>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<div class="phoneNumber--wrap">
							휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
							<div style="color: red;">
								<c:if test="${phoneNumberValid != null}">
							${phoneNumberValid}
						</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="phoneNumber--wrap">
							휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required">
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<div class="email--wrap">
							이메일 <input type="text" name="email" value="${socialJoinFormDto.email}" required="required">
							<div style="color: red;">
								<c:if test="${emailValid != null}">
									${emailValid}
								</c:if>
							</div>
						</div>
					</c:when>
					<c:when test="${email.equals(\"none\")}">
						<div class="email--wrap">
							이메일 <input type="email" name="email" required="required">
						</div>
					</c:when>
					<c:otherwise>
						<div class="email--wrap">
							이메일 <input type="email" name="email" value="${email}" required="required">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<div style="position: relative;" class="address--wrap">
							주소 <input type="text" id="address" name="address" placeholder="주소" required="required" value="${socialJoinFormDto.address}"> <input type="button" onclick="execDaumPostcode()"
								value="주소 찾기" required="required" style="position: absolute; right: -33px; top: 13px; width: 90px; height: 38px;" class="btn--primary"> <br> <input type="text" id="detailAddress"
								name="detailAddress" placeholder="상세주소">
							<div style="color: red;">
								<c:if test="${addressValid != null}">
							${addressValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div style="position: relative;" class="address--wrap">
							주소 <input type="text" id="address" name="address" placeholder="주소" required="required"> <input type="button" class="btn--primary" onclick="execDaumPostcode()"
								value="주소 찾기" required="required" style="position: absolute; right: -33px; top: 13px; width: 90px; height: 38px;"> <br> <input type="text" id="detailAddress" name="detailAddress"
								placeholder="상세주소">
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${socialJoinFormDto != null}">
						<div class="nationality--wrap">
							국적 <select name="nationality" required="required" id="join--nation--select">
								<c:forEach var="countryNm" items="${countryNm}">
									<option value="${countryNm}" <c:if test="${countryNm.equals(\'대한민국\')}"> selected </c:if>>${countryNm}</option>
								</c:forEach>
							</select>
							<div style="color: red;">
								<c:if test="${addressValid != null}">
							${addressValid}
						</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="nationality--wrap">
							국적 <select name="nationality" required="required" id="join--nation--select">
								<c:forEach var="countryNm" items="${countryNm}">
									<option value="${countryNm}" <c:if test="${countryNm.equals(\'대한민국\')}"> selected </c:if>>${countryNm}</option>
								</c:forEach>
							</select>
						</div>
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="grade">

				<div class="join--btn--wrap">
					<button type="submit" class="btn btn--primary">회원가입</button>
					<button type="button" onclick="location.href='/'" class="btn btn--danger">취소</button>
				</div>
			</div>
		</form>
	</div>

	<script src="/js/join.js"></script>
</main>

<input type="hidden" name="menuName" id="menuName" value="">
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
