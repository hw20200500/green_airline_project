<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<style>
.baggage--kg--lbs {
	border: 1px solid black;
}

.carryBaggage--note--class{
	background-color: #f8f9fc;
    padding: 20px;
    margin-bottom: 20px;
}

table{
	width:1200px;
	text-align: center;
	border: 1px solid #ebebeb;
}

table tr td, table tr th{
	padding: 10px;
}

.carryBaggage--note--ul li{
	list-style: inside;
}
</style>
<main>
	<div>
		<div>
			<h2 class="page--title">휴대 수하물</h2>
			<p class="page--title--description">편안한 여행과 안전운항을 위해 기내로 가져갈 수 있는 휴대 수하물의 종류와 규격 및 개수를 안내해드립니다.</p>
			<hr>
			<br>
		</div>

		<div>
			<h4>휴대 수하물 허용 기준</h4>

			<div>
				허용 규격
				<ul>
					<li> 무게 : 10kg(22lbs)</li>
					<li>크기 : 삼변의 합 115cm 이내 (손잡이와 바퀴 포함)</li>
					<li>* 각 변의 최대치 A(Height) 55 cm, B(Depth) 20 cm, C(Width) 40 cm</li>
				</ul>
				<br>
			</div>
		</div>

		<div>
			<h4>휴대 수하물 규격 및 개수</h4>
			<div style="margin-bottom: 10px;">기내로 가져갈 수 있는 휴대 수하물의 규격 및 개수를 다음과 같이 제한하고 있습니다.</div>

			<div class="table_wrap">
				<table border="1" class="table_list table_bag">
					<colgroup>
						<col style="width: 50%;" span="2">
					</colgroup>
					<thead>
						<tr style="background-color: #f8f9fc;">
							<th>비즈니스 클래스</th>
							<th>이코노미 클래스</th>
						</tr>
					</thead>
					<tbody>
						<tr >
							<td>
								<div>
								<img src="/images/baggage/carryBaggage1.png">
									<p>
										무게 : <span>10kg</span>(22lbs) 이내<br> 허용 개수 : <span>2개</span>
									</p>
								</div>
							</td>
							<td>
								<div>
								<img src="/images/baggage/carryBaggage2.png">
									<p>
										무게 : <span>10kg</span>(22lbs) 이내<br> 허용 개수 : <span>1개</span>
									</p>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<br>
				<ul>
					<li>수하물은 반드시 머리 위 선반이나 앞 좌석 밑에 안전하게 수납할 수 있어야 합니다.</li>
					<li>비즈니스 스위트 탑승 시 비즈니스 클래스 규정 적용</li>
				</ul>
			</div>
			<br> <br>
		</div>

		<div class="carryBaggage--note--class">
			<h5>유의사항</h5>
			<ul >
				<li class="carryBaggage--head--note--class">수하물을 분실하지 않도록 주의하시기 바랍니다.
					<ul class="carryBaggage--note--ul">
						<li>기내 휴대수하물 및 기내 휴대 물품의 경우 손님께서 기내에 휴대하여 전적으로 보관하고 책임진다는 조건 하에 허용됩니다.</li>
						<li>비행 중 손님의 물품에 대해서 철저히 관리하시어 두고 내리시거나 분실되지 않도록 주의하여 주십시오.</li>
					</ul>
					<br>
				</li>
				<li class="carryBaggage--head--note--class">탑승구(Gate)에서는 수하물 위탁이 불가하오니, 기내 반입 휴대 수하물 규정을 반드시 준수하여 주십시오.
					<ul class="carryBaggage--note--ul">
						<li><span>공항에서 인도받은 면세품</span>을 포함하여, 휴대하는 수하물의 크기와 무게가 기내 반입 규격을 초과하지 않도록 주의하여 주십시오.</li>
					</ul>
					<br>
				</li>
				<li class="carryBaggage--head--note--class">아래의 물품 중 1개를 기내 반입 휴대수하물 외에 추가로 가져가실 수 있습니다.
					<ul class="carryBaggage--note--ul">
						<li>소형서류가방</li>
						<li>핸드북</li>
						<li>노트북컴퓨터</li>
						<li>독서물</li>
						<li>작은크기 면세품</li>
						<li>비행 중 사용하는 유아용 음식</li>
						<li>몸이 불편한 손님의 지팡이,목발</li>
						<li>시각장애인의 안내견</li>
						<li>일자형으로 접히는 소형 유모차</li>
					</ul>
					<p >* 단, 휴대 가능한 수하물의 경우라도 기내 공간 부족, 항공사 사정 등에 따라 위탁수하물로 처리 될 수 있습니다.</p>
					<br>
				</li>
				<li class="carryBaggage--head--note--class">별도의 좌석을 구매해야 운송이 가능한 물품
					<ul class="carryBaggage--note--ul">
						<li>삼변의 합이 115 cm를 초과하는 첼로, 가야금, 거문고, 기타(Guitar) 등과 같은 대형 악기는 별도의 좌석을 구입하여 기내로 안전하게 운송이 가능합니다.</li>
						<li>별도의 좌석을 구입하는 악기는 최대 높이 155cm까지 기내로 반입이 가능합니다.</li>
						<li>의료용 산소통을 사용하는 경우 별도 좌석 구매가 필요할 수 있습니다. (일부 비즈니스석 해당)</li>
					</ul>
					<br>
				</li>
				<li class="carryBaggage--head--note--class">기내 안전 및 승객 편의를 위해 비상구 또는 통로의 접근을 방해하거나 주변 승객에게 불편을 줄 수 있는 여행편의 용품은 <span>기내 사용이 불가</span>합니다. <br> 다만, 기내 휴대 수하물 허용 규격인 경우 <span>기내 반입은 가능</span>합니다.
					<ul class="carryBaggage--note--ul">
						<li>(예 : 자세 교정 의자, Bed Box, Inflatable Foot Leg Rest, Fly Legs Up, Inflatable Air Pillow 등)</li>
					</ul>
					<br>
				</li>
				<li class="carryBaggage--head--note--class">예외 사항
					<ul class="carryBaggage--note--ul">
						<li>운항 항공기의 제약 및 운항 국가별 공항 규정 및 절차에 따라 기내 반입이 변경/제한되는 경우도 있습니다.</li>
					</ul>
					<br>
				</li>
				<li class="carryBaggage--head--note--class">타 항공사로 연결 시&nbsp;해당 항공사의 기내&nbsp;휴대&nbsp;수하물 허용량 기준이 당사와 상이할 수 있습니다. <br> 각 항공사의 휴대 수하물 규정을 사전에&nbsp;확인하여주시기 바랍니다.
				</li>
			</ul>
		</div>

	</div>

</main>

<input type="hidden" name="menuName" id="menuName" value="수하물 안내">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>