<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
#inFlightService--all--wrap {
	display: flex;
}

.inFlightService--image--name--wrap {
	display: flex;
	flex-direction: column;
}

.inFlightService--wrap img {
	display: flex;
	justify-content: center;
}

.airport--region--wrap{
}

</style>
<div>
	<main>
		<h1>기내 서비스 순서 페이지</h1>
		<div id="inFlightService--all--wrap">
			<c:forEach var="inFlightServices" items="${inFlightServices}">
				<div class="inFlightService--image--name--wrap">
					<div class="inFlightService--wrap">
						<img alt="" src="/images/in_flight/${inFlightServices.image}" width="50" height="50">
					</div>
					<div>${inFlightServices.name}</div>
				</div>
			</c:forEach>
		</div>

		<div class="airport--region--wrap">지역
			<c:forEach var="regionList" items="${regionList}">
				<div>${regionList.name}</div>
			</c:forEach>
		</div>

		<div> 도시
			<c:forEach var="airportList" items="${airportList}">
				<div>${airportList.name}</div>
			</c:forEach>
		</div>

		<div>
			<a href="/inFlightService/inFlightServiceSearch">기내 서비스 조회 페이지</a>
		</div>
	</main>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
