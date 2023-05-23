<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="icon" type="image/x-icon" href="images/favicon.ico">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>

<div class="character" draggable="true"></div>

<div class="character" draggable="true"></div>
<div class="box">드래그 가능</div>

<div class="character" draggable="true"></div>
<div class="box">드롭 영역</div>

</body>
<script>
const box = document.querySelector('.box');

box.addEventListener('dragenter', () => {
  console.log('dragenter 이벤트');
});

box.addEventListener('dragover', () => {
  console.log('dragover 이벤트');
});

box.addEventListener('dragleave', () => {
  console.log('dragleave 이벤트');
});
</script>


</html>