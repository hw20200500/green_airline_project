<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<style>
.tbl_prdinfo {
	border: 1px solid #ccc;
	font-size: 12pt;
	font-family: 'Malgun Gothic';
	width: 100%;
}

.tbl_prdinfo td {
	text-align: left;
	padding: 3px 15px;
}

.tbl_prdinfo .tbl_prdinfo_tit {
	height: 61px;
	text-align: center;
	font-weight: 700;
	font-size: 14pt
}

.tbl_prdinfo .td_sub_tit {
	text-align: center;
	font-weight: 600;
}

#amount {
	font-size: 15px;
	border: none;
	background: none;
	outline: none; /*선택 시 나오는 테두리 없애기*/
	width: 15px;
	text-align: center;
	margin: 0 10px 1px;
}

.btn-light {
	font-weight: bold;
}

#buyButton {
	margin-top: 10px;
	width: 100%;
}

#optionList {
	height: 40px;
	width: 100%;
	margin: 10px 0;
	background: none;
	border: 1px solid #ccc;
	border-radius: 5px;
	outline: none;
}

.prd_info {
	display: flex;
	justify-content: space-between;
	padding: 0 30px;
	margin: 50px 0;
}

.productImg {
	width: 350px;
	height: 350px;
}

.small {
	padding: 3px;
	padding-left: 7px;
}

.modal--btn {
	margin-top: 10px;
	width: 100%;
}

.delete--btn {
	margin: 10px 0;
}

#spanPrice {
	font-weight: bold;
	font-size: 25px;
}

.tab_head li {
	width: 24.9%;
	float: left;
	background-color: #eee;
	margin-right: 1px;
	height: 50px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.tab_head li a {
	font-weight: 500;
	color: #404040;
}

.email {
	width: 50%;
	background-color: rgb(243, 243, 243);
	border: 1px solid #ccc;
}

.minus, .plus {
	border: 1px solid #ccc;
	font-size: 17px;
	width: 30px;
	height: 30px;
	background-color: white;
	border-radius: 50%;
	padding: 0;
}

.tab_wrap3 {
    position: relative;
}
.tab_wrap3 .tab_content {
    width: 100%;
    padding-top: 45px;
}
.inner{
	margin-top: 30px;
}

.tab_cont{
	width: 100%;
}

.call--back--div{
	text-align: center;
	margin: 10px;
    border: none;

    
}

#productPrice{
	border: none;
}

.total_mile {
	display: flex;
	justify-content: space-between;
	width: 100%;
	align-items: center;
}

.selected_prd {
	border-radius: 5px;
	margin: 10px 0 0;
}

input[name="email"] {
	text-align: center;
	padding: 3px;
	background: none;
	border: none;
	width: 190px;
	border-bottom: 1px solid #ccc;
}

</style>


<!-- 여기 안에 쓰기 -->
<main>

	<div class="container">
		<div class="prd_detail mar_to50">
			<!-- 상품 정보영역 -->
			<div class="prd_info">
				<img alt="" class="productImg" src="${shopProduct.productImage}">
				<div class="left--container" style="min-width: 552px">
					<h1 class="title">[${shopProduct.brand}] ${shopProduct.name}</h1>
					<hr>
					<%-- <img alt="" class="productImg" src="/uploadImage/${shopProduct.productImage}"> --%>

				<div class="mileage">
                  <c:choose>
                     <c:when test="${principal.userRole == '관리자'}">
                     </c:when>
                     <c:otherwise>
                        <c:choose>
                           <c:when test="${principal == null}">
                              <p class="desc">
                                 <a href="/login" class="btn_arrow flow-action-login">로그인</a> 을 하시면 마일리지를 확인하실 수 있습니다.
                              </p>
                           </c:when>
                           <c:otherwise>
                              <c:choose>
                                 <c:when test="${mileage.balance != null}">
                                    <p>
                                       현재 마일리지 : <span class="">${mileage.balanceNumber()}</span>
                                    </p>
                                    <span class="myMileage" style="display: none">${mileage.balance}</span>
                                 </c:when>
                                 <c:otherwise>
                                    <p>
                                       현재 마일리지 : <span class="">0</span>
                                    </p>
                                    <span class="myMileage" style="display: none">0</span>
                                 </c:otherwise>
                              </c:choose>
                           </c:otherwise>
                        </c:choose>
                     </c:otherwise>
                  </c:choose>
               </div>

					<!-- 상품 선택영역 -->
					<form name="frmDefault" id="frmDefault" method="post" action="/product/buyProduct">
						<div class="select_area">
							<select id="optionList" title="상품 선택">
								<option value="">옵션을 선택해주세요.</option>
								<option value="001">[${shopProduct.brand}] ${shopProduct.name} | ${shopProduct.count}개 남음</option>
							</select>
							
							<div class="selected_prd 001" style="display: none;">
								<div class="tit d-flex justify-content-between">
									<p>
										<span class="type">[${shopProduct.brand}] ${shopProduct.name} ㅣ <fmt:formatNumber value="${shopProduct.price}" pattern="#,###" /> 마일
										</span>
									</p>
									<a href="#none" class="btn_delete"><span class="material-symbols-outlined hidden"> close </span></a>
								</div>
								<div class="quantity">
									<div class="btn_number_box small">
										<div class="number--box--div">
											<button type="button" class="btn btn-light minus">-</button>
											<input type="text" name="amount" title="상품 개수" value="1" readonly="readonly" id="amount">
											<button type="button" class="btn btn-light plus">+</button>
										</div>
									</div>
								</div>
								<hr style="margin: 20px 0">
							</div>
						</div>
						<div class="price">
							<span class="num each_mile" style="display: none">${shopProduct.price}</span>

							<dl class="total_mile">
								<dd>
									<strong class="total--mileage">총 필요 마일리지</strong>
								</dd>
								<dd>
									<span class="num" id="spanPrice"><fmt:formatNumber value="${shopProduct.price}" pattern="#,###" /></span><span>&nbsp;마일</span> 
									<input type="hidden" value="${shopProduct.price}" name="productPrice" id="productPrice" readonly="readonly">
								</dd>
							</dl>

							<div class="btn_area">

								<c:choose>
									<c:when test="${principal != null}">
										<c:if test="${principal.userRole != '관리자'}">
											<div id="inputEmail" class="d-flex justify-content-between align-items-end">
												<strong>이메일</strong>
												<input type="text" name="email" placeholder="이메일을 입력 해주세요" id="inputEmail" class="email" value="${email}"> <input type="hidden" name="gifticonImageName" value="${shopProduct.gifticonImage}">
											</div>
										</c:if>

										<br>
										<c:choose>
											<c:when test="${principal.userRole == '관리자'}">
												<button type="button" class="blue--btn--small" data-toggle="modal" data-target="#myModal" style="width: 100%;">
													<ul class="d-flex justify-content-center" style="margin: 0;">
														<li style="margin-right: 4px;">수정
														<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">edit</span>
													</ul>
												</button>
											</c:when>
											<c:otherwise>
												<button type="submit" class="blue--btn--small buyButton" id="buyButton">
													<ul class="d-flex justify-content-center" style="margin: 0;">
														<li style="margin-right: 4px;">구매
														<li><span class="material-symbols-outlined" style="font-size: 22px; margin-top: 3px;">done</span>
													</ul>
												</button>
											</c:otherwise>
										</c:choose>
									</c:when>
								</c:choose>

							</div>
						</div>
						<input type="hidden" name="productId" value="${shopProduct.id}"> <input type="hidden" name="description" value="[${shopProduct.brand}] ${shopProduct.name}"> <input type="hidden"
							name="hiddenCount" value="${shopProduct.count}">
					</form>
				</div>

				<!-- 상품 선택영역 -->

			</div>
			<!--// 상품 정보영역 -->
			<!-- Button to Open the Modal -->

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
						<form action="/product/update" method="post" enctype="multipart/form-data">
							<div class="modal-body">
									<input type="text" value="${shopProduct.brand}" name="brand">
									<input type="text" value="${shopProduct.name}" name="name">
									<input type="text" value="${shopProduct.count}" name="count">
									<input type="text" value="${shopProduct.price}" name="price">
									<input type="hidden" value="${shopProduct.id}" name="id">
							</div>
	
							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="submit" class="blue--btn--small" style="margin: 0 10px">
									<ul class="d-flex justify-content-center" style="margin: 0;">
										<li style="margin-right: 4px;">수정
										<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">edit</span>
									</ul>
								</button>
								<button type="button" class="blue--btn--small" style="margin: 0 10px; background-color: gray" onclick="location.href='/product/delete/${shopProduct.id}'">
									<ul class="d-flex justify-content-center" style="margin: 0;">
										<li style="margin-right: 4px;">삭제
										<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px;">delete_forever</span>
									</ul>
								</button>
							</div>
						</form>

					</div>
				</div>
			</div>

		</div>
		<!-- 상품정보 탭 -->
		<div class="tab_wrap3">
			<ul class="tab_head t4">
				<li class="on"><a href="#none" class="tab_head--li" onclick="toggleTab(0);">상품정보</a></li>
				<li><a href="#none" class="tab_head--li" onclick="toggleTab(1);">사용안내</a></li>
				<li><a href="#none" class="tab_head--li" onclick="toggleTab(2);">상품 정보 제공 고시</a></li>
				<li><a href="#none" class="tab_head--li" onclick="toggleTab(3);">환불 안내</a></li>
			</ul>
			<div class="tab_content">
				<div id="tab1" class="tab_cont on">
					<div class="inner">
						<!-- 상품 정보 내용 -->
						<table class="tbl_prdinfo list--table" border="1">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">상품 상세 정보</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td_sub_tit">사용 방법</td>
									<td>- <span style="color: red;">교환 유효기간은 발행일로부터 365일입니다.</span><br></td>
								</tr>
								<tr>
									<td class="td_sub_tit">주의사항</td>
									<td>- 메뉴 변경 불가<br>
									    - 할인, 이벤트 적용 및 포인트 적립 불가<br>
									    - 일부 백화점 및 특수매장 사용불가
									</td>
								</tr>
								<tr>
									<td class="td_sub_tit">사용 불가 매장</td>
									<td>- 서울/경기/인천 : 스타필드고양PK마켓점, 인천공항점, 파주첼시아울렛점, 이대ECC점, 영종대교휴게소점, 덕평자연휴게소점, 일산벨라시타점, 마포일진빌딩점, 도이치오토월드점, CGV고양행신점, CGV부천점, CGV평촌점, CGV평택점<br> 
										- 그 외 지역 : 부산센텀점, 천안신세계점, 신세계대구점, 대구이월드점, 신세계마산점, 대명델피노점, CGV청주율량점, 서천국립생태원점, 상록리조트점, CGV목포평화광장점, CGV포항점, CGV대구스타디움점, CGV광주금남로점, CGV제주점
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tab2" class="tab_cont" style="display: none">
					<div class="inner">
						<!-- 사용안내 내용 -->
						<table class="tbl_prdinfo list--table" border="1">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">weekly deals 사용 설명</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td_sub_tit">사용안내</td>
									<td>- 그린항공 홈페이지 &gt; 그린클럽 &gt; 마일리지 사용몰 &gt; Weekly Deals에서 마일리지 공제<br> - 주문내역을 SMS로 발송 후, 수신 문자 내역을 해당 매장에서 확인 후 사용<br> <br> 문자가 미수신된 경우 아래와 같이 휴대폰 확인 부탁드립니다.<br>
										- 데이터 차단 (wi-fi 사용) 혹은 데이터 제한 요금제 사용 여부 확인 부탁드립니다.<br> - 휴대폰 스팸 설정 여부 확인 부탁드립니다. (통신사에 요청했거나, 단말기내 스팸 문구 설정)<br> - 수신 번호가 15XX, 060, 070으로 시작하는 경우 스팸 차단 가능성이 있습니다.<br> - 그 외
										특정 문구 사용시 단말기내 스팸 보관함으로 필터링 될 수 있습니다.<br> - 전원이 꺼져 있거나, 망 이외의 지역에 있는지 확인 부탁드립니다.<br> - 구형 스마트폰 단말기 및 기타 단말기 오류 등으로 인해 수신을 못할 수 있습니다.<br> - 문자 발송까지 시간이 다소 소요됩니다.<br> 위 사항
										확인하시고 상품 구매 24시간 경과 후에도 문자가 미수신된 경우 고객센터로 연락 주시기 바랍니다.
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tab3" class="tab_cont" style="display: none">
					<div class="inner">
						<!-- 상품 정보제공 고시 내용 -->
						<table class="tbl_prdinfo list--table" border="1">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">상품 정보제공 고시</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="td_sub_tit">발행자</td>
									<td>㈜케이티알파</td>
								</tr>
								<tr>
									<td class="td_sub_tit">유효기간</td>
									<td>- 공정거래위원회 모바일상품권 신유형 표준약관에 근거합니다.<br> - 365일 (각 상품의 유효기간 다르니 상품설명에서 확인하시길 바랍니다.)<br> - 일부 상품의 경우, 유효기간 제한될 수 있습니다.
									</td>
								</tr>
								<tr>
									<td class="td_sub_tit">이용조건</td>
									<td>- 상품설명에서 기간연장 불가 안내가 명시돼 있는 경우 기간 연장은 불가합니다.<br> - 유효기간 이내에만 연장 가능하며 기존 유효기간에서 3개월씩 최대 5년이내 연장 가능합니다.<br> - 쿠폰 유효기간 만료시 기간연장은 불가하며 환불만 가능합니다.
									</td>
								</tr>
								<tr>
									<td class="td_sub_tit">지급보증</td>
									<td>본 기프티쇼는 지급보증 및 보증보험계약 없이 ㈜케이티알파의 신용으로 발행합니다.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="tab4" class="tab_cont" style="display: none">
					<div class="inner">
						<!-- 연장/환불 안내 내용 -->
						<table class="tbl_prdinfo list--table">
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<thead>
								<tr class="tbl_prdinfo_tit">
									<th colspan="2" class="NamoSE_border_show">환불 정보</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>[환불]<br>* <span style="text-decoration: underline;">환불 시 유효기간이 만료된 마일리지는 자동 소멸</span>되오니 주의 부탁
										드립니다.<br> * 환불 방법<br> - 쿠폰 유효기간 이내: 그린항공 홈페이지 &gt; 그린클럽 &gt; 마일리지사용몰 &gt; 마일리지사용몰 구매내역에서 직접 취소<br> - 쿠폰 유효기간 만료 및 연장된 쿠폰: 그린 고객센터 문의(1588-8180)
									</td>
								</tr>
								<tr>
									<td>환불 관련 문의는 그린 고객센터로 연락하여 주시기 바랍니다.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	</div>
	<div class="d-flex justify-content-center" style="margin-top: 20px;">
		<button type="button" class="blue--btn--small" style="padding-left: 9px; background-color: gray" onclick="location.href='/product/productMain/clasic'">
			<ul class="d-flex justify-content-center" style="margin: 0;">
				<li><span class="material-symbols-outlined material-symbols-outlined-white" style="font-size: 22px; margin-top: 3px; margin-right: 5px;">keyboard_backspace</span>
				<li>목록
			</ul>
		</button>
	</div>
</main>
<script type="text/javascript">
		/* 옵션 선택하면 구매하기 버튼 숨기기 */
		let buyBtn = $("#buyButton").hide();
		let inputEmail = $("#inputEmail").hide();

/* 제품 옵션, 구매 버튼 보이게 */
	$("#optionList").on("change", function() {
		let selectedOption = $(this).val();
		buyBtn.show();
		inputEmail.show();
		
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
		buyBtn.hide();
		inputEmail.hide();
		countInput.val(1);
		totalPriceElement.text(initialPrice);

		/* $(this).parent().hide(); */
		$('.selected_prd').hide();
		
	});
	
	// 수량 증가 버튼 클릭 시
	document.querySelector('.plus')
			.addEventListener('click', function() {
						let minusTarget = document.querySelector('.minus');
						let target = document.querySelector('.plus');
						let countInput = document.querySelector('input[name="amount"]');
						let countValue = parseInt(countInput.value); 
						
						let priceElement = document.querySelector('.price .num.each_mile');
						let totalPriceElement = document.querySelector('.total_mile .num');
						let price = parseInt(priceElement.textContent);
						let hiddenPrice = document.querySelector('input[name="productPrice"]'); 
						let hiddenCount = document.querySelector('input[name="hiddenCount"]');
						
						// 구매 수량 5개 제한 제거
						countInput.value = countValue + 1;
						totalPriceElement.textContent = priceToString(price * (countValue + 1));
						hiddenPrice.value = price * (countValue + 1);
						hiddenCount.value = ${shopProduct.count} - countInput.value
						
						minusTarget.disabled = false;

						if (${shopProduct.count} == countValue){
							countInput.value = countValue;
							target.disabled = true;
							alert('최대 수량입니다.');
							
						}
						
						if (${shopProduct.count} == countValue){
							countInput.value = countValue;
							target.disabled = true;
							alert('최대 수량입니다.');
						}
					});

	// 수량 감소 버튼 클릭 시
	document.querySelector('.minus')
			.addEventListener('click', function() {
						let target = document.querySelector('.plus');
						let minusTarget = document.querySelector('.minus');
						let countInput = document.querySelector('input[name="amount"]');
						let countValue = parseInt(countInput.value);
						let priceElement = document.querySelector('.price .num.each_mile');
						let totalPriceElement = document.querySelector('.total_mile .num');
						let price = parseInt(priceElement.textContent);
						let hiddenPrice = document.querySelector('input[name="productPrice"]');
						let hiddenCount = document.querySelector('input[name="hiddenCount"]');
						
						if (countValue > 1) {
							countInput.value = countValue - 1;
							totalPriceElement.textContent = priceToString(price * (countValue - 1));
							hiddenPrice.value = priceToString(price * (countValue - 1));
							hiddenCount.value = ${shopProduct.count} - countInput.value
							target.disabled = false;
						} else if (countValue > 0) {
							minusTarget.disabled = true;
							alert('최소 1개 이상 선택해주시기 바랍니다.');
						}
					});
	
	function priceToString(price1) {
	    return price1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	/* 마일리지 비교 */
	document.querySelector('.buyButton')
			.addEventListener('click', function() {
				let email = $('.email').val();
				let exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				let myMileage = document.querySelector('.myMileage').innerHTML;
				let total = $('#productPrice').val();
				let amount = $('#amount').val(); 
				let hiddenCount = document.querySelector('input[name="hiddenCount"]');
				

				if(parseInt(myMileage) < parseInt(total)){
					console.log(myMileage)
					console.log(total*amount)
					
					alert('마일리지가 부족합니다.');
					 event.preventDefault();
					 location.reload();
				}else if(email == null || exptext.test(email) == false){
					alert("이메일 형식이 올바르지 않습니다.");
					event.preventDefault();
					 location.reload();
				}

			});
	
	var tabContents = document.getElementsByClassName("tab_cont");
    for (var i = 1; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
    }
    
	function toggleTab(tabIndex) {
		 	

	        // 모든 탭 내용 숨기기
	        var tabContents = document.getElementsByClassName("tab_cont");
	        for (var i = 0; i < tabContents.length; i++) {
	            tabContents[i].style.display = "none";
	        }
	        // 선택한 탭 내용 보이기
	        var selectedTab = document.getElementById("tab" + (tabIndex + 1));
	        console.log(selectedTab)
	        selectedTab.style.display = "block";
	        
	    }

</script>


	<input type="hidden" name="menuName" id="menuName" value="마일리지샵">

	<%@ include file="/WEB-INF/view/layout/footer.jsp"%>