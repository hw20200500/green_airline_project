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
