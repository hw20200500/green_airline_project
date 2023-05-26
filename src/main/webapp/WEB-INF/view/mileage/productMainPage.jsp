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

.product--empty {
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.product_card {
	width: 25%;
	margin-bottom: 20px;
}

.link-button {
	display: inline-block;
	padding: 5px 10px;
	border-radius: 3px;
}

.announcement {
	font-family: Arial, sans-serif;
	line-height: 1.5;
	color: #333;
	font-size: 15px;
	background-color: #e6e2df;
	padding: 10px;
	margin-bottom: 30px;
}

.announcement h5 {
	margin-top: 30px;
}

.announcement ul {
	margin-bottom: 20px;
}

.announcement ul {
	list-style-type: disc;
	margin-left: 20px;
}

.asd {
	background-color: #f7f7f7;
}

.paging {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.paging a {
	margin: 0 5px;
}

h2 {
	text-align: center;
	margin-top: 20px;
}

.imgClass {
	width: 200px;
	height: 200px
}
</style>

<!-- 여기 안에 쓰기 -->
<main>
	<div class="container">


		<div class="sort_area">
			<select title="상품 정렬 순서" class="white gifticon-order" id="selectBoxId">
				<option value="basic">옵션 선택</option>
				<option value="ASC">마일리지순 낮은 순</option>
				<option value="DESC">마일리지순 높은 순</option>
			</select>
		</div>
		<div>
			<form action="/product/productSearch" method="get">
				<select title="상품 선택 검색" class="white gifticon-order" id="selectBoxId" name="searchOption">
					<option value="brand">브랜드</option>
					<option value="name">이름</option>
				</select> <input type="text" name="searchProduct" id="searchProduct">
				<button type="submit" id="searchButton">검색</button>
			</form>
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

		<h2>
			<a href="/product/registration">등록 페이지</a>
		</h2>
		<!--/* 페이지네이션 렌더링 영역 */-->
		<div class="paging">
			<a href="/product/productMain?curPage=1">&laquo;</a> <a href="/product/productMain?curPage=${paging.curPage-1 }">&lt;</a>
			<c:forEach begin="${paging.firstPage }" end="${paging.lastPage }" var="i">
				<a href="/product/productMain?curPage=${i }"> <c:if test="${i eq paging.curPage }">
						<span style="color: red"> ${i } </span>
					</c:if> <c:if test="${i ne paging.curPage }">  ${i } </c:if>
				</a>
			</c:forEach>
			<a href="/product/productMain?curPage=${paging.curPage+1 }">&gt;</a> <a href="/product/productMain?curPage=${paging.totalPageCount }">&raquo;</a>

		</div>

		<div class="announcement">
			<h3>이용안내</h3>
			<h5>■ 상품연장 및 환불</h5>
			<ul>
				<li>유효기간 만료 전 : 마일리지 사용몰 &gt; 구매내역 &gt; 주문상세</li>
				<li>유효기간 만료 후 : 연장 불가, 환불 가능</li>
				<ul>
					<li>단 환불 시 유효기간이 지난 마일리지는 자동소멸되오니 유의 부탁 드립니다.</li>
				</ul>
			</ul>

			<h5>■ 쿠폰 수신내역 조회 및 재발송</h5>
			<p>
				<a href="http://gishow.kr/voc" class="link-button">쿠폰 수신내역 조회 및 재발송</a>
			</p>

			<h5>■ 마일리지 사용몰 이용시 마일리지 비밀번호 설정</h5>
			<p>- 마이아시아나 &gt; 회원정보 &gt; 마일리지 비밀번호 등록/변경 메뉴 이동</p>

			<h5>■ 일일기준 상품당 최대 5개로 구매수량 제한</h5>
			<p>- 적용일 (2020년 4월 8일부)</p>

			<h5>■ 판매 예정상품은 차주 월요일 오전 9시부터 판매 시작</h5>

			<h5>■ 판매 상품은 준비된 수량의 소진 속도에 따라 판매기한 내에 조기 매진될 수 있습니다.</h5>
		</div>

		<div class="asd">
			<h6>마일리지는 '본인' 사용 원칙입니다.</h6>

			* 아시아나 기내면세점 및 로고샵은 가족마일리지 합산 가능합니다.

			<h6>마일리지 비밀번호 설정이 불가한 외국인 또는 해외거주 회원의 이용이 제한됩니다.</h6>

			* 아시아나기내면세점은 마일리지 비밀번호 없이 구매 가능합니다.
		</div>
	</div>
</main>
<script>
$(document).ready(function(){
		$("#searchButton").on("click",()=>{
	let searchProduct = $("#searchProduct").val();
		console.log(searchProduct);
	if(searchProduct == ' '||searchProduct == ''){
		$('#searchButton').attr("type","button");
	}else{
		$('#searchButton').attr("type","submit");
	}
		});
});
     
	 $(document).ready(function(){
		$(".gifticon-order").on("change",()=>{
			let selectBox  = document.getElementById("selectBoxId");
			let value = (selectBox.options[selectBox.selectedIndex].value);
	
		$.ajax({
			type: "get",
			url: "/product/list/"+value,
			contentType: "application/json",
		}).done(function(response){
			let n1 = 1000
			let n2 = n1.toString()
			  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			console.log(n2);
			 for(i = 0; i < response.length; i++){
				
			        if (response[i].count != '0') {
				$(".product_card").eq(i).removeClass("soldout")
			}else{
				$(".product_card").eq(i).addClass("soldout")
		}
			        let price = response[i].price
			        let priceReplace = price.toString()
					  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			        console.log(n2);
				 $(".tit").eq(i).text("["+response[i].brand+"]"+response[i].name);
				 $(".num").eq(i).text(priceReplace);
				 $(".count").eq(i).val(response[i].count);
				 $(".aTagImage").eq(i).prop('href',"productdetail/"+response[i].id);
				 $(".imgClass").eq(i).prop('src',"/product/"+response[i].productImage);
				
			} 
		}).fail(function(error){
			alert("서버오류");
		});
	}); 
	 });
	let count = document.getElementsByClassName('count');
	for (i = 0; i < count.length; i++) {
		if (count[i].value == 0) {
			 document.getElementsByClassName('product_card')[i].className += ' soldout';
		}
	}

		
	
		 
</script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
