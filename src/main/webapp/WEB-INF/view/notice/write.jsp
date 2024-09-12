<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
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

<input type="hidden" name="menuName" id="menuName" value="공지사항">
<style>
input[type=text] {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 840px;
	background: #f8f9fc;
	padding: 10px;
	position: relative;
	margin-bottom: 20px;
	margin-right: 20px;
}

input[type=text]:focus {
	outline: none;
}

#categoryId:focus {
	outline: none;
}

#categoryId {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 300px;
	background: #f8f9fc;
	padding: 15px;
	position: relative;
	margin-bottom: 20px;
}

.btn--primary {
	margin-top: 20px;
	color: white;
	border: none;
	background-color: #8ABBE2;
}

.btn--primary:hover {
	color: white;
	border: none;
	background-color: #8ABBE2;
}

.btn--wrap {
	display: flex;
	justify-content: flex-end;
}

.noticeInsert--wrap{
	display: flex;
}
</style>
<div>
	<main>
		<h2 class="page--title">공지사항 작성</h2>
		<hr>
		<br>

		<form action="/notice/noticeInsert" method="post">
			<div class="noticeInsert--wrap">
				<div style="font-size: 22px;">
					제목 <input type="text" name="title">
				</div>
				<div>
					<select name="categoryId" id="categoryId">
						<optgroup label="카테고리">
							<c:forEach var="categoryList" items="${categoryList}">
								<option value="${categoryList.id}">${categoryList.name}</option>
							</c:forEach>
						</optgroup>
					</select>
				</div>
			</div>
			<textarea class="form-control summernote" rows="5" id="content" name="content"></textarea>
			<div class="btn--wrap">
				<button type="submit" class="btn btn--primary">올리기</button>
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
							[ 'view', [ 'fullscreen', 'codeview', 'help' ] ] ],
            focus: true,
            lang: 'ko-KR',
            callbacks: {
                onImageUpload: function(files) {
                    // 파일을 선택하면 sendImg 함수를 호출하여 이미지 업로드 처리
                    sendImg(files[0]);
                },
                onInit: function(c) {
                    c.editable.html('');
                }
            }
				});
		$(document).ready(function() {
			$('#summernote').summernote();
		});

		// 이미지 업로드 함수
        function sendImg(file) {
            var data = new FormData();
            data.append('file', file);

            $.ajax({
                url: '/uploadImage', // 서버에서 이미지를 처리할 엔드포인트
                type: 'POST',
                data: data,
                contentType: false,
                processData: false,
                success: function(imageUrl) {
                    // 서버에서 반환된 이미지 URL을 Summernote 에디터에 삽입
                    $('#content').summernote('insertImage', imageUrl);
                },
                error: function() {
                    alert('이미지 업로드 중 오류가 발생했습니다.');
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
	</script>
</div>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
