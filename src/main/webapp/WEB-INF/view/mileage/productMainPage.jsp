<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
/* .product_card.soldout::before,.product_card.type2.soldout::before {content: '';display: block;position: absolute;width: 210px;height: 210px;border: 6px solid #a9a9a9;background-repeat: no-repeat;background-color: rgba(255,255,255,.7);z-index: 10;box-sizing: border-box;} */ 

</style>
<div>

	<!-- 여기 안에 쓰기 -->
	<main>
		<div class="visual_banner small_type mar_to50">
			<div class="banner_cont">
				<h4 class="fo_nor mar_to0">위클리 딜즈</h4>
				<p>매주 변경되는 다양한 위클리 딜즈 상품을 만나보세요!</p>
			</div>
			<div class="today">
				<p class="date">06</p>
				<p class="month">March</p>
			</div>
		</div>

		<div class="sort_area">
			<select title="상품 정렬 순서" class="white gifticon-order">
				<option value="DATE" selected="selected">판매시간순</option>
				<option value="ASC">마일리지순 낮은 순</option>
				<option value="DESC">마일리지순 높은 순</option>
			</select>
		</div>
		<!-- 상품 메인 페이지 -->

		<c:forEach var="productList" items="${productList}">
			<div class="product_card type2 soldout">
				<div class="prd_img">
				<a class="aclass"></a>
					<a href="productdetail/${productList.id}" ><img class="imgClass" alt="prd_img" src="/product/${productList.productImage}"></a>
				</div>
				<dl class="prd_info">
					<dt>
						<p class="tit">[${productList.brand}]${productList.name}</p>
					</dt>
					<dd>
						<div class="price">
							<span class="num">${productList.price}</span> <span class="unit">마일</span> <span style="display: none;">PM</span>
						</div>
						<div class="date_info hidden">
							<span class="date">23.05.15 ~ 23.05.22</span>
						</div>
						<input type="text" value="${productList.count}" name="count">
					</dd>
				</dl>
			</div>
		</c:forEach>
		<h2>
			<a href="/product/registration">등록 페이지</a>
		</h2>
	</main>
</div>

<script>
	let count = document.querySelector('input[name="count"]');
	console.log(count.value);
	let soldOut = document.getElementsByClassName('imgClass')
	console.log(soldOut);
	if (count.value == 3) {
		/* let soldOut = document.querySelector('.aclass')
		let img = document.getElementsByClassName('imgClass') */
		/* lit img = document.querySelector('.imgClass') */
		/* soldOut.style.content = ""; */
		/* soldOut.style.display = "block"; */
		/* soldOut.style.position = "relative"; */
		/* soldOut.style.backgroundRepeat = "no-repeat"; */
		/* soldOut.style.border = "6px solid #a9a9a9"; */
		/* soldOut.style.height = "210px";
		soldOut.style.width = "210px";
		soldOut.style['background-color'] = 'rgba(255,255,255,.7)';
		soldOut.style.zIndex = "100"; */
		/* soldOut.style.boxSizing = "border-box";  */
	}
</script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
