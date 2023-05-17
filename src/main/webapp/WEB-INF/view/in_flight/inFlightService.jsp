<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
#menu {
	display: flex;
}
</style>
<div>
	<main>
		<h1>기내 서비스 순서 페이지</h1>
		<h3>todo 기내 서비스 테이블 만들기</h3>
		<div id="menu">
			<c:forEach var="inFlightServices" items="${inFlightServices}">
				<div>
					<div>
						<img alt="" src="/images/in_flight/${inFlightServices.image}">
					</div>
					<div>${inFlightServices.name}</div>
				</div>
			</c:forEach>
		</div>
		<c:forEach var="airportList" items="${airportList}">
			<div>${airportList.name}</div>
		</c:forEach>


		<div>
			<a href="/inFlightService/inFlightServiceSearch">기내 서비스 조회 페이지</a>
		</div>
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
