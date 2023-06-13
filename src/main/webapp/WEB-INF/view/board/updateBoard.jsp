<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
.form--control {
	width: 1110px;
}

.board--write {
	display: flex;
	justify-content: center;
	align-items: center;
}

.container {
	margin-bottom: 30px;
}

.table td {
	border-top: none;
}
</style>
<main>
	<h2 class="page--title">여행일지</h2>
	<hr>
	<br>

	<form action="/board/update/${id}" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${id}">
		<table class="table">
			<tr>
				<td><input class="form-control" id="title" type="text" name="title" value="${boardDto.title}"></td>
			</tr>
		</table>
		<div class="container">
			<textarea class="summernote" id="summernote" name="content">${boardDto.content}</textarea>
		</div>
		<div class="custom-file">
			<input type="file" class="custom-file-input" id="customFile" accept=".jpg, .jpeg, .png" name="file">
			<label class="custom-file-label" for="customFile">${boardDto.fileName}</label>
		</div>
		<div style="margin-top: 40px;" class="d-flex justify-content-center">
			<button type="button" id="backPage" class="blue--btn--small" style="margin-right: 60px; padding-left: 9px; background-color: gray" onclick="location.href='/board/list/1'">
				<ul class="d-flex justify-content-center" style="margin: 0;">
					<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
					<li>취소
				</ul>
			</button>
			<button type="submit" class="blue--btn--small" id="writeBtn">
				<ul class="d-flex justify-content-center" style="margin: 0;">
					<li style="margin-right: 4px;">입력 완료
					<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">done</span>
				</ul>
			</button>
		</div>
	</form>
</main>
<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			height : 500,
			tabsize : 2,
			minHeight : null,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR'
		});
	});

	$(".custom-file-input").on(
			"change",
			function() {
				var fileName = $(this).val().split("\\").pop();
				$(this).siblings(".custom-file-label").addClass("selected")
						.html(fileName);
			});

	// 뒤로가기 버튼
	$(document).ready(function() {
		$("#backPage").on("click", function() {
			// form 제출 동작 중지
			event.preventDefault();

			var boardId = $("input[name='boardId']").val();
			var backConfirm = confirm("작성중인 게시글이 저장되지 않습니다.\n정말 나가시겠습니까?");
			if (backConfirm) {
				window.history.back();
			} else {
				return false;
			}
		});
	});
</script>

<input type="hidden" name="menuName" id="menuName" value="여행일지">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>