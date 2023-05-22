<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.baggageMiss--guide--class, .baggageMiss--note--class {
	width: 1200px;
}
</style>
<main>
	<div>
		<h1>지연, 파손 및 유실물</h1>
		<%-- 
		<select>
			<c:forEach var="baggageMisses" items="${baggageMisses}">
				<option value="${baggageMisses.name}">${baggageMisses.name}</option>
			</c:forEach>
		</select>
		--%>

		<c:forEach var="baggageMisses" items="${baggageMisses}" varStatus="status">
			<button type="button" value="${baggageMisses.name}" id="baggageMiss--name" name="name" class="btn btn-primary buttonArray">${baggageMisses.name}</button>
		</c:forEach>

		<%--${baggageMisses.get(0).guide} ${baggageList.get(0).note} --%>
		<div class="baggageMiss--guide--class"></div>
		<div class="baggageMiss--note--class"></div>

	</div>
</main>

<script src="/js/baggageMiss.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>