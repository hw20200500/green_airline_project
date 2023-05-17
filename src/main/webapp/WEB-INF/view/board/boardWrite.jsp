<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
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
				<td>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="customFile">
						<label class="custom-file-label" for="customFile">Choose
							file</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>작성자 id</td>
				<td><input class="form-control" id="userId" type="text"
					name="userId"></td>
			</tr>
			<tr>
				<td>조회수</td>
				<td><input class="form-control" id="viewCount" type="text"
					name="viewCount"></td>
			</tr>
		</table>
		<div class="modal-footer">
			<button type="submit" class="btn btn-primary">작성하기</button>
		</div>
	</form>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
