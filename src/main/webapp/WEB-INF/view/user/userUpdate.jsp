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
</style>

<script>
	let gender = `${meberById.gender}`;
</script>
<main>
	<div>
		<div>
			<h1>여기는 회원 정보 수정</h1>
			<p>비밀번호 확인 후 들어올 수 있음</p>
		</div>

		<div>
			<h3>기본 정보</h3>
		</div>
		<form action="/userUpdate" method="post">
			<div>
				<c:choose>
					<c:when test="${userFormDto != null}">
						<div>
							아이디 <input type="text" name="id" value="${userFormDto.id}">
							<div class="validation--check">
								<c:if test="${idValid != null}">
							${idValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							아이디 <input type="text" name="id" id="member--id" value="${principal.id}" readonly="readonly">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${userFormDto != null}">
						<div>
							한글 이름 <input type="text" name="korName" required="required" value="${userFormDto.korName}">
							<div class="validation--check">
								<c:if test="${korNameValid != null}">
							${korNameValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							한글 이름 <input type="text" name="korName" value="${meberById.korName}">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${userFormDto != null}">
						<div>
							영어 이름 <input type="text" name="engName" required="required" value="${userFormDto.engName}">
							<div class="validation--check">
								<c:if test="${engNameValid != null}">
							${engNameValid}
							</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							영어 이름 <input type="text" name="engName" value="${meberById.engName}">
						</div>
					</c:otherwise>
				</c:choose>



				<c:choose>
					<c:when test="${userFormDto != null}">
				생년월일 <input type="text" id="datepicker" name="birthDate" required="required" value="${userFormDto.birthDate}">
						<div class="validation--check">
							<c:if test="${birthDateValid != null}">
							${birthDateValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							생년월일 <input type="text" id="datepicker" name="birthDate" value="${meberById.birthDate}">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${userFormDto != null}">
								성별 <label> <input type="radio" name="gender" value="M" required="required" class="gender--input"> 남
						</label>
						<label> <input type="radio" name="gender" value="F" class="gender--input"> 여
						</label>
						<div class="validation--check">
							<c:if test="${genderValid != null}">
							${genderValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							성별 <label> <input type="radio" name="gender" value="M" class="gender--input"> 남
							</label> <label> <input type="radio" name="gender" value="F" class="gender--input"> 여
							</label>
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${userFormDto != null}">
				휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" required="required" value="${userFormDto.phoneNumber}">
						<div class="validation--check">
							<c:if test="${phoneNumberValid != null}">
							${phoneNumberValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							휴대전화 <input type="text" name="phoneNumber" placeholder="예:010-0000-0000" value="${meberById.phoneNumber}">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${userFormDto != null}">
						이메일 <input type="text" name="email" required="required" value="${userFormDto.email}">
						<div class="validation--check">
							<c:if test="${emailValid != null}">
							${emailValid}
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<div>
							이메일 <input type="text" name="email" value="${meberById.email}">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${userFormDto != null}">
						<div>
							<input type="text" id="address" name="address" placeholder="주소" required="required" value="${userFormDto.address}"> <input type="button" onclick="execDaumPostcode()" value="주소 찾기"
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
							<input type="text" id="address" name="address" value="${meberById.address}" placeholder="주소"> <input type="button" onclick="execDaumPostcode()" value="주소 찾기"> <br> <input
								type="text" id="detailAddress" name="detailAddress" value="${meberById.detailAddress}" placeholder="상세주소">
						</div>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${userFormDto != null}">
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
						<div>
							국적 <select name="nationality">
								<c:forEach var="countryNm" items="${countryNm}">
									<option value="${countryNm}" <c:if test="${countryNm.equals(\'대한민국\')}"> selected </c:if>>${countryNm}</option>
								</c:forEach>
							</select>
						</div>
					</c:otherwise>
				</c:choose>

				<div>
					<input type="text" name="grade" readonly="readonly" value="${meberById.grade}">
				</div>
			</div>

			<div>
				<button type="submit" class="btn btn-primary" id="join--btn">수정</button>
				<button type="button" onclick="location.href='/'" class="btn btn-danger">취소</button>
			</div>

		</form>
	</div>

	<script src="/js/join.js"></script>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
