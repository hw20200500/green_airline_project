<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
</style>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
.noticeUpdate--wrap {
	display: flex;
	flex-direction: column;
}

.noticeUpdate--title {
	font-size: 25px;
	margin-bottom: 10px;
	display: flex;
	align-items: center;
}

.noticeUpdate--category {
	display: flex;
	justify-content: space-between;
}

#categoryId {
	border: none;
	padding: 10px;
	width: 300px;
	border-bottom: 1px solid #ddd;
	background-color: #f8f9fc;
	font-size: 22px;
	margin-left: 20px;
}

.title--wrap {
	margin-left: 10px;
	width: 810px;
	border: none;
	border-bottom: 1px solid black;
	padding: 5px;
}

.btn--primary {
	background-color: #8ABBE2;
	color: white;
	margin-top: 20px;
	border: none;
	padding: 10px;
	border-radius: 5px;
}

</style>
<div>
	<main>
		<h2 class="page--title">공지사항 수정</h2>
		<hr>
		<br>

		<form action="/notice/noticeUpdate" method="post">
			<input type="hidden" name="id" value="${id}">
			<div class="noticeUpdate--wrap">
				<div class="noticeUpdate--title">
					제목 <input type="text" name="title" class="title--wrap" value="${noticeResponseDto.title}"> <select name="categoryId" id="categoryId">
						<optgroup label="카테고리">
							<c:forEach var="categoryList" items="${categoryList}">
								<option value="${categoryList.id}">${categoryList.name}</option>
							</c:forEach>
						</optgroup>
					</select>
				</div>
			</div>
			<textarea class="form-control summernote" rows="5" id="content" name="content">${noticeResponseDto.content}</textarea>
			<div class="btn--wrap">
				<button type="submit" class="btn--primary">작성 완료</button>
			</div>
		</form>
	</main>

	<script>
		$('.summernote').summernote(
				{
					tabsize : 2,
					height : 500,
					toolbar : [ [ 'style', [ 'style' ] ],
							[ 'font', [ 'bold', 'underline', 'clear' ] ],
							[ 'color', [ 'color' ] ],
							[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
							[ 'table', [ 'table' ] ],
							[ 'insert', [ 'link', 'picture', 'video' ] ],
							[ 'view', [ 'fullscreen', 'codeview', 'help' ] ] ]
				});
		$(document).ready(function() {
			$('#summernote').summernote();
		});

		$(".custom-file-input").on(
				"change",
				function() {
					var fileName = $(this).val().split("\\").pop();
					$(this).siblings(".custom-file-label").addClass("selected")
							.html(fileName);
				});
	</script>
</div>

<input type="hidden" name="menuName" id="menuName" value="공지사항">
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
