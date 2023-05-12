<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div>
	
	<!-- 여기 안에 쓰기 -->
	<main>
		<div>		
			${shopProduct.price}
			${shopProduct.brand}
			${shopProduct.name}
			${shopProduct.productImage}
			
			<!-- 이미지 가격
				 옵션 수량 나오게
				 옵션 선택하면 가격
				 구매 버튼
			  -->
		</div>
	</main>

</div>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
