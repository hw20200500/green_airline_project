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
.inFlightMeals--option--wrap {
	display: flex;
	justify-content: center;
}

#inFlightMeals--option {
	background-color: #f8f9fc;
	height: 40px;
	border: none;
	border-bottom: 1px solid #ddd;
	font-size: 28px;
	margin-bottom: 50px;
	margin-top: 30px;
	text-align: center;
	width: 420px;
	padding-bottom: 10px;
    height: 50px;
}

#inFlightMeals--option:focus {
	outline: none;
}

#inFlightMeals--image {
	display: flex;
	justify-content: center;
}

#inFlightMeals--description {
	display: flex;
	justify-content: center;
	font-size: 19.5px;
	margin-bottom: 20px;
	font-weight: bold;
	padding-left: 3px;
	margin-bottom: 50px;
}

/* #inFlightMeals--description>span {
	width: 1000px;
} */
#inFlightMeals--details {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-bottom: 10px;
}

#inFlightMeals--detail {
	display: flex;
}

.detail--wrap {
	width: 1100px;
}

.inFlightMeals--btn--wrap {
	display: flex;
	justify-content: center;
}

.inFlightMeals--btn--wrap>div {
	width: 1000px;
}

#seat--count--input:focus {
	outline: none;
}

.amount--count {
	display: flex;
	justify-content: space-evenly;
}

.btn--primary {
	color: white;
	border: none;
	background-color: #8ABBE2;
}

.btn--primary:hover {
	color: white;
	border: none;
	background-color: #8ABBE2;
}

.btn--danger {
	color: white;
	border: none;
	background-color: #DC6093;
}

.inflightService--wrap {
	height: 240px;
}

.inflightSv--amount--wrap {
	display: flex;
	align-items: center;
	height: 29px;
	cursor: pointer;
}

.inFlightMeals--request--wrap {
	margin-right: 7px;
}

.inFlightMeal--selectBox {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-bottom: 30px;
}
.inFlightMeals--ifmdName--content{
	font-size: 20px;
	font-weight: 500;
}	

.inFlightMeals--imfdDescription--content{
	font-size: 18px;
}

</style>

<div>
	<main>
		<h2 class="page--title">특별 기내식</h2>
		<hr>
		<br>
		<input type="hidden" name="memberId" value="memberId">

		<div class="inFlightMeals--option--wrap">
			<select id="inFlightMeals--option">
				<c:forEach var="flightMeals" items="${flightMeals}" varStatus="status">
					<c:if test="${status.index>0}">
						<option value="${flightMeals.name}">${flightMeals.name}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>

		<div id="inFlightMeals--image">
			<img id="meals--image" style="width: 1100px; height: 700px;" src="/images/in_flight/${inFlightMeals.get(0).image}">
		</div>
		<div id="inFlightMeals--description">
			<div>${inFlightMeals.get(0).ifmName} : ${inFlightMeals.get(0).ifmDescription}</div>
		</div>

		<div id="inFlightMeals--details">
			<c:forEach var="inFlightMeals" items="${inFlightMeals}">
				<div class="detail--wrap">
					<span class="inFlightMeals--ifmdName--content">${inFlightMeals.ifmdName}</span>
					<p class="inFlightMeals--imfdDescription--content">${inFlightMeals.ifmdDescription}</p>
				</div>
			</c:forEach>

		</div>


	</main>

	<script src="/js/inFlightServiceSpecial.js">
		
	</script>

</div>
<input type="hidden" name="menuName" id="menuName" value="특별 기내식">
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>