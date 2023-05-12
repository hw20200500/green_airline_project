<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/layout.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Modal content-->
<div class="modal-content">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
		<h4 id="modal-title" class="modal-title"></h4>
	</div>
	<div class="modal-body">
		<table class="table">
			<tr>
				<td>사용자명</td>
				<td><input class="form-control" id="userName" type="text"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea class="form-control" id="contents" rows="10"></textarea></td>
			</tr>
		</table>
	</div>
	<div class="modal-footer">
		<button id="modalSubmit" type="button" class="btn btn-success">Submit</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	</div>
</div>
