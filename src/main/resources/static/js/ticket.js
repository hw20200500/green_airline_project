function selectedType(i) {
	// 이미 선택되어 있다면
	if ($(`#ticketType${i}`).hasClass("selected--type")) {
		return;
	// 선택되어 있지 않다면
	} else if ($(`#ticket--type${i}`).hasClass("selected--type") == false) {
		$(`#ticketType${i}`).addClass("selected--type");
		$(`#ticketType${i}`).siblings().removeClass("selected--type");
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
			for (let i = 0; i < res.length; i++){
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
			for (var i = 0; i < res.length; i++){
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
});
$("#destination").on("focus", function() {
	$("#destinationAirport").show();
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

// 좌석 선택
function selectSeat(type, seatName) {
	
	if (type == 'e') {
		// 선택
		if ($(`.economy--seat--${seatName}`).attr("src") == "/images/ticket/economy_not.png" && seatCount > 0) {
			$(`.economy--seat--${seatName}`).attr("src", "/images/ticket/economy_sel.png");
			seatCount --;
				
			$.ajax({
				type: 'GET',
				url: `/ticket/selectedSeatData?seatName=${seatName}&scheduleId=${scheduleId}`,
				contentType: 'application/json; charset=utf-8'
				
			}).done((res) => {
				showSeatInfo(seatName, res.seatGrade, res.seatPrice);
			}).fail((error) => {
				console.log(error);
			});
		
		// 선택 취소
		} else if ($(`.economy--seat--${seatName}`).attr("src") == "/images/ticket/economy_sel.png" && seatCount >= 0) {
			$(`.economy--seat--${seatName}`).attr("src", "/images/ticket/economy_not.png");
			seatCount ++;
			
			$(`#div${seatName}`).remove();
			
		}
		
	// 비즈니스 좌석이라면
	} else if (type == 'b') {
		
		// 선택 (r)
		if ($(`.business--seat--${seatName}`).attr("src") == "/images/ticket/business_r_not.png" && seatCount > 0) {
			$(`.business--seat--${seatName}`).attr("src", "/images/ticket/business_r_sel.png");
			seatCount --;
			
			$.ajax({
				type: 'GET',
				url: `/ticket/selectedSeatData?seatName=${seatName}&scheduleId=${scheduleId}`,
				contentType: 'application/json; charset=utf-8'
				
			}).done((res) => {
				showSeatInfo(seatName, res.seatGrade, res.seatPrice);
			}).fail((error) => {
				console.log(error);
			});
			
		// 선택 취소 (r)
		} else if ($(`.business--seat--${seatName}`).attr("src") == "/images/ticket/business_r_sel.png" && seatCount >= 0) {
			$(`.business--seat--${seatName}`).attr("src", "/images/ticket/business_r_not.png");
			seatCount ++;
			
			$(`#div${seatName}`).remove();
			
		// 선택 (l)
		} else if ($(`.business--seat--${seatName}`).attr("src") == "/images/ticket/business_l_not.png" && seatCount > 0) {
			$(`.business--seat--${seatName}`).attr("src", "/images/ticket/business_l_sel.png");
			seatCount --;
			
			$.ajax({
				type: 'GET',
				url: `/ticket/selectedSeatData?seatName=${seatName}&scheduleId=${scheduleId}`,
				contentType: 'application/json; charset=utf-8'
				
			}).done((res) => {
				showSeatInfo(seatName, res.seatGrade, res.seatPrice);
			}).fail((error) => {
				console.log(error);
			});
			
		// 선택 취소 (l)
		} else if ($(`.business--seat--${seatName}`).attr("src") == "/images/ticket/business_l_sel.png" && seatCount >= 0) {
			$(`.business--seat--${seatName}`).attr("src", "/images/ticket/business_l_not.png");
			seatCount ++;
			
			$(`#div${seatName}`).remove();
			
		}
	}
	
}

// 선택된 좌석 정보 보이게
function showSeatInfo(seatName, seatGrade, seatPrice) {
	let newDiv = $("<ul>");
	newDiv.attr("id", `div${seatName}`);
	newDiv.append(`<li>좌석번호 : ${seatName}</li>`);
	newDiv.append(`<li>좌석등급 : ${seatGrade}</li>`);
	newDiv.append(`<li>가격 : ${seatPrice}</li>`);
	newDiv.css("border", "1px solid #ccc");
	newDiv.css("padding", "10px");
	newDiv.css("border-radius", "5px");
	$(".seat--info").append(newDiv);
}

