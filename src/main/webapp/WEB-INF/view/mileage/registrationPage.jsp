<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div>

	<!-- 여기 안에 쓰기 -->
	<main>
		<form action="/product/insert" method="post" enctype="multipart/form-data">
			<input type="text" name="brand" value="brand"> 
			<input type="text" name="name" value="name"> 
			<input type="text" name="price" value="1234"> 
			<input type="text" name="count"value="100">
			<input type="file" class="form-control-file border" name="file"value="productImage">
			<input type="file" class="form-control-file border" name="file2"value="gifticonImage">
			<button type="submit">등록</button>
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

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
