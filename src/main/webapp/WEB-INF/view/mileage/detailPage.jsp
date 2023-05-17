<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div>

	<!-- 여기 안에 쓰기 -->
	<main>

		<div class="container">
			<div class="prd_detail mar_to50">
				<!-- 상품 정보영역 -->
				<div class="prd_info">

					<p class="title">[${shopProduct.brand}] ${shopProduct.name}</p>
					<img alt="" src="/product/${shopProduct.productImage}">
					<div class="mileage">
						<div class="mile">
							<span class="">${shopProduct.price}</span>마일
						</div>

						<c:choose>
							<c:when test="${principal == null}">
								<p class="desc">
									<a href="/login" class="btn_arrow flow-action-login">로그인</a> 을 하시면 마일리지를 확인하실 수 있습니다.
								</p>
							</c:when>
							<c:otherwise>
								<p>현재 마일리지 : <span class="myMileage">${mileage.balance}</span></p>
							</c:otherwise>
						</c:choose>


					</div>
					<div class="dateinfo">
						<span class="date">2023-05-15 09:00 ~ 2023-05-22 08:59</span> <span class="deadline"><span class="num">7</span>일 남음</span>
					</div>

					<!-- 상품 선택영역 -->
					<form name="frmDefault" id="frmDefault" method="post" action="/product/buyProduct">
						<div class="select_area">
							<select id="optionList" title="상품 선택" style="width: 100%">
								<option value="">옵션을 선택해주세요.</option>

								<option value="001">[${shopProduct.brand}] ${shopProduct.name} | ${shopProduct.count}개 남음</option>

							</select>


							<div class="selected_prd 001" style="display: none;">
								<div class="tit">
									<p>
										[${shopProduct.brand}] ${shopProduct.name}<span class="type">[${shopProduct.brand}] ${shopProduct.name}</span>
									</p>
								</div>
								<div class="quantity">
									<div class="btn_number_box small">

										<input type="text" name="amount" title="상품 개수" value="1" readonly="readonly">

										<button type="button" class="btn_number minus">감소</button>
										<button type="button" class="btn_number plus">증가</button>
									</div>
								</div>
								<div class="price">
									<span class="num each_mile">${shopProduct.price}</span>마일
								</div>
								<a href="#none" class="btn_delete"><span class="hidden">삭제</span></a>
							</div>


							<dl class="total_mile">
								<dt>총 필요 마일리지</dt>
								<dd>
									<span class="num" id="spanPrice">${shopProduct.price}</span>마일
									<!-- input hidden 으로 변경된 값 넣어서 xml에 보내기 -->
									<input type="hidden" value="${shopProduct.price}" name="useMileage">
								</dd>
							</dl>

							<div class="btn_area">

								<button type="submit" class="buyButton">구매하기 버튼으로 만들꺼임</button>
								<button type="button" class="testbutton">test</button>

							</div>
						</div>
						<input type="hidden" name="productId" value="${shopProduct.id}">
						 <input type="hidden" name="hiddenCount" value="${shopProduct.count}">
					</form>
					<!-- 상품 선택영역 -->

				</div>
				<!--// 상품 정보영역 -->
				<!-- Button to Open the Modal -->
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">수정</button>

				<!-- The Modal -->
				<div class="modal" id="myModal">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">상품 수정</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">
								<form action="/product/update" method="post" enctype="multipart/form-data">
									<input type="text" value="${shopProduct.brand}" name="brand"> <input type="text" value="${shopProduct.name}" name="name"> <input type="text" value="${shopProduct.count}"
										name="count"> <input type="text" value="${shopProduct.price}" name="price"> <input type="file" class="form-control-file border" name="file"> <input type="file"
										class="form-control-file border" name="file2"> <input type="text" value="${shopProduct.id}" name="id">
							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="submit">수정</button>
								<a href="/product/delete/${shopProduct.id}" class="">제품 삭제</a>
								</form>
							</div>

						</div>
					</div>
				</div>

			</div>
		</div>
	</main>

</div>
<script>
	$("#optionList").on("change", function() {
		let selectedOption = $(this).val();

		if ($.trim(selectedOption) != "") {
			$(".selected_prd").hide();
			$(".selected_prd." + selectedOption).first().show();
			
		}

		$(this).val("");
	});

	// 삭제 버튼 클릭 시
	$(".btn_delete").on("click", function() {
		let countInput = $("input[name='amount']");
		let priceElement = $(".price .num.each_mile");
		let totalPriceElement = $(".total_mile .num");
		let initialPrice = parseInt(priceElement.text());
		
		$("#optionList option").eq(0).attr("selected", true);
		
		countInput.val(1);
		totalPriceElement.text(initialPrice);
		$(this).parent().hide();
		flow.action.calcPrice();
		
	});
	
	
	// 수량 증가 버튼 클릭 시
	document.querySelector('.btn_number.plus')
			.addEventListener(
					'click',
					function() {
						let minusTarget = document
						.querySelector('.btn_number.minus');
						let target = document
								.querySelector('.btn_number.plus');
						let countInput = document
								.querySelector('input[name="amount"]');
						let countValue = parseInt(countInput.value);
						let priceElement = document
								.querySelector('.price .num.each_mile');
						let totalPriceElement = document
								.querySelector('.total_mile .num');
						let price = parseInt(priceElement.textContent);
						let hiddenPrice = document
								.querySelector('input[name="useMileage"]');
						let hiddenCount = document
						.querySelector('input[name="hiddenCount"]');
						 /* console.log(${shopProduct.count}) */ 
						 console.log(hiddenCount.value) 
						if (countValue < 5) {
							countInput.value = countValue + 1;
							totalPriceElement.textContent = price
									* (countValue + 1);
							hiddenPrice.value = price * (countValue + 1);
							hiddenCount.value = ${shopProduct.count} - countInput.value
							minusTarget.disabled = false;
						}else if(countValue == 5){
							alert('최대 5개 까지 선택 가능합니다');
						}
						if(${shopProduct.count} == countValue + 1){
							countInput.value = countValue+1;
							 target.disabled = true;
							alert('최대수량입니다');
							
						}
					});

	// 수량 감소 버튼 클릭 시
	document.querySelector('.btn_number.minus')
			.addEventListener(
					'click',
					function() {
						let target = document
						.querySelector('.btn_number.plus');
						let minusTarget = document
						.querySelector('.btn_number.minus');
						let countInput = document
								.querySelector('input[name="amount"]');
						let countValue = parseInt(countInput.value);
						let priceElement = document
								.querySelector('.price .num.each_mile');
						let totalPriceElement = document
								.querySelector('.total_mile .num');
						let price = parseInt(priceElement.textContent);
						let hiddenPrice = document
								.querySelector('input[name="useMileage"]');
						let hiddenCount = document
						.querySelector('input[name="hiddenCount"]');
						if (countValue > 1) {
							countInput.value = countValue - 1;
							totalPriceElement.textContent = price
									* (countValue - 1);
							hiddenPrice.value = price * (countValue - 1);
							hiddenCount.value = ${shopProduct.count} - countInput.value
							target.disabled = false;
						} else if (countValue > 0) {
							minusTarget.disabled = true;
							alert('최소 1개는 선택 해야합니다');
						}
					});
	/* 마일리지 비교 */
	document.querySelector('.testbutton')
			.addEventListener('click',
					function() {
				let myMileage = document
				.querySelector('.myMileage').innerHTML;
				let totalPriceElement = document
				.getElementById('spanPrice').innerHTML;
				let hiddenCount = document
				.querySelector('input[name="hiddenCount"]');
				
				if(parseInt(myMileage) < parseInt(totalPriceElement)){
					 event.preventDefault();
					 location.reload(); 
					alert('마일리지가 부족 합니다');
				}
				
					
				
			});
</script>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
