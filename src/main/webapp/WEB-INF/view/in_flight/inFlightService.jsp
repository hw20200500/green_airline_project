<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
</style>
<div>
	<main>
		<h1>기내 서비스 페이지</h1>
		<div>
			<c:forEach var="inFlightServices" items="${inFlightServices}">
				<div>${inFlightServices.name}</div>
				<div>${inFlightServices.description}</div>
			</c:forEach>
		</div>
		<div><a href="/inFlightService/inFlightServiceSearch">기내 서비스 조회 페이지</a></div>
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
