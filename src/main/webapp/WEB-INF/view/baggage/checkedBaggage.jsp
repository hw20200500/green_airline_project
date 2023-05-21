<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<main>
	<div>
		<div>
			<h1>위탁 수하물</h1>
			<p>항공사에 맡기는 각종 수하물의 크기, 요금, 준비 방법 등에 대한 정보를 안내해 드립니다.</p>
		</div>

		<div>
			<button>수하물 규정</button>
			<button>특수 수하물</button>
			<button>환승 수하물</button>
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
	</div>

	<script src="/js/checkedBaggage.js"></script>
</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>