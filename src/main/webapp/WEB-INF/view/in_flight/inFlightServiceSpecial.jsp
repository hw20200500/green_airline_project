<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<div>
	<main>
		<h1>특별 기내식</h1>
		
		<script type="text/javascript">
		$(document).ready(function() {
 			
			$("#inFlightServiceSpecial--btn").on("click", function() {
				let nameVal = $("#inFlightMeals--option").val(); 
	 			console.log(nameVal); 
				
				$.ajax({
					type: "get",
					url: "/inFlightService/inFlightServiceSpecialSearch?name=" + nameVal,
					contentType:"application/json; charset=utf-8",
					dataType: "json"
				}).done(function(res){
					console.log(res);
				}).fail(function(error) {
					console.log(error);
				})
			});
		});
	</script>

		<div>
			<div>항목 선택</div>
			<select>
				<c:forEach var="inFlightMeals" items="${inFlightMeals}">
					<option id="inFlightMeals--option" value="${inFlightMeals.name}">${inFlightMeals.name}</option>
				</c:forEach>
			</select>
			<button type="button" id="inFlightServiceSpecial--btn">조회</button>
		</div>

		<c:forEach var="inFlightMeals" items="${inFlightMeals}">
			<div id="inFlightMeals--Description">${inFlightMeals.name}:${inFlightMeals.description}</div>
		</c:forEach>

		<c:forEach var="inFlightMeal" items="${inFlightMeal}">
			<div>${inFlightMeal.ifmdName}</div>
			<div>${inFlightMeal.ifmdDescription}</div>
		</c:forEach>		
	</main>


</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>