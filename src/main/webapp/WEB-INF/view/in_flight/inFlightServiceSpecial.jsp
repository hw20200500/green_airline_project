<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<div>
	<main>
		<h1>특별 기내식</h1>

		<div>
			<div>항목 선택</div>
			<select id="inFlightMeals--option">
				<c:forEach var="flightMeals" items="${flightMeals}">
					<option value="${flightMeals.name}">${flightMeals.name}</option>
				</c:forEach>
			</select>
			<button type="button" id="inFlightServiceSpecial--btn">조회</button>
		</div>

		<div id="inFlightMeals--description"></div>
		<div id="inFlightMeals--detail"></div>

	</main>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#inFlightServiceSpecial--btn").on("click", function() {
				let nameVal = $("#inFlightMeals--option").val();
				$("#inFlightMeals--description").empty();
				$("#inFlightMeals--detail").empty();
				
				$.ajax({
					type : "get",
					url : "/changeCategory?name=" + nameVal,
					contentType : "application/json; charset=utf-8"
				}).done(function(data, textStatus, xhr) {
					let description = $("#inFlightMeals--description");
					let detail = $("#inFlightMeals--detail");

					for (let i = 0; i < data.length; i++) {
						// div태그 만들기
						let divNode = $("<div>"); 
						// 속성 추가
						divNode.attr("class", "ifm--detail");
						detail.append(divNode);
						
						let divNode2=$("<span>");
						divNode.append(divNode2);
						divNode2.append(data[i].ifmdName);
						let divNode3=$("<p>");
						divNode.append(divNode3);
						divNode3.append(data[i].ifmdDescription);
					}
					
					description.append(data[0].ifmName);
					description.append(" : ");
					description.append(data[0].ifmDescription);
				}).fail(function(error) {
					console.log(error);
				})
			});
		});
	</script>

</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>