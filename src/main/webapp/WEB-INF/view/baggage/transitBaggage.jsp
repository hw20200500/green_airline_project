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

<main>
	<div>
		<div>
			<h1>위탁 수하물 안내</h1>
			<p>항공사에 맡기는 각종 수하물의 크기, 요금, 준비 방법 등에 대한 정보를 안내해 드립니다.</p>
		</div>

		<div>
			<button type="button" onclick="location.href='/baggage/checkedBaggage'" class="btn btn-primary">수하물 규정</button>
			<button type="button" onclick="location.href='/baggage/transitBaggage'" class="btn btn-primary">환승 수하물</button>
		</div>

		<div>
			<h3>국제선 - 국제선 연결 시</h3>
			<p>
				국제선 환승 시 연결편 항공사에 따라 수하물을 최종 목적지까지 연결 할 수 있습니다.<br> 출발 공항 탑승수속 카운터에서 수하물이 최종 목적지까지 연결하여 수속할 수 있는 지 확인하시기 바랍니다.
			</p>
		</div>

		<div>
			<h3>국제선 - 국내선 연결 시</h3>
		</div>
		<div>
			<h4>대한민국 지역 국내선 환승</h4>
			<p>(예시 : 홍콩 – 부산 – 김포)</p>
			<p>외국에서 한국으로 입국하여 한국 국내선으로 환승하는 경우, 반드시 수하물을 찾아 다시 수속을 해야 하므로 최종 목적지까지 수하물을 연결할 수 없습니다.</p>
			<p>
				*예외 : 환승 전용 내항기를 탑승하는 경우 수하물은 자동으로 연결됩니다. (단, 인천에서 입국하는 경우 환승 전용 내항기에 탑승할 수 없습니다.) <br> (예시 : 로스앤젤레스 – 인천 – 대구/부산)
			</p>
		</div>

		<div>
			<h4>유럽지역 국내선 환승</h4>
			<p>(예시 : 인천 – 프랑크푸르트 – 베를린)</p>
			<p>연결편 항공사에 따라 수하물을 최종 목적지까지 연결할 수 있습니다.</p>
		</div>

		<div>
			<h4>미국/캐나다 국내선 환승</h4>
			<p>(예시 : 인천 – 로스앤젤레스 – 샌프란시스코)</p>
			<p>
				외국에서 미국/캐나다로 입국하여 미국/캐나다 국내선 구간으로 환승하는 경우 반드시 수하물을 첫 번째 기착지 공항에서 찾아야 합니다.<br> 단, 수하물표가 이미 최종 목적지까지 발급되어 있기 때문에, 세관검사를 받고 환승 고객용 컨베이어 벨트로 옮긴 후 해당 국내선 카운터로 가면 됩니다.
			</p>
		</div>

		<div>
			<h4>그 외 지역 국내선 환승</h4>
			<p>(예시 : 인천 – 도쿄 – 후쿠오카)</p>
			<p>일본, 중국, 호주, 러시아, 인도 등 대부분의 국가는 국내선으로 환승하는 경우 수하물을 연결할 수 없습니다.</p>
		</div>
		
		<div>
		
		</div>
	</div>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
