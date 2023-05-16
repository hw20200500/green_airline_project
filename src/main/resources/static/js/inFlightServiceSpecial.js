$(document).ready(function() {
	$("#inFlightMeals--option").on("change", function() {
		let nameVal = $("#inFlightMeals--option").val();
		$("#inFlightMeals--description").empty();
		$("#inFlightMeals--detail").empty();
		$(".modal--ifmdName").empty();
		/*$(".modal-content").empty();*/

		$.ajax({
			type: "get",
			url: "/changeCategory?name=" + nameVal,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {
			let description = $("#inFlightMeals--description");
			let detail = $("#inFlightMeals--detail");
			let image = $("#inFlightMeals--image");
			let modalIfmdName = $(".modal--ifmdName");

			for (let i = 0; i < data.length; i++) {
				// div태그 만들기
				let divNode = $("<div>");
				// 속성 추가
				divNode.attr("class", "ifm--detail");
				detail.append(divNode);

				let divNode2 = $("<span>");
				divNode.append(divNode2);
				divNode2.append(data[i].ifmdName);

				let radioNode = $("<input>");
				radioNode.attr("type", "radio");
				radioNode.attr("name", "ifmdName");
				radioNode.attr("id", "ifmdName--label"+i);
				modalIfmdName.append(radioNode);

				let labelNode = $("<label>");
				labelNode.attr("for", "ifmdName--label"+i);
				labelNode.append(data[i].ifmdName);
				modalIfmdName.append(labelNode);
				modalIfmdName.append("<br>");

				let divNode3 = $("<p>");
				divNode.append(divNode3);
				divNode3.append(data[i].ifmdDescription);

				let descriptionNode = $("#meals--image");
				descriptionNode.attr("src", "/images/in_flight/" + data[i].image);
			}

			description.append(data[0].ifmName);
			description.append(" : ");
			description.append(data[0].ifmDescription);

		}).fail(function(error) {
			console.log(error);
		})
	});
});

/*$(document).ready(function() {
	$("#inflightmeal--request").on("click", function() {
		let nameVal = $("#inFlightMeals--option").val();
		$(".modal--ifmdName").empty();

		$.ajax({
			type: "POST",
			url: "/inFlightService/specialMealReq",
			contentType: "application/json; charset=utf-8",

		}).done(function(data) {
			console.log("여기 오나요");


		}).fail(function(error) {
			console.log(error);
		})
	});
});*/

