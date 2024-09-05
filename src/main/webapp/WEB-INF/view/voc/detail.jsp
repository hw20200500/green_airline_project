<%@page import="com.green.airline.utils.Define"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<link rel="stylesheet" href="/css/ticket.css">

<input type="hidden" name="menuName" id="menuName" value="고객의 말씀">

<style>
.list--table--reverse td {
	font-size: 17px;
	padding: 10px 5px 10px 20px;
}

td#contentCell{
    white-space: pre-line;
}

.list--table--reverse th {
	width: 300px;
	height: 52.5px;
}

input[name="title"], .info--input, textarea {
	border: none;
	outline: none;
	padding: 3px 0;
	border-radius: 5px;
}

textarea {
	width: 100%;
	padding: 7px 0;
	font-size: 16px;
	resize: none;
}

textarea[name="content"] {
	background-color: #eee;
	padding: 7px 10px !important;
	height: 350px;
}

#answerTable td {
	border: 2px solid #ccc !important;
}

#answerContentFixed, #contentArea {
	height: 350px;
}

#answerForm th {
	background-color: #e5e5e5 !important;
}

#answerForm td {
	padding-top: 12px;
}

#answerForm {
	display: none;
}

</style>

<!-- 고객의 말씀 상세 페이지 -->

<main class="d-flex flex-column">
	<h2 class="page--title">고객의 말씀</h2>
	<hr>
	<br>
	
	<div class="d-flex justify-content-center" style="width: 100%;">
		<div class="d-flex flex-column" style="width: 1000px">
			<div class="d-flex justify-content-between align-items-start">
				<h5 class="middle--title" style="margin-left: -4px;">
					<span style="font-size: 28px; margin-right: 3px;" class="material-symbols-outlined">person</span> <span>고객 정보</span>
				</h5>
				<c:if test="${\"관리자\".equals(principal.userRole)}">
					<button class="white--btn" onclick="location.href='/manager/memberDetail/${member.id}'" style="width: 160px; ma`">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">person_search</span>
							<li style="font-size: 15px;">고객 정보 조회
						</ul>
					</button>
				</c:if>
			</div>
			<table border="1" class="list--table--reverse">
				<tr>
					<th>성함</th>
					<td>${member.korName}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${member.birthDate}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="tel" name="phoneNumber" value="${voc.phoneNumber}" class="info--input" readonly></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" value="${voc.email}" class="info--input" readonly></td>
				</tr>
			</table>

			<br> <br>

			<h5 class="middle--title" style="margin-left: -4px;">
				<span style="font-size: 28px; margin-right: 5px;" class="material-symbols-outlined">edit_document</span>
				<span>작성된 내용</span>
			</h5>
			<table border="1" class="list--table--reverse">
				<tr>
					<th>작성일자</th>
					<td>${voc.formatCreatedAt()}</td>
				</tr>
				<tr>
					<th>유형</th>
					<td>${voc.type}</td>
				</tr>
				<tr>
					<th>분야</th>
					<td>${voc.categoryName}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" autocomplete="false" maxlength="50" value="${voc.title}" readonly></td>
				</tr>
				<tr>
					<th>내용</th>
					<td id="contentCell">
						${voc.content}
					</td>
				</tr>
				<c:if test="${voc.ticketId != null}">
					<tr>
						<th>예약번호</th>
						<td>${voc.ticketId}</td>
					</tr>
				</c:if>
			</table>
			
			<!-- 답변이 완료됐다면 답변 내용 출력 -->
			<c:if test="${voc.answerId != null}">
				<br><br>
				<hr style="width: 1100px; margin-left: -50px;">
				<br>
				<h5 class="middle--title" style="margin-left: -3px;">
					<span style="font-size: 28px; margin-right: 4px;" class="material-symbols-outlined">support_agent</span>
					<span>답변 완료</span>
				</h5>
				<table border="1" class="list--table--reverse" id="answerTable">
					<tr>
						<td>
							<textarea id="answerContentFixed" readonly>${voc.answerContent}</textarea>
						</td>
					</tr>
				</table>
			</c:if>
			
			<div style="margin-top: 40px;" class="d-flex justify-content-center">
				<c:choose>
					<c:when test="${principal.userRole.equals(\"관리자\")}">	
						<button type="button" class="blue--btn--small" id="goListBtn" style="padding-left: 9px; background-color: gray" onclick="location.href='/voc/list/not/1'">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
								<li>목록
							</ul>
						</button>
						<c:if test="${voc.answerId == null}">
							<span style="margin: 0 30px"></span>
							<button type="button" class="blue--btn--small" id="answerBtn">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li style="margin-right: 4px;">답변 작성
									<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">edit</span>
								</ul>
							</button>
						</c:if>
					</c:when>
					<c:otherwise>
							<button type="button" class="blue--btn--small" style="padding-left: 9px; background-color: gray" onclick="location.href='/voc/list/1'">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
									<li>목록
								</ul>
							</button>
						<%-- 수정은 답변이 달리지 않았을 때에만 가능 --%>
						<c:if test="${voc.answerId == null}">
							<span style="margin: 0 30px"></span>
							<button type="button" class="blue--btn--small" style="margin: 0 10px" onclick="location.href='/voc/update/${id}'">
								<ul class="d-flex justify-content-center" style="margin: 0;">
									<li style="margin-right: 4px;">수정
									<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">edit</span>
								</ul>
							</button>
						</c:if>
						<c:if test="${voc.answerId != null}">
							<span style="margin: 0 30px"></span>
						</c:if>
						<button type="button" class="blue--btn--small" id="vocDeleteBtn" style="margin: 0 10px">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li style="margin-right: 4px;">삭제
								<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">delete_forever</span>
							</ul>
						</button>
					</c:otherwise>
				</c:choose>
			</div>
			
			<!-- 답변 작성 폼 -->
			<c:if test="${voc.answerId == null}">
				<form id="answerForm" action="/voc/answer/${id}" method="post">
					<br><br>
					<hr style="width: 1100px; margin-left: -50px;">
					<br>
					<h5 class="middle--title" style="margin-left: -3px;">
						<span style="font-size: 28px; margin-right: 4px;" class="material-symbols-outlined">support_agent</span>
						<span>답변 작성</span>
					</h5>
					<table border="1" class="list--table--reverse">
						<tr>
							<th>양식</th>
							<td>
								<label><input type="radio" name="type" value="문의">&nbsp;문의</label>&nbsp;&nbsp;&nbsp;
								<label><input type="radio" name="type" value="칭찬">&nbsp;칭찬</label>&nbsp;&nbsp;&nbsp;
								<label><input type="radio" name="type" value="불만">&nbsp;불만</label>&nbsp;&nbsp;&nbsp;
								<label><input type="radio" name="type" value="건의">&nbsp;건의</label>
							</td>
						</tr>
						<tr>
							<th>답변</th>
							<td>
								<textarea name="content" id="answerContentArea"></textarea>
							</td>
						</tr>
					</table>
					
					<div style="margin-top: 40px;" class="d-flex justify-content-center">
						<button type="button" class="blue--btn--small" id="answerCloseBtn" style="margin-right: 60px; background-color: gray">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li style="margin-right: 4px;">취소
								<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">close</span>
							</ul>
						</button>
						<button type="submit" class="blue--btn--small">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li style="margin-right: 4px;">입력 완료
								<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">done</span>
							</ul>
						</button>
					</div>
				</form>
			</c:if>
			
		</div>
	</div>

</main>

<script>

	$(document).ready(function() {
		// 게시글 삭제 버튼
		$("#vocDeleteBtn").on("click", function() {
			
			// 질문 -> 예 : true, 아니오 : false 저장
			let isDelete = confirm("해당 내역을 삭제하시겠습니까?");
			
			// 예 (true)를 선택했다면 삭제 진행
			if (isDelete) {		
				$.ajax({
					type: 'DELETE',
					url: '/voc/delete/' + ${voc.id}
				})
				.done((res) => {
					console.log(res);
					location.href="/voc/list/1";
				})
				.fail((error) => {
					console.log(error);
				});
			}
		});
		
		// 답변 작성 폼 활성화 버튼
		$("#answerBtn").on("click", function() {
			
			if (${principal == null}) {
				return;
			// 관리자만 해당 폼을 활성화할 수 있게
	  		} else {
				let userRole = `${principal.userRole}`;
				if (userRole != '관리자') {
					return;
				}			  			
	  		}
			
			$("#answerForm").show();
			$("#answerBtn").hide();
			$("#goListBtn").css("margin", "0");
			window.scrollTo(0, document.body.scrollHeight);
			
		});
		
		$("#answerCloseBtn").on("click", function() {
			
			$("#answerForm").hide();
			$("#answerContentArea").val("");
			$("#answerBtn").show();
			$("#goListBtn").css("margin-right", "60px");
			
		});
		
		$("input[name=\"type\"]").on("change", function() {
			let typeName = $(this).val();
			let formText = "";
			
			if (typeName == '문의') {
				formText = `${formList.get(0).content}`;
			} else if (typeName == '칭찬') {
				formText = `${formList.get(1).content}`;
			} else if (typeName == '불만') {
				formText = `${formList.get(2).content}`;
			} else {
				formText = `${formList.get(3).content}`;
			}
			$("#answerContentArea").val(formText);
		});
		
		
		// 고객의 말씀 유형에 따라 선택
		let type = `${voc.type}`;
		for (let i = 0; i < $("input[name=\"type\"]").length; i++) {
			let target = $("input[name=\"type\"]").eq(i);
			if (target.val() == type) {
				target.prop("checked", true);
				
				if (target.val() == '문의') {
					$("#answerContentArea").val(`${formList.get(0).content}`);
				} else if (target.val() == '칭찬') {
					$("#answerContentArea").val(`${formList.get(1).content}`);
				} else if (target.val() == '불만') {
					$("#answerContentArea").val(`${formList.get(2).content}`);
				} else {
					$("#answerContentArea").val(`${formList.get(3).content}`);
				}
			}
		}
	});
	
	
</script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
