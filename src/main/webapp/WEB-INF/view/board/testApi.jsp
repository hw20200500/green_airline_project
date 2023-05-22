<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="icon" type="image/x-icon" href="images/favicon.ico">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background-color: #3d4e56fa;
	margin: 0;
	padding: 0;
}

.body {
	display: flex;
}

button {
	width: 70px;
	height: 70px;
	border: none;
	border-radius: 8px;
	margin: 12px;
	cursor: move;
	font-size: 30px;
	background: #eaeaea4f;
}

.container {
	margin: 10px;
	padding: 10px;
	background-color: #b5c1dc57;
	border-radius: 8px;
}

.container2 {
	margin: 10px;
	padding: 55px;
	background-color: #b5c1dc57;
	border-radius: 8px;
}

.draggable.dragging {
	opacity: 0.5;
}
</style>


</head>
<body>
	<div class="body">
		<div class="container">
			<button class="draggable item" draggable="true">🦊</button>
		</div>
		<div class="container2"></div>
	</div>

</body>
<script>
function console(e) {
  if(document.querySelectorAll('p').length === 10) {
    document.querySelectorAll('p').forEach(e => e.remove())
  }
  const p = document.createElement('p');
  p.textContent = e;
  document.body.append(p);
}
const item = document.querySelector(".item");

item.addEventListener("dragstart", (e) => {
	console.log(e);
	console.log("드래그를 시작하면 발생하는 이벤트");
});
</script>


</html>