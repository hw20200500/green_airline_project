<%@page import="com.green.airline.utils.Define"%>
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

<!-- 항공권 환불 안내 페이지 -->

<style>
	.list--table td:first-of-type {
		width: 65%;
	}
	
	.no--fee {
		font-weight: 600; 
		color: #434343; 
		font-size: 19px;
		margin-top: 20px;
	}
	
	.age--type--p {
		text-align: left; 
		font-size: 14px; 
		color: gray; 
		margin-top: 5px; 
		margin-right: 30px;
	}
	
	.no--fee--ul li {
		list-style: disc;
		color: #4f4f4f;
		margin-left: 40px;
	}
</style>

<main class="d-flex flex-column">
	<h2 class="page--title">항공권 환불 안내</h2>
	<hr>
	<br>
	
	<div class="d-flex flex-column align-items-center" style="width: 100%;">
		<div style="width: 900px;">
			<h4 class="middle--title">
				<span class="material-symbols-outlined" style="font-size: 32px;">attach_money</span>
				<span>국내선 환불 수수료</span>
			</h4>
			<table border="1" id="feeTable1" class="list--table">
				<thead>
					<tr>
						<th>출발일 기준 환불 신청일</th>
						<th>금액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="refundFee" items="${refundFeeList1}">
						<tr>
							<td>전체</td>
							<td>${refundFee.formatFee()}원</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p class="age--type--p">
				소아는 성인 수수료의 ${Define.childPriceRate()}% 만큼 책정됩니다.
				<br>
				유아는 수수료를 지불하지 않습니다.
			</p>
			<h5 class="no--fee">면제 대상</h5>
			<ul class="no--fee--ul">
				<li>고객 사정에 의한 환불이 아닌 경우
			</ul>
			<br><br>
			<hr style="width: 1000px; margin-left: -50px;">
			<br><br>
			<h4 class="middle--title">
				<span class="material-symbols-outlined" style="font-size: 32px;">attach_money</span>
				<span>국제선 환불 수수료</span>
			</h4>
			<table border="1" id="feeTable1" class="list--table">
				<thead>
					<tr>
						<th>출발일 기준 환불 신청일</th>
						<th>금액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="refundFee" items="${refundFeeList2}">
						<tr>
							<td>${refundFee.criterion}일 이전</td>
							<td>${refundFee.formatFee()}원</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p class="age--type--p">
				소아는 성인 수수료의 ${Define.childPriceRate()}% 만큼 책정됩니다.
				<br>
				유아는 수수료를 지불하지 않습니다.
			</p>
			<h5 class="no--fee">면제 대상</h5>
			<ul class="no--fee--ul">
				<li>출발일 기준 90일 이전 환불하는 한국 출발 국제선 항공권인 경우
				<li>고객 사정에 의한 환불이 아닌 경우
			</ul>
		</div>
	</div>

</main>

<input type="hidden" name="menuName" id="menuName" value="환불 안내">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
