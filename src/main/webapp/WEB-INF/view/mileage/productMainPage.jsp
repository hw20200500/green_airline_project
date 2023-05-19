<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
/* .product_card.soldout::before{content: '';display: block;position: absolute;width: 210px;height: 210px;border: 6px solid #a9a9a9;background-repeat: no-repeat;background-color: rgba(255,255,255,.7);z-index: 10;box-sizing: border-box;} */
.product_card.soldout::before {
	content: '';
	display: block;
	position: absolute;
	width: 210px;
	height: 210px;
	border: 6px solid #a9a9a9;
	background-repeat: no-repeat;
	background-color: rgba(255, 255, 255, .7);
	z-index: 10;
	box-sizing: border-box;
}
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
			<select title="상품 정렬 순서" class="white gifticon-order" id="selectBoxId">
				<option value="basic">옵션 선택</option>
				<option value="ASC">마일리지순 낮은 순</option>
				<option value="DESC">마일리지순 높은 순</option>
			</select>
		</div>
		<!-- 상품 메인 페이지 -->
		<div class="product--empty">
			<c:forEach var="productList" items="${productList}">
				<div class="product_card" id="product">
					<div class="prd_img">
						<a href="productdetail/${productList.id}" class="aTagImage"><img class="imgClass" alt="prd_img" src="/product/${productList.productImage}"></a>
					</div>
					<dl class="prd_info">
						<dt>
							<p class="tit">[${productList.brand}]${productList.name}</p>
						</dt>
						<dd>
							<div class="price">
								<span class="num">${productList.priceNumber()}</span> <span class="unit">마일</span>
							</div>
							<div class="date_info hidden"></div>
							<input type="hidden" value="${productList.count}" name="countName" class="count">
						</dd>
					</dl>
				</div>
			</c:forEach>
		</div>
		<ul class="pagination pagination-sm">
  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
  <li class="page-item"><a class="page-link" href="#">1</a></li>
  <li class="page-item"><a class="page-link" href="#">2</a></li>
  <li class="page-item"><a class="page-link" href="#">3</a></li>
  <li class="page-item"><a class="page-link" href="#">Next</a></li>
</ul>
		<h2>
			<a href="/product/registration">등록 페이지</a>
		</h2>
		<!--/* 페이지네이션 렌더링 영역 */-->
                <div class="paging">

                </div>
		
	</main>
</div>

<script>

        
     
	 $(document).ready(function(){
		$(".gifticon-order").on("change",()=>{
			let selectBox  = document.getElementById("selectBoxId");
			let value = (selectBox.options[selectBox.selectedIndex].value);
	
		$.ajax({
			type: "get",
			url: "/product/list/"+value,
			contentType: "application/json",
		}).done(function(response){
			 for(i = 0; i < response.length; i++){
				/*  var don =parseInt(response[i].price);
				 var don1 = 'replace(/\B(?=(\d{3})+(?!\d))/g, ",")'
			        don = don.don1;
			      console.log(response[i].count)  */
			     
			        if (response[i].count != '0') {
			 document.getElementsByClassName('product_card')[i].className = 'product_card';
			}else{
				 document.getElementsByClassName('product_card')[i].className = 'product_card soldout';
		}
				
				 
				 $(".tit").eq(i).text("["+response[i].brand+"]"+response[i].name);
				 $(".num").eq(i).text(response[i].price);
				 $(".count").eq(i).val(response[i].count);
				 $(".aTagImage").eq(i).prop('href',"productdetail/"+response[i].id)
				 $(".imgClass").eq(i).prop('src',"/product/"+response[i].productImage)
				
			} 
		}).fail(function(error){
			alert("서버오류");
		});
	}); 
	 });
	let count = document.getElementsByClassName('count');
	console.log(count)
	for (i = 0; i < count.length; i++) {
		if (count[i].value == 0) {
			/* document.getElementsByClassName('product_card')[i].className = 'product_card soldout'; */
			 document.getElementsByClassName('product_card')[i].className += ' soldout';
		}
	}
 	
	function findAllPost() {
		 // 1. PagingResponse의 멤버인 List<T> 타입의 list를 의미
        const list = [[ ${productList.list} ]];

        // 3. PagingResponse의 멤버인 pagination을 의미
        const pagination = [[ ${productList.pagination} ]];

        // 4. @ModelAttribute를 이용해서 뷰(HTML)로 전달한 SearchDto 타입의 객체인 params를 의미
        const params = [[ ${productList} ]];

        // 5. 리스트에 출력되는 게시글 번호를 처리하기 위해 사용되는 변수 (리스트에서 번호는 페이지 정보를 이용해서 계산해야 함)
        let num = pagination.totalRecordCount - ((productList.page - 1) * productList.recordSize);

        // 6. 리스트 데이터 렌더링
        drawList(list, num);

        // 7. 페이지 번호 렌더링
        drawPage(pagination, productList);
	}
</script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
