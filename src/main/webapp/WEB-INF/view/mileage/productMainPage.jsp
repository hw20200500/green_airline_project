<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
		<input type="hidden" name="menuName" id="menuName" value="상품 목록">
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
		<input type="hidden" name="menuName" id="menuName" value="마일리지샵">
	</c:otherwise>
</c:choose>

<style>
/* .product_card.soldout::before{content: '';display: block;position: absolute;width: 210px;height: 210px;border: 6px solid #a9a9a9;background-repeat: no-repeat;background-color: rgba(255,255,255,.7);z-index: 10;box-sizing: border-box;} */
.product_card.soldout::before {
	content: '품절';
	padding: 68px 65px;
	font-size: 30px;
	font-weight: 600;
	color: gray;
	display: block;
	position: absolute;
	width: 200px;
	height: 200px;
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
	width: 1180px;
	padding-left: 20px;
}

.product_card {
	width: 230px;
	margin: 0 30px;
}

.link-button {
	display: inline-block;
	padding: 5px 10px;
	border-radius: 3px;
}

.announcement {
	font-family: Arial, sans-serif;
	line-height: 1.5;
	color: #404040;
	font-size: 15px;
	background-color: #eee;
	padding: 20px;
	margin-top: 50px;
}

.announcement h5 {
	margin-top: 30px;
}

.announcement ul {
	margin-bottom: 20px;
	list-style-type: disc;
	margin-left: 20px;
}

.imgClass {
	width: 200px;
	height: 200px
}

.registration {
	background-color: rgb(243, 243, 243);
	padding: 5px;
	border-radius: 9px;
}

.registration a {
	padding: 10px;
}

.filter--div {
	margin-bottom: 50px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.filter--div form {
	display: flex;
	align-items: center;
}

.filter--div>div:first-of-type {
	background-color: buttonshadow;
	padding: 13px 13px 13px 10px;
}

.filter--div input, .filter--div select {
	margin-right: 10px;
	border-radius: 5px;
	border-width: 1px;
	padding: 3px;
	border: 1px solid #ccc;
	outline: none;
}

.filter--div form button {
	background-color: gray;
	padding: 2px 6px;
	border: none;
	border-radius: 5px;
	color: white;
	height: 28px;
}

.prd_info {
	margin-top: 10px;
}

.product_card:first-of-type {
	margin-bottom: 40px;
}
</style>

<main>
	<h2 class="page--title">마일리지샵</h2>
	<hr>
	<br>
	<div class="filter--div">
		<div>
			<div class="form--div">
				<form action="/product/productSearch" method="get">
					<select title="상품 선택 검색" class="white" id="searchOption" name="searchOption">
						<option value="brand">브랜드</option>
						<option value="name">이름</option>
					</select> <input type="text" name="searchProduct" id="searchProduct">
					<!-- 검색 버튼 -->
					<button type="submit" id="searchButton">
						<ul class="d-flex justify-content-center" style="margin: 0;">
							<li style="height: 24px; margin-right: 2px;">조회
							<li style="height: 24px;"><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 18px; padding-top: 4px;">search</span></li>
						</ul>
					</button>
				</form>
			</div>
		</div>
		<div>
			<div class="sort_area">
				<select title="상품 정렬 순서" class="white gifticon-order" id="selectBoxId">
					<option value="basic">옵션 선택</option>
					<option value="ASC">마일리지순 낮은 순</option>
					<option value="DESC">마일리지순 높은 순</option>
				</select>
			</div>
		</div>
	</div>
	
	<div>
		<!-- 상품 메인 페이지 -->
		<div class="product--empty">
			<c:forEach var="productList" items="${productList}">
				<div class="product_card" id="product">
					<div class="prd_img">
						<a href="/product/productdetail/${productList.id}" class="aTagImage"><img class="imgClass" alt="prd_img" src="${productList.productImage}"></a>
					</div>
					<dl class="prd_info">
						<dt style="margin-bottom: 5px;">
							[${productList.brand}]&nbsp;${productList.name}
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

		<ul class="page--list">
			<c:forEach begin="${paging.firstPage}" end="${paging.lastPage}" var="i">
				<li>
					<a href="/product/productMain/${searchOrder}?curPage=${i}">
					<c:if test="${i eq paging.curPage}">
						<span style="font-weight: 700; color: #007bff">${i}</span>
					</c:if>
					<c:if test="${i ne paging.curPage}">${i}</c:if>
					</a>
				</li>
			</c:forEach>
		</ul>
		
		<c:if test="${\"관리자\".equals(principal.userRole)}">
			<div style="width: 100%; text-align: right">
				<button type="button" class="blue--btn--small" onclick="location.href='/product/registration'">
					<ul class="d-flex justify-content-center" style="margin: 0;">
						<li style="margin-right: 4px;">상품 등록
						<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">add</span>
					</ul>
				</button>
			</div>
		</c:if>

		<div class="announcement">
			<h3>이용안내</h3>
			<h5>■ 상품 연장 및 환불</h5>
			<ul>
				<li>유효기간 만료 전 : 마일리지 사용몰 &gt; 구매내역</li>
				<li>유효기간 만료 후 : 연장 불가, 환불 가능</li>
				<li>단 환불 시 유효기간이 지난 마일리지는 자동 소멸되오니 유의 해주시기 바랍니다.</li>
			</ul>

			<h5>■ 판매 상품은 준비된 수량의 소진 속도에 따라 판매 기한 내에 조기 매진될 수 있습니다.</h5>
			
			<h5>■ 마일리지는 '본인' 사용 원칙입니다.</h5>

		</div>
	</div>
</main>
<script>

$("#searchButton").on("click", function() {
    let search = $("#searchProduct").val().replaceAll(" ","");
    console.log(search);
    if (search == "") {
        console.log("입력된 검색어가 없습니다.");
        return false;			
    }
});

$("#searchProduct").on("keyup", function(e) {
    let search = $("#searchProduct").val().replaceAll(" ","");
	console.log(search);
    if (e.keyCode == "13") {
        if (search == "") {
            e.preventDefault();
        }
    }
});

$(document).ready(function(){
        console.log(`${searchOrder}`);
        
		if ("ASC" == `${searchOrder}`) {
			$("#selectBoxId option").eq(1).prop("selected", "true");
		} else if ("DESC" == `${searchOrder}`) {
			$("#selectBoxId option").eq(2).val("DESC").prop("selected", "true");
		}
		
    $(".gifticon-order").on("change", () => {
        let selectBox = document.getElementById("selectBoxId");
        let value = selectBox.options[selectBox.selectedIndex].value;
         if (value === "ASC" || value === "DESC") {
            location.href = "/product/productMain/"+value;
        } 
         

    });
    
    let count = document.getElementsByClassName('count');
    for (i = 0; i < count.length; i++) {
        if (count[i].value == 0) {
            document.getElementsByClassName('product_card')[i].className += ' soldout';
        }
    }
});

	
	
		 
</script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
