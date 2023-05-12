<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div>
	
	<!-- 여기 안에 쓰기 -->
	<main>
	<!-- 상품 메인 페이지 -->
		<div>
			<c:forEach var="productList" items="${productList}">
				<tr>
					<td>
						<!-- 이미지 불러오기 나중에 -->
						<a href="productdetail/${productList.id}">${productList.productImage}</a>
						${productList.gifticonImage}
						${productList.brand}
						${productList.name}
						${productList.price}
					</td>
				</tr>
				<br>
			</c:forEach>
		</div>
		<h2><a href="/registration">등록 페이지</a></h2>
	</main>
</div>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
