<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<!DOCTYPE html>
<main>
	<form action="/board/insert" method="post">

		<h5>여행일지</h5>

		<table class="table">
			<tr>
				<td>제목</td>
				<td><input class="form-control" id="title" type="text"
					name="title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea class="form-control" id="content" rows="10"
						name="content"></textarea></td>
			</tr>
			<tr>
				<td>사진 업로드</td>
				
			</tr>
		</table>
		<div class="modal-footer">
			<button type="submit" class="btn btn-primary">작성하기</button>
		</div>
	</form>
</main>
<script src="/js/test.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
