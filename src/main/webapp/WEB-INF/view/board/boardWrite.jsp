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
	<div class="board--write">
		<form action="/board/insert" method="post" enctype="multipart/form-data">

			<table class="table">
				<tr>
					<td><input class="form-control" id="title" type="text" name="title" placeholder="제목"></td>
				</tr>
			</table>
			<div class="container">
				<textarea class="summernote" id="content" rows="10" name="content"></textarea>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" id="customFile" accept=".jpg, .jpeg, .png" name="file"> 
				<label class="custom-file-label" for="customFile">썸네일용 이미지</label>
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
	</div>
</main>
<script>
	$(document).ready(function() {
		$('.summernote').summernote({
			placeholder : "내용을 입력 해주세요",
			height : 500,
			tabsize : 2,
			minHeight : null,
			maxHeight : null,
			// 에디터 로딩후 포커스를 맞출지 여부
			focus : true,
			lang : 'ko-KR',
			callbacks : {
				onInit : function(c) {
					c.editable.html('');
				}
			}
		});
	});

	function sendImg(file, context) {
		// 폼 데이터 형태로 바꾸기
		var data = new FormData();
		data.append('file', file);

		$.ajax({
			data : data,
			type : "POST",
			url : "/uploadFileName",
			cache : false,
			contentType : false,
			processData : false,
			success : function(imgUrl) {
				$(context).summernote('editor.insertImage', imgUrl);
			}
		});
	}

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
