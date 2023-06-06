
$(document).ready(function() {

	$("#inFlightMeals--option").on("change", function() {

		let nameVal = $("#inFlightMeals--option").val();
		$("#inFlightMeals--description").empty();
		$("#inFlightMeals--details").empty();
		/*$(".modal--ifmdName").empty();*/
		/*$(".modal-content").empty();*/
		
		$.ajax({
			type: "get",
			url: "/changeCategory?name=" + nameVal,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {
			console.log(data);
			let description = $("#inFlightMeals--description");
			let detail = $("#inFlightMeals--details");
			
			for (let i = 0; i < data.length; i++) {
				let divNode = $("<div>");
				divNode.attr("class", "detail--wrap");
				detail.append(divNode);

				let divNode2 = $("<span>");
				divNode2.attr("class", "inFlightMeals--ifmdName--content");
				divNode.append(divNode2);
				divNode2.append(data[i].ifmdName);

				let divNode3 = $("<p>");
				divNode3.attr("class", "inFlightMeals--imfdDescription--content");
				divNode.append(divNode3);
				divNode3.append(data[i].ifmdDescription);

				let descriptionNode = $("#meals--image");
				descriptionNode.attr("src", "/images/in_flight/" + data[i].image);
			}

			description.append(data[1].ifmName);
			description.append(" : ");
			description.append(data[1].ifmDescription);

		}).fail(function(error) {
			console.log(error);
		})
	});



	$("#inFlightMeals--request--btn").on("click", function() {
		let selectVal = $("#modal--id--arrivaldate").val();

		if (selectVal == undefined) {
			alert("특별 기내식 신청 가능 일정이 없습니다.");
			return false;
		}
	});

	$("#inflightmeal--request").on("click", function() {
		// 체크박스 체크 여부 확인
		let babyMealId = $('input[name="babyMeal"]:checked').val();
		let veganMealId = $('input[name="veganMeal"]:checked').val();
		let lowfatMealId = $('input[name="lowfatMeal"]:checked').val();
		let religionMealId = $('input[name="religionMeal"]:checked').val();
		let etcMealId = $('input[name="etcMeal"]:checked').val();

		let babyMealCheck = $('input[name="babyMeal"]:checked').is(':checked');
		let veganMealCheck = $('input[name="veganMeal"]:checked').is(':checked');
		let lowfatMealCheck = $('input[name="lowfatMeal"]:checked').is(':checked');
		let religionMealCheck = $('input[name="religionMeal"]:checked').is(':checked');
		let etcMealCheck = $('input[name="etcMeal"]:checked').is(':checked');
		if (babyMealCheck == false && veganMealCheck == false && lowfatMealCheck == false &&
			religionMealCheck == false && etcMealCheck == false) {
			alert("특별식 종류를 선택해주세요.");
			return false;
		}

		let babyMealAmount = $('#seat--count--input1').val();
		let veganMealAmount = $('#seat--count--input2').val();
		let lowfatMealAmount = $('#seat--count--input3').val();
		let religionMealAmount = $('#seat--count--input4').val();
		let etcMealAmount = $('#seat--count--input5').val();
		let ticketId = $('select[name="modal--name--arrivaldate"').val();
		
		if (babyMealCheck) {
			if (babyMealAmount == 0) {
				alert("신청 수량을 입력해주세요.")
				return false;
			}
		} else {
			if (babyMealAmount != 0) {
				alert("아동식 종류를 선택해주세요.");
				return false;
			}
		}

		if (veganMealCheck) {
			if (veganMealAmount == 0) {
				alert("신청 수량을 입력해주세요.")
				return false;
			}
		} else {
			if (veganMealAmount != 0) {
				alert("아동식 종류를 선택해주세요.");
				return false;
			}
		}

		if (lowfatMealCheck) {
			if (lowfatMealAmount == 0) {
				alert("신청 수량을 입력해주세요.")
				return false;
			}
		} else {
			if (lowfatMealAmount != 0) {
				alert("아동식 종류를 선택해주세요.");
				return false;
			}
		}
		if (religionMealCheck) {
			if (religionMealAmount == 0) {
				alert("신청 수량을 입력해주세요.")
				return false;
			}
		} else {
			if (religionMealAmount != 0) {
				alert("아동식 종류를 선택해주세요.");
				return false;
			}
		}

		if (etcMealCheck) {
			if (etcMealAmount == 0) {
				alert("신청 수량을 입력해주세요.")
				return false;
			}
		} else {
			if (etcMealAmount != 0) {
				alert("아동식 종류를 선택해주세요.");
				return false;
			}
		}

		let total = parseInt(babyMealAmount) + parseInt(veganMealAmount) + parseInt(lowfatMealAmount) + parseInt(religionMealAmount) + parseInt(etcMealAmount);
		if (total == 0) {
			alert("입력된 값이 없습니다.");
			return false;
		}
		
		ticketId = ticketId.split("_")[0];
		let formData = {
			"babyMealAmount": babyMealAmount,
			"veganMealAmount": veganMealAmount,
			"lowfatMealAmount": lowfatMealAmount,
			"religionMealAmount": religionMealAmount,
			"etcMealAmount": etcMealAmount,
			"babyMealId": babyMealId,
			"veganMealId": veganMealId,
			"lowfatMealId": lowfatMealId,
			"religionMealId": religionMealId,
			"etcMealId": etcMealId,
			"ticketId": ticketId,
		}
		$.ajax({
			type: "post",
			url: "/specialMealReq",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(formData),
			dataType: "json"
		}).done(function(data) {
			if (data.statusCode == 200) {
				alert(data.message);
				location.reload();
			} else {
				alert(data.message);
				location.reload();
			}
		}).fail(function(error) {
			console.log(error);
		})
	});

	$("#modal--id--arrivaldate").on("change", function() {
		$("#seat--count--input1").val(0);
		$("#seat--count--input2").val(0);
		$("#seat--count--input3").val(0);
		$("#seat--count--input4").val(0);
		$("#seat--count--input5").val(0);
		$('input:radio[name="babyMeal"]').prop("checked", false);
		$('input:radio[name="veganMeal"]').prop("checked", false);
		$('input:radio[name="lowfatMeal"]').prop("checked", false);
		$('input:radio[name="religionMeal"]').prop("checked", false);
		$('input:radio[name="etcMeal"]').prop("checked", false);
	}); 

	$(".modal").on("hidden.bs.modal", function() {
		$(this).find('form')[0].reset();
	});
});

function seatCountPlus(count) {
		$("#seat--count--input").val(0);
	const resultElement = $("#seat--count--input" + count);
	let maxNumberValue = $("#modal--id--arrivaldate").val();
	let maxNumber = maxNumberValue.split("_")[1];
	let currentCount1 = $("#seat--count--input1").val();
	let currentCount2 = $("#seat--count--input2").val();
	let currentCount3 = $("#seat--count--input3").val();
	let currentCount4 = $("#seat--count--input4").val();
	let currentCount5 = $("#seat--count--input5").val();
	let total = parseInt(currentCount1) + parseInt(currentCount2) + parseInt(currentCount3) + parseInt(currentCount4) + parseInt(currentCount5);
	let number = resultElement.val();
	if (number < maxNumber && total < maxNumber) {
		let number = resultElement.val();
		number = parseInt(number) + 1;
		resultElement.val(number);
	}
}

function seatCountMinus(count) {
	const resultElement = $("#seat--count--input" + count);
	let number = resultElement.val();
	if (number > 0) {
		number = parseInt(number) - 1;
		resultElement.val(number);
	}
}



function departureDateFormat(date) {
	const year = date.getFullYear();
	const month = (1 + date.getMonth());
	const day = date.getDate();
	return `${year}년 ${month}월 ${day}일`; //Template literals 이용
}


 
let beforeChecked = 0;
 
$(document).on("click", "input[type=radio]", function(e) {
	
	let index = $(this).parent().index("label");

	if (beforeChecked == index) {
		beforeChecked = 0;
		$(this).prop("checked", false);
	} else {
		beforeChecked = index;
	}

});





