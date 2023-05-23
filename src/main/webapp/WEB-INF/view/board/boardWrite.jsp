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
			onInit : function(c) {
				c.editable.html('');
			}
		}
	}); */
	
	$('.summernote').summernote({
		placeholder : "내용을 입력 해주세요",
		tabsize : 2,
		height : 500,
		// 에디터 로딩후 포커스를 맞출지 여부
		focus : true,
		lang : 'ko-KR',
		// 크기 조절 기능 삭제
		disableResizeEditor : true,
		callbacks : {
			onImageUpload: function(files, editor, welEdittable) {
				// 파일 사이즈 체크
	            for (var i = files.length - 1; i >= 0; i--) {
	            	if(files[i].size > 1024*1024*5){
	            		alert("이미지가 5MB 미만입니다.");
	            		return;
	            	}
	            	for(var i = files.length - 1; i >= 0; i--){
	            		sendImg(files[i], this,'/board/uploadFileName')
	            	}
	            }
			}
		}
	});
	
	function sendImg(file, el, uploadURL) {
		// 폼 데이터 형태로 바꾸기
		var form_data = new FormData();
      	form_data.append('file', file);
      	
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: uploadURL,
        	cache: false,
        	contentType: false,
        	/* enctype: 'multipart/form-data', */
        	processData: false,
        	success: function(img_url) {
          		$(el).summernote('editor.insertImage', img_url);
        	}
      	});
    }
</script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
