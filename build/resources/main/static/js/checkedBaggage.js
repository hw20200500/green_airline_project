
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

		let selectVal = $("#modal--id--departuredate").val();
		console.log(selectVal);
		if (selectVal == null || selectVal == undefined) {
			alert("신청 가능한 항공권 예약 내역이 없습니다.");
			return false;
		} else {
			$.ajax({
				type: "get",
				url: `/baggageReq`,
				contentType: "application/json; charset=utf-8",
			}).done(function(data) {
				console.log(data);
				if (data.statusCode == 400) {
					alert("신청 가능한 항공권 예약 내역이 없습니다.");
					return false;
				}
			}).fail(function(error) {
				console.log(error);
			});

		}
	});

	$("#modal--id--departuredate").on("change", function() {
		let ticketId = $("#modal--id--departuredate").val();
		$.ajax({
			type: "get",
			url: "/maxCount?ticketId=" + ticketId,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {
			console.log(data);
			$("#seat--count--input").val(0);
			$("#seat--count--input").attr("max", data.seatCount * 4);
		}).fail(function(error) {
			console.log(error);
		});
	});


	$(".modal").on("hidden.bs.modal", function() {
		$(this).find('form')[0].reset();
	});

});

$("#submit--btn").on("click", function() {
	let amount = $("#seat--count--input").val();
	let ticketId = $("#modal--id--departuredate").val();
	
	if(amount == 0){
		alert("수량을 입력해주세요.");
		return false;
	}
	
	$.ajax({
		method: "post",
		url: "/checkedBaggageProc",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify({
			amount: amount,
			ticketId: ticketId,
		}),
		dataType: "json"
	}).done(function(res) {
		if (res.statusCode == 200) {
			alert(res.message);
			location.reload();
		} else {
			alert(res.message);
			location.reload();
		}
	}).fail(function(error) {
		console.log(error);
	});
});

/*let submitBtn = document.getElementById('submit--btn');
submitBtn.addEventListener("click", function() {
	let formData = {
		"amount": $("#seat--count--input").val(),
		"ticketId": $("#modal--id--departuredate").val()
	};
	fetch("/checkedBaggageProc", ({
		method: "post",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify(formData),
	})).then(response => {
		let result = response.json();
		console.log(result);
		if(result.status == 200) {
			alert(result.message);
			// location.href = "/baggage/myBaggageReq";
		} else {
			alert(result.message);
			// location.reload();
		}	
		
	});
});*/

function seatCountPlus() {
	const resultElement = $("#seat--count--input");
	let maxNumberValue = $("#seat--count--input").attr('max');
	console.log(maxNumberValue);

	let number = resultElement.val();
	console.log(number < maxNumberValue);
	if (parseInt(number) < parseInt(maxNumberValue)) {
		number = parseInt(number) + 1;
		resultElement.val(number);
	}
}

function seatCountMinus() {
	const resultElement = $("#seat--count--input");
	let number = resultElement.val();
	if (number > 0) {
		number = parseInt(number) - 1;
		resultElement.val(number);
	}
}
