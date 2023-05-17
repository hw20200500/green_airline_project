function selectedType(i) {
	// 이미 선택되어 있다면
	if ($(`#ticketType${i}`).hasClass("selected--type")) {
		return;
		// 선택되어 있지 않다면
	} else if ($(`#ticket--type${i}`).hasClass("selected--type") == false) {
		$(`#ticketType${i}`).addClass("selected--type");
		$(`#ticketType${i}`).siblings().removeClass("selected--type");
		// 탑승일 초기화
		$(".flight--date").val("");
		$(".flight--date1").val("");
		$(".flight--date2").val("");
		$("#flightDate").val("");
		$(".datepicker--div--type1").hide();
		$(".datepicker--div--type2").hide();
		$("#flightDate").removeClass("flight--date--inserted");
	}
}

// 출발지 도착지 스왑
function airportSwap() {
	let departureName = $("#departure").val();
	let destinationName = $("#destination").val();
	$("#destination").val(departureName);
	$("#departure").val(destinationName);
}

// 키가 입력될 때마다 자동완성 불러오기
$("#departure").on("keyup focus change", function() {
	// 공백 입력 금지	
	let searchName = $("#departure").val().replaceAll(" ", "");
	$("#departure").val(searchName);

	// 공백일 때는 자동 완성 미작동
	if (searchName == "") {
		$("#departureList").empty();
		return;
		// 주소에 \가 들어가면 오류나서 막음
	} else if (searchName.indexOf("\\") != -1) {
		$("#departureList").empty();
		var el = $("<li>검색 결과가 존재하지 않습니다.</li>");
		$("#departureList").append(el);
		return;
	}

	$.ajax({
		type: "GET",
		url: `/airport/search?name=${searchName}`,
		contentType: 'application/json; charset=utf-8'
	}).done((res) => {
		$("#departureList").empty();

		if (res.length == 0) {
			var el = $("<li>검색 결과가 존재하지 않습니다.</li>");
			$("#departureList").append(el);
		} else {
			for (let i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertAutoComplete(" + i + ", 'departure');\">");
				el.addClass("departure--li");
				el.append(res[i].name);
				$("#departureList").append(el);
			}
		}

	}).fail((error) => {
		console.log(error);
	});
});

// 키가 입력될 때마다 자동완성 불러오기
$("#destination").on("keyup focus", function() {
	// 공백 입력 금지	
	let searchName = $("#destination").val().replaceAll(" ", "");
	$("#destination").val(searchName);

	// 공백일 때는 자동 완성 미작동
	if (searchName == "") {
		$("#destinationList").empty();
		return;
		// 주소에 \가 들어가면 오류나서 막음
	} else if (searchName.indexOf("\\") != -1) {
		$("#destinationList").empty();
		var el = $("<li>검색 결과가 존재하지 않습니다.</li>");
		$("#destinationList").append(el);
		return;
	}

	$.ajax({
		type: "GET",
		url: `/airport/search?name=${searchName}`,
		contentType: 'application/json; charset=utf-8'
	}).done((res) => {
		$("#destinationList").empty();

		if (res.length == 0) {
			var el = $("<li>검색 결과가 존재하지 않습니다.</li>");
			$("#destinationList").append(el);
		} else {
			for (var i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertAutoComplete(" + i + ", 'destination');\">");
				el.addClass("destination--li");
				el.append(res[i].name);
				$("#destinationList").append(el);
			}
		}

	}).fail((error) => {
		console.log(error);
	});
});

// 지역 선택하면 해당하는 취항지 출력
$(".region--li").on("click", function() {
	$(this).addClass("region--li--selected");
	$(this).siblings().removeClass("region--li--selected");

	let region = $(this).text();
	$.ajax({
		type: "GET",
		url: `/airport/list?region=${region}`,
		contentType: "application/json; charset=UTF-8"

	}).done((res) => {
		$(".airport--ul").empty();

		if ($(".all--airport--modal").is(".depa")) {
			for (var i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertAirport(" + i + ", 'departure');\">");
				el.addClass("departure--airport--li");
				el.append(res[i].name);
				$(".airport--ul").append(el);
			}
		} else if ($(".all--airport--modal").is(".dest")) {
			for (var i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertAirport(" + i + ", 'destination');\">");
				el.addClass("destination--airport--li");
				el.append(res[i].name);
				$(".airport--ul").append(el);
			}
		}

	}).fail((error) => {
		console.log(error);
	});


});

// 다른 곳을 클릭하면 팝업 닫기
$(document).on("click", function(e) {

	if ($("#departureDiv").has(e.target).length === 0) {
		$("#departureAirport").hide();
	}

	if ($("#destinationDiv").has(e.target).length === 0) {
		$("#destinationAirport").hide();
	}

	if ($(".age--calculater--modal").has(e.target).length === 0) {
		$(".age--calculater--modal input").val("");
		$("#calculaterResult").text("");
	}

});

// input에 포커스를 두면 해당하는 팝업 보이게
$("#departure").on("focus", function() {
	$("#departureAirport").show();
	$(".datepicker--div--type1").hide();
	$(".datepicker--div--type2").hide();
});
$("#destination").on("focus", function() {
	$("#destinationAirport").show();
	$(".datepicker--div--type1").hide();
	$(".datepicker--div--type2").hide();
});

// 탑승일 선택 -> 왕복/편도에 따라
$("#flightDate").on("focus", function() {
	let ticketType = $(".selected--type").text();

	if (ticketType.match('왕복')) {
		$(".datepicker--div--type1").show();
	} else if (ticketType.match('편도')) {
		$(".datepicker--div--type2").show();
	}
});

// 자동 완성 항목 클릭하면 input에 value 들어감
function insertAutoComplete(i, target) {
	let liValue = $(`.${target}--li`).eq(i).text();
	$(`#${target}`).val(liValue);
	$(`#${target}Airport`).hide();
}

// 취항지 클릭하면 input에 value 들어감
function insertAirport(i, target) {
	let liValue = $(`.${target}--airport--li`).eq(i).text();
	$(`#${target}`).val(liValue);
	$('.all--airport--modal').modal('hide');
}

$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});

$(function() {
	$('.datepicker').datepicker();
})

// 가는 날을 선택하지 않았다면 오는 날 선택 불가능
$(".flight--date2").on("change", function() {

	if ($(".flight--date1").val() == "") {
		alert("가는 날을 먼저 선택해주세요.");
		$(".flight--date1").focus();
		$(".flight--date2").val("");
		return;
	} else {

		// 현재 날짜보다 이전 날짜를 선택했다면
		if (getCurrentDate() > $(".flight--date2").val()) {
			alert("현재 날짜보다 이전 날짜는 선택할 수 없습니다.");
			$(".flight--date2").focus();
			$(".flight--date2").val("");
			return;

			// 가는 날 이전 날짜를 선택했다면
		} else if ($(".flight--date1").val() > $(".flight--date2").val()) {
			alert("가는 날 이후 날짜를 선택해주세요.");
			$(".flight--date2").focus();
			$(".flight--date2").val("");
			return;
		}
		insertDatepicker(1);
		$(".datepicker--div--type1").hide();
	}
});

// 오는 날 이후 날짜를 선택했다면
$(".flight--date1").on("change", function() {
	// 현재 날짜보다 이전 날짜를 선택했다면
	if (getCurrentDate() > $(".flight--date1").val()) {
		alert("현재 날짜보다 이전 날짜는 선택할 수 없습니다.");
		$(".flight--date1").focus();
		$(".flight--date1").val("");
		return;

		// 가는 날 이전 날짜를 선택했다면
	} else if ($(".flight--date2").val() != "" && $(".flight--date1").val() > $(".flight--date2").val()) {
		alert("오는 날 이전 날짜를 선택해주세요.");
		$(".flight--date1").focus();
		$(".flight--date1").val("");
		return;
	}
	insertDatepicker(1);
	$("#flightDate").addClass("flight--date--inserted");
});

// 편도
$(".flight--date").on("change", function() {

	// 현재 날짜보다 이전 날짜를 선택했다면
	if (getCurrentDate() > $(".flight--date").val()) {
		alert("현재 날짜보다 이전 날짜는 선택할 수 없습니다.");
		$(".flight--date").focus();
		$(".flight--date").val("");
		return;
	}

	insertDatepicker(2);
	$(".datepicker--div--type2").hide();
	$("#flightDate").addClass("flight--date--inserted");
});

function insertDatepicker(type) {
	// 왕복
	if (type == 1) {
		var dateValue1 = $(".flight--date1").val();
		var dateValue2 = $(".flight--date2").val();
		$("#flightDate").val(dateValue1 + " ~ " + dateValue2);

		// 편도
	} else if (type == 2) {
		var dateValue = $(".flight--date").val();
		$("#flightDate").val(dateValue);

	}
}


// 전체 공항 조회 버튼
$(".all--airport").on("click", function() {
	$(".all--airport--modal").modal();
	if ($(this).is(".destination--button")) {
		$(".all--airport--modal").addClass("dest");
		$(".all--airport--modal").removeClass("depa");
		$(".modal--title").text("도착지 선택");
		$("#destinationAirport").hide();
	} else if ($(this).is(".departure--button")) {
		$(".all--airport--modal").addClass("depa");
		$(".all--airport--modal").removeClass("dest");
		$(".modal--title").text("출발지 선택");
		$("#departureAirport").hide();
	}
});

// 나이 계산기 버튼
$(".age--calculater").on("click", function() {
	$('.age--calculater--modal').modal();
	$(".datepicker--div--type1").hide();
	$(".datepicker--div--type2").hide();
})

// 나이 계산기 thisDate birthDate
$("#calculateBtn").on("click", function() {
	// 날짜가 입력되지 않았다면
	if ($("#birthDate").val() == "" || $("#thisDate").val() == "") {
		$("#calculaterResult").text("날짜가 입력되지 않았습니다.");
		return;
	}
	
	// 날짜 형식으로 변환
	let birthDate = stringToDate($("#birthDate").val());
	let thisDate = stringToDate($("#thisDate").val());
	
	if (birthDate == "error" || thisDate == "error") {
		$("#calculaterResult").text("유효하지 않은 날짜입니다.");
		return;
		
	// 유효한 날짜 형식이라면 나이 계산
	} else {
		let bTime = birthDate.getTime();
		let tTime = thisDate.getTime();
		let timeDiff = tTime - bTime;
		
		if (timeDiff < 0) {
			$("#calculaterResult").text("입력된 생년월일이 탑승일 이후입니다.");
			return;
		}
		
		let age = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 365));
		console.log(age + "살");
		let result;
		
		if (age < 2) {
			result = "유아";
		} else if (age < 12) {
			result = "소아";
		} else {
			result = "성인";
		}
		let thisDateStr = $("#thisDate").val();
		$("#calculaterResult").html(`탑승일 <span>(${thisDateStr})</span> 기준으로 <span>${result}</span>입니다.`);
			
	}
});

// 날짜로 변환
function stringToDate(str) {
	let arr = str.split("-");
	if (arr.length != 3) {
		return "error";
	}
	let year = arr[0];
	let month = arr[1];
	let day = arr[2];

	if (month == 2) {
		if (day == 29) {
			if (year % 4 != 0 || year % 100 == 0 && year % 400 != 0) {
				return "error";
			}
		}
		else if (day > 28) {
			return "error";
		}
	} else if (month == 4 || month == 6 || month == 9 || month == 11) {
		if (day > 30) {
			return "error";
		}
	} else if (month > 12) {
		return "error";	
	} else {
		if (day > 31) {
			return "error";
		}
	}
	return new Date(year, month-1, day);
}
