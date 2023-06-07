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

input[type="text"], input[type="file"], input[type="number"] {
	border: none;
	outline: none;
	padding: 3px 5px;
	border-radius: 5px;
	width: 100%;
}

.btn-right{
	width: 150px;
}

.list--table--reverse th {
	width: 30%;
}

.list--table--reverse td {
	width: 70%;
	padding: 0 10px;
	height: 45px;
}
</style>

	<main>
		<h2 class="page--title">상품 등록</h2>
		<hr>
		<br>
	
		<form action="/product/insert" method="post" enctype="multipart/form-data">
			<div class="d-flex flex-column align-items-center">
				<table class="list--table--reverse" border="1" style="width: 800px;">
					<tr>
						<th>브랜드명</th>
						<td><input type="text" name="brand" id="brand"> </td>
					</tr>
					<tr>
						<th>상품명</th>
						<td><input type="text" name="name" id="name"></td>
					</tr>
					<tr>
						<th>가격</th>
						<td><input type="number" name="price" min="1" maxlength="10" oninput="maxLengthCheck(this)"></td>
					</tr>
					<tr>
						<th>수량</th>
						<td><input type="number" name="count" min="1" maxlength="4" oninput="maxLengthCheck(this)"></td>
					</tr>
					<tr>
						<th>상품 이미지</th>
						<td><input type="file" class="form-control-file" name="file"></td>
					</tr>
					<tr>
						<th>기프티콘 이미지</th>
						<td><input type="file" class="form-control-file" name="file2"></td>
					</tr>
				</table>
				<div style="margin-top: 40px" class="d-flex align-items-end">
					<button type="button" class="blue--btn--small" style="padding-left: 9px; background-color: gray; margin: 0 20px" onclick="location.href='/product/productMain/clasic'">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
							<li>취소
						</ul>
					</button>
					<button type="submit" class="blue--btn--small" id="regBtn">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li style="margin-right: 4px;">입력 완료
							<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">done</span>
						</ul>
					</button>
				</div>
			</div>
		</form>
	</main>

<!-- <script>

// Add the following code if you want the name of the file appear on select
$(".custom-file-input").on("change", function() {
  var fileName = $(this).val().split("\\").pop();
  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});
</script> -->
<script type="text/javascript">
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
  }
</script>
<input type="hidden" name="menuName" id="menuName" value="상품 등록">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
