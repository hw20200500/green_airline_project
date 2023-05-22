<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<main>
	<div>
		<div>
		<%-- 위탁 수하물 레이아웃 만들기 --%>
			<h1>위탁 수하물</h1>
			<p>항공사에 맡기는 각종 수하물의 크기, 요금, 준비 방법 등에 대한 정보를 안내해 드립니다.</p>
		</div>

		<div>
			<button type="button" onclick="location.href='/baggage/checkedBaggage'" class="btn btn-primary">수하물 규정</button>
			<button type="button" onclick="location.href='/baggage/transitBaggage'" class="btn btn-primary">환승 수하물</button>
		</div>

		<div>
			<h3>무료 위탁 수하물</h3>
			<p>탑승 여정에 맞는 무료 수하물 허용량을 조회해 보세요.</p>
		</div>

		<div>
			<select id="free--baggage--id" name="section">
				<c:forEach var="baggage" items="${baggage}">
					<option value="${baggage.section}">${baggage.section}</option>
				</c:forEach>
			</select>
		</div>

		<div class="free--baggage--description--class">
			<table border="1">
				<tr>
					<td>좌석 등급</td>
					<td>무료 수하물 허용량</td>
				</tr>
				<c:forEach var="checkedBaggages" items="${checkedBaggages}" varStatus="status">
					<tr class="checkedBaggages--all--class${status.index} checkedBaggages--empty--class">
						<td class="checkedBaggages--gradeId--class">${checkedBaggages.gradeId}</td>
						<td class="checkedBaggages--freeAllowance--class">${checkedBaggages.freeAllowance}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div>
			<h3>유의사항</h3>
			<ul>
				<li>조회 결과는 조회 구간에 대한 일반 규정으로, 경유지가 포함되어 있을 수 있으며 실제 운항 여부는 확인이 필요합니다.</li>
				<li>이 정보는 참고용으로 공항에서 지불시 제시되는 금액입니다.</li>
				<li>스카이패스 회원 등급은 탑승일에도 자격이 유효한 경우에만 적용됩니다.</li>
				<li>위탁수하물 개수가 4개를 초과할 경우 또는 다구간 여정일 경우 대한항공 서비스센터로 문의하여 주시기 바랍니다.<br> (추가 위탁 가능한 수하물 개수는 항공기의 운항 상황에 따라 제한될 수 있습니다.)</li>
				<li>개수/무게/사이즈 초과에 부과되는 요금은 수하물 각각에 부과됩니다.</li>
				<li>사이즈 초과를 지정하지 않은 경우, 158cm 이내(가로+세로+높이) 사이즈 기준으로 요금이 제공됩니다.</li>
			</ul>
		</div>
		
	</div>
	<script src="/js/checkedBaggage.js"></script>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>