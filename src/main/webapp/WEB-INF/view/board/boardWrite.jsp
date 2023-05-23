<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
.form-control {
	width: 1110px;
	margin-left: 70px;
}
</style>
<main>
	<h5>여행일지</h5>

	<form action="/board/insert" method="post">

		<table class="table">
			<tr>
				<td><input class="form-control" id="title" type="text"
					name="title" placeholder="제목"></td>
			</tr>
		</table>
		<div class="container">
			<textarea class="summernote" id="content" rows="10" name="content"></textarea>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-primary">작성하기</button>
		</div>
	</form>
</main>
<script>
	$('.summernote').summernote({
		placeholder : "내용을 입력 해주세요",
		tabsize : 2,
		height : 400,
		// 에디터 로딩후 포커스를 맞출지 여부
		focus : true,
		lang : 'ko-KR',
		// 크기 조절 기능 삭제
		disableResizeEditor : true,
		callbacks : {
			onInit : function(c) {
				c.editable.html('');
			}
		}
	});
	
/* 	$('.summernote').summernote({
		placeholder : "내용을 입력 해주세요",
		tabsize : 2,
		height : 400,
		// 에디터 로딩후 포커스를 맞출지 여부
		focus : true,
		lang : 'ko-KR',
		// 크기 조절 기능 삭제
		disableResizeEditor : true,
		callbacks : {
			onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            	sendFile(files[i], this);
	            }
			}
		}
	});
	
	function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: './profileImage.mpf',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(img_name) {
          		$(el).summernote('editor.insertImage', img_name);
        	}
      	});
    } */
</script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
