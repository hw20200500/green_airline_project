
// 수하물 규정의 section 찍는 부분 
$(document).ready(function() {

	$("#free--baggage--id").on("change", function() {
		let section = $("#free--baggage--id").val();
		$(".checkedBaggages--empty--class").empty();

		$.ajax({
			type: "get",
			contentType: "application/json; charset=utf-8",
			url: `/freeBaggage?section=${section}`
		}).done(function(data) {

			for (let i = 0; i < data.length; i++) {
				let tdNode = $("<td>");
				let tdNode2 = $("<td>");
				$(".checkedBaggages--all--class" + i).append(tdNode);
				$(".checkedBaggages--all--class" + i).append(tdNode2);
				tdNode.append(data[i].gradeId);
				tdNode2.append(data[i].freeAllowance);
			}

		}).fail(function(error) {
			console.log(error);
		});
	});

	$("#checkedBaggage--request--btn").on("click", function() {

		$.ajax({
			type: "get",
			url: `/baggageReq`,
			contentType: "application/json; charset=utf-8",
		}).done(function(data) {
			console.log(data);
		}).fail(function(error) {
			console.log(error)
		});
	});

	$("#modal--id--departuredate").on("change", function() {
		let departureDateVal = $("#modal--id--departuredate").val();

		$.ajax({
			type: "get",
			url: "/maxCount?departureDate=" + departureDateVal,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {
			console.log(data);
			$("#seat--count--input").attr("max", data.seatCount * 4);
		}).fail(function(error) {
			console.log(error);
		});
	});

	$("#checkedBaggage--request--btn").on("click", function() {
		let isLoginCheck = $("#isLogin--check").val();
		if (isLoginCheck == "false") {
			alert("로그인 후 이용 가능합니다.");
			window.location.href = '/login';
			return false;
		}
	});
});

