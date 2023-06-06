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
main{
	border: 1px solid #ccc;
	padding: 50px;
}
input[type=text], input[type=file],input[type=number]{
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 600px;
	background: #f8f9fc;
	padding: 10px;
	position: relative;
	margin-bottom: 8px;
}
input[type=text]:focus, input[type=file]:focus,input[type=number] {
	border: none;
	border-bottom: 1px solid #ebebeb;
	width: 600px;
	background: #f8f9fc;
	outline: none;
}
.btn-right{
	width: 150px;
}
</style>
<div>

	<!-- 여기 안에 쓰기 -->
	<main>
		<form action="/product/insert" method="post" enctype="multipart/form-data">
			<span >브랜드 이름 :</span>
			<br>
			<input type="text" name="brand" id="brand" value="brand" placeholder="브랜드 이름"> 
			<br>
			<span >제품 이름 :</span>
			<br>
			<input type="text" name="name" id="name" value="name" placeholder="상품 이름"> 
			<br>
			<span >가격 :</span>
			<br>
			<input type="number" name="price" value="1234" placeholder="가격" min="1" maxlength="10" oninput="maxLengthCheck(this)"> 
			<br>
			<span >수량 :</span>
			<br>
			<input type="number" name="count"value="100" placeholder="수량" min="1" maxlength="4" oninput="maxLengthCheck(this)">
			<br>
			<span >상품 이미지 :</span>
			<br>
			<input type="file" class="form-control-file border" name="file"value="productImage" placeholder="상품 이미지">
			<span >기프티콘 이미지 :</span>
			<br>
			<input type="file" class="form-control-file border" name="file2"value="gifticonImage" placeholder="기프티콘 이미지">
			<button type="submit" class="btn btn-right">제품 등록</button>
		</form>
	</main>

</div>
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
