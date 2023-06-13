<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
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

main {
	font-size: 18px;
}

input[type=text], input[type=password] {
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

#userUpdate--nation--select {
	border: 1px solid #ebebeb;
	padding: 10px;
	border-radius: 5px;
	width: 600px;
	outline: none;
}

.userUpdate--gender--wrap {
	display: flex;
	justify-content: space-between;
	flex-direction: column;
	margin-right: 20px;
}

.userUpdate--all--wrap {
	width: 1200px;
	display: flex;
}

.userUpdate--telphone--wrap {
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
}

.join--id--class, .userUpdate--id--wrap, .userUpdate--korName, .userUpdate--engName, .userUpdate--birthDate, .userUpdate--gender, .userUpdate--phoneNumber {
	margin-bottom: 20px;
}

.btn--primary {
	background-color: #8ABBE2;
	color: white;
	margin-top: 20px;
	width: 200px;
	height: 50px;
}

.btn--primary:hover {
	background-color: #8ABBE2;
	color: white;
	margin-top: 20px;
}

.userUpdate--btn--wrap {
	display: flex;
	justify-content: center;
}

.address--btn {
	background-color: #8ABBE2;
	color: white;
	margin-top: 20px;
	border: none;
	width: 100px;
	height: 30px;
	border-radius: 5px;
}
</style>

<script>
	let gender = `${memberById.gender}`;
</script>
<main>
	<div>
		<div>
			<h2 class="page--title">회원정보 변경</h2>
			<hr>
			<br>
		</div>

		<div>
			<h3>기본 정보</h3>
		</div>
		<form action="/userUpdate" method="post">
			<div class="userUpdate--all--wrap">
				<div class="userUpdate--gender--wrap">
					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="join--id--class">
								아이디 <br> <input type="text" name="id" value="${userFormDto.id}" readonly="readonly">
								<div class="validation--check">
									<c:if test="${idValid != null}">
							${idValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--id--wrap">
								아이디 <br> <input type="text" name="id" id="member--id" value="${principal.id}" readonly="readonly">
							</div>
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="userUpdate--korName">
								한글 이름 <br> <input type="text" name="korName" required="required" value="${userFormDto.korName}">
								<div class="validation--check">
									<c:if test="${korNameValid != null}">
							${korNameValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--korName">
								한글 이름 <br> <input type="text" name="korName" value="${memberById.korName}">
							</div>
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="userUpdate--engName">
								영어 이름 <br> <input type="text" name="engName" required="required" value="${userFormDto.engName}">
								<div class="validation--check">
									<c:if test="${engNameValid != null}">
							${engNameValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--engName">
								영어 이름 <br> <input type="text" name="engName" value="${memberById.engName}">
							</div>
						</c:otherwise>
					</c:choose>



					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="userUpdate--birthDate">
								생년월일 <br> <input type="text" id="datepicker" name="birthDate" readonly="readonly" value="${userFormDto.birthDate}">
								<div class="validation--check">
									<c:if test="${birthDateValid != null}">
							${birthDateValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--birthDate">
								생년월일<br> <input type="text" id="datepicker" name="birthDate" value="${memberById.birthDate}" readonly="readonly">
							</div>
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="userUpdate--gender">
								성별 <label> <input type="radio" name="gender" value="M" required="required" class="gender--input"> 남
								</label> <label> <input type="radio" name="gender" value="F" class="gender--input"> 여
								</label>
								<div class="validation--check">
									<c:if test="${genderValid != null}">
							${genderValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--gender">
								성별 <label> <input type="radio" name="gender" value="M" class="gender--input"> 남
								</label> <label> <input type="radio" name="gender" value="F" class="gender--input"> 여
								</label>
							</div>
						</c:otherwise>
					</c:choose>

				</div>

				<div class="userUpdate--telphone--wrap">
					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="userUpdate--phoneNumber">
								휴대전화<br> <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required" value="${userFormDto.phoneNumber}">
								<div class="validation--check">
									<c:if test="${phoneNumberValid != null}">
							${phoneNumberValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--phoneNumber">
								휴대전화 <br> <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" value="${memberById.phoneNumber}">
							</div>
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="userUpdate--email">
								이메일 <br> <input type="text" name="email" required="required" value="${userFormDto.email}">
								<div class="validation--check">
									<c:if test="${emailValid != null}">
							${emailValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--email">
								이메일 <br> <input type="text" name="email" value="${memberById.email}">
							</div>
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${userFormDto != null}">
							<div class="userUpdate--address">
								주소 <input type="button" class="address--btn" onclick="execDaumPostcode()" value="주소 찾기" required="required"> <br> <input type="text" id="address" name="address" placeholder="주소"
									required="required" value="${userFormDto.address}"> <br> <input type="text" id="detailAddress" placeholder="상세주소">
								<div class="validation--check">
									<c:if test="${addressValid != null}">
							${addressValid}
							</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="userUpdate--address">
								주소 <input type="button" class="address--btn" onclick="execDaumPostcode()" value="주소 찾기"> <br> <input type="text" id="address" name="address" value="${memberById.address}"
									placeholder="주소"><br> <input type="text" id="detailAddress" placeholder="상세주소">
							</div>
						</c:otherwise>
					</c:choose>
					
					<input type="hidden" name="nationality">

				</div>
			</div>
			<div class="userUpdate--btn--wrap">
				<button type="submit" class="btn btn--primary" id="join--btn" onclick="return confirm('정말 수정하시겠습니까?')">회원정보 변경</button>
			</div>

		</form>
	</div>

	<script src="/js/userUpdate.js"></script>
</main>
<input type="hidden" name="menuName" id="menuName" value="회원정보 변경">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
