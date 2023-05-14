<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal -->
<form action="/board/insert" method="post">
	<div class="modal fade" id="staticBackdrop" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 모달 내용 입력 -->
					<table class="table">
						<tr>
							<td>제목</td>
							<td><input class="form-control" id="title" type="text" name="title"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea class="form-control" id="content" rows="10" name="content"></textarea></td>
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
							<td><input class="form-control" id="userId" type="text" name="userId"></td>
						</tr>
						<tr>
							<td>조회수</td>
							<td><input class="form-control" id="viewCount" type="text" name="viewCount"></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">작성하기</button>
				</div>
			</div>
		</div>
	</div>
</form>
