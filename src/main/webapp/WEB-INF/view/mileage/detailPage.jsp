<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<div>

	<!-- 여기 안에 쓰기 -->
	<main>

		<div class="container">
			<div class="prd_detail mar_to50">
				<!-- 상품 이미지영역 -->
				<div class="prd_img">
					<!-- 비주얼 슬라이더 -->
					<div class="swiper-container prd_slider swiper-container-horizontal">
						<div class="swiper-wrapper">


							<div class="swiper-slide swiper-slide-active" style="width: 590px;">
								<!--img src="/C/common/file/stream/7b30ba60cdb34af4b616cea9165e9970/1" alt="상품 이미지" style="width:100%;height:100%;"-->
								<img src="" alt="상품 이미지" style="width: 380px; height: 100%;">
							</div>


						</div>
					</div>

				</div>

				<!-- 상품 정보영역 -->
				<div class="prd_info">
					<p class="title">[${shopProduct.brand}] ${shopProduct.name}</p>
					<div class="mileage">
						<div class="mile">
							<span class="num">${shopProduct.price}</span>마일
						</div>
						<p class="desc">
							<a href="javascript:sharpNothig();" class="btn_arrow flow-action-login">로그인></a> 을 하시면 마일리지를 확인하실 수 있습니다.
						</p>
					</div>

					<!-- 상품 선택영역 -->
					<form name="frmDefault" id="frmDefault" method="post" action="">
						<div class="select_area">
							<select id="optionList" title="상품 선택" style="width: 100%">
								<option value="">옵션을 선택해주세요.</option>

								<option value="001">[${shopProduct.brand}] ${shopProduct.name} | ${shopProduct.count}개 남음</option>



							</select>
							
							<!-- 상품 수량 + --->
							 <div>
								<input type='button' onclick='count("minus")' value='-' min="1"/>
								<div id='selectedCount'>1</div>
								<input type='button' onclick='count("plus")' value='+'max="5"/> 
							</div>
								


							<div class="selected_prd 001"id="myDIV" style="display: none;">
								<div class="tit">
									<p>
										[${shopProduct.brand}] ${shopProduct.name}<span class="type">[${shopProduct.brand}] ${shopProduct.name}</span>
									</p>
								</div>
								<div class="quantity">
									<div class="btn_number_box small">


										<input type="text" id="selectedCount" title="상품 개수" value="1"readonly="readonly">1

										<button type="button" class="btn_number minus" id="plus" disabled="disabled">
											<span class="hidden">감소</span>
										</button>
										<button type="button"class="btn_number plus" id="minus">
											<span class="hidden">증가</span>
										</button>
										
										
										
										
									</div>
								</div>
								<div class="price">
									<span class="num each_mile">${shopProduct.price}</span>마일
								</div>
								<a href="javascript:sharpNothig();" class="btn_delete"><span class="hidden">삭제</span></a>
							</div>


							<dl class="total_mile">
								<dt>총 필요 마일리지</dt>
								<dd>
									<span class="num">0</span>마일
								</dd>
							</dl>

							<div class="btn_area">

								<button type="button" class="btn_M red flow-action-login">나의 마일리지 확인하기</button>

							</div>
						</div>
					</form>
					<!-- 상품 선택영역 -->

				</div>
				<!--// 상품 정보영역 -->
			</div>
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
							<form action="/product/update" method="post">
								<input type="text" value="${shopProduct.brand}" name="brand"> <input type="text" value="${shopProduct.name}" name="name"> <input type="text" value="${shopProduct.count}"
									name="count"> <input type="text" value="${shopProduct.price}" name="price"> <input type="file" class="form-control-file border" name="file" value="productImage"> <input
									type="file" class="form-control-file border" name="file2" value="gifticonImage">
								<%-- <input type="text" value="${shopProduct.productImage}" name="productImage">
        <input type="text" value="${shopProduct.gifticonImage}" name="gifticonImage"> --%>
								<input type="text" value="${shopProduct.id}" name="id">
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
	</main>

</div>
<script>
	function count(type) {
		// 결과를 표시할 element
		const resultElement = document.getElementById('selectedCount');

		// 현재 화면에 표시된 값
		let number = resultElement.innerText;
		let total = resultElement.innerText;
		// 더하기/빼기
		if (type === 'plus') {
			number = parseInt(number) + 1;
		} else if (type === 'minus') {
			number = parseInt(number) - 1;
		}
		// 결과 출력
		resultElement.innerText = number;
	}
	function 
	
	
</script>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
