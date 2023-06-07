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
.checkedBaggage--title--wrap {
	display: flex;
	margin-bottom: 20px;
}

.checkedBaggage--ul {
	display: flex;
	justify-content: space-between;
}

.checkedBaggage--ul li {
	display: flex;
}

.checkedBaggage--ul li a {
	display: block;
	display: flex;
	background-color: white;
	width: 590px;
	height: 70px;
	border: 1px solid #ebebeb;
	justify-content: center;
	align-items: center;
	font-size: 23px;
}

/* .checkedBaggage--ul li a:hover {
	background-color: #8abbe1;
	color: white;
} */
.transitBaggage--national--wrap {
	margin-top: 20px;
}

h4 {
	color: #174481;
}

.transitBaggage--content--wrap {
	margin-bottom: 20px;
}

p {
	font-size: 15px;
}
</style>
<main>
	<div>
		<div>
			<h2 class="page--title" style="margin-bottom: 30px;">수하물 이용 안내</h2>
			<p class="page--title--description">
				수하물은 고객이 여행 시 휴대 또는 탁송을 의뢰한 소지품 및 물품을 의미하는 단어입니다.<br> 짐을 준비하시는 고객님의 여행이 한결 편할 수 있도록 꼭 알아두셔야 하는 수하물 관련 정보를 안내합니다.
			</p>
			<hr>
			<br>
		</div>

		<div class="checkedBaggage--title--wrap">
			<ul class="checkedBaggage--ul">
				<li><a href="/baggage/checkedBaggage" id="left--li">수하물 규정</a></li>
				<li><a href="/baggage/transitBaggage" id="right--li" style="background-color: #8ABBE2; color: white;">환승 수하물</a></li>
			</ul>
		</div>

		<div>
			<h4>환승 수하물</h4>
			<p>수하물 연결 수속은 경유지 공항 사정 및 연결편 항공사에 따라 제한될 수 있으니 유형에 맞게 확인하여 주세요.</p>
			<img alt="" src="/images/baggage/transitBaggage1.png" style="width: 1180px; height: 450px;">
		</div>
		<div class="transitBaggage--national--wrap">
			<h4>국제선 - 국제선 연결 시</h4>
			<p>
				국제선 환승 시 연결편 항공사에 따라 수하물을 최종 목적지까지 연결 할 수 있습니다.<br> 출발 공항 탑승수속 카운터에서 수하물이 최종 목적지까지 연결하여 수속할 수 있는 지 확인하시기 바랍니다.
			</p>
			<br>
			<hr>
		</div>

		<div class="transitBaggage--content--wrap">
			<br>
			<h4>국제선 - 국내선 연결 시</h4>
			<br>
		</div>
		<div>
			<h5>대한민국 지역 국내선 환승</h5>
			<p>외국에서 한국으로 입국하여 한국 국내선으로 환승하는 경우, 반드시 수하물을 찾아 다시 수속을 해야 하므로 최종 목적지까지 수하물을 연결할 수 없습니다.</p>
			<p style="font-size: 15px; color: blue; margin-top: -10px;">
				*예외 : 환승 전용 내항기를 탑승하는 경우 수하물은 자동으로 연결됩니다. (단, 인천에서 입국하는 경우 환승 전용 내항기에 탑승할 수 없습니다.) <br> (예시 : 로스앤젤레스 – 인천 – 대구/부산)
			</p>
		</div>

		<div>
			<h5>유럽지역 국내선 환승</h5>
			<p>연결편 항공사에 따라 수하물을 최종 목적지까지 연결할 수 있습니다.</p>
		</div>

		<div>
			<h5>미국/캐나다 국내선 환승</h5>
			<p>
				외국에서 미국/캐나다로 입국하여 미국/캐나다 국내선 구간으로 환승하는 경우 반드시 수하물을 첫 번째 기착지 공항에서 찾아야 합니다.<br> 단, 수하물표가 이미 최종 목적지까지 발급되어 있기 때문에, 세관검사를 받고 환승 고객용 컨베이어 벨트로 옮긴 후 해당 국내선 카운터로 가면 됩니다.
			</p>
		</div>

		<div>
			<h5>그 외 지역 국내선 환승</h5>
			<p>일본, 중국, 호주, 러시아, 인도 등 대부분의 국가는 국내선으로 환승하는 경우 수하물을 연결할 수 없습니다.</p>
		</div>

	</div>
</main>

<input type="hidden" name="menuName" id="menuName" value="수하물 이용 안내">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
