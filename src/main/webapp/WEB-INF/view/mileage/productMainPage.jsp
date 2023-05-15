<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div>
	
	<!-- 여기 안에 쓰기 -->
	<main>
	<div class="visual_banner small_type mar_to50" style="background-image: url('/C/pc/image/sub/weeklydeals_visual_06.jpg');">
		    <div class="banner_cont"> 
		      <h4 class="fo_nor mar_to0">위클리 딜즈</h4>
		      <p>매주 변경되는 다양한 위클리 딜즈 상품을 만나보세요!</p> 
		    </div> 
		    <div class="today"> 
		        <p class="date">15</p> 
		        <p class="month">May</p> 
		    </div> 
		  </div>
	<!-- 상품 메인 페이지 -->
		<div>
			<c:forEach var="productList" items="${productList}">
				<tr>
					<td>
						<!-- 이미지 불러오기 나중에 -->
						
						<a href="productdetail/${productList.id}"><img alt="" src="image/${productList.productImage}"></a>
						<img alt="" src="image/${productList.gifticonImage}">
						 ${productList.gifticonImage}
						${productList.brand}
						${productList.name}
						${productList.price}
					</td>
				</tr>
				<br>
			</c:forEach>
		</div>
		<h2><a href="/product/registration">등록 페이지</a></h2>
	</main>
</div>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
