let noneResult = $("<li>검색 결과가 존재하지 않습니다.</li>");
let noneResultP = $(`<p class="none--result">해당하는 운항 스케줄이 존재하지 않습니다.</p>`);
	
// 키가 입력될 때마다 자동완성 불러오기
$("#departure").on("keyup focus change", function() {	
	// 만약 창이 숨겨진 상태라면
	if ($("#departureAirport").is(":hidden")) {
		$("#departureAirport").show();
		$(".datepicker--div--type1, .datepicker--div--type2").hide();
	}

	// 공백 입력 금지	
	let searchName = $("#departure").val().replaceAll(" ", "");
	$("#departure").val(searchName);

	// 공백일 때는 자동 완성 미작동
	if (searchName == "") {
		$("#departureList").empty();
		return;
		// 주소에 \가 들어가면 오류나서 막음
	} else if (searchName.indexOf("\\") != -1) {
		$("#departureList").html(noneResult);
		return;
	}

	$.ajax({
		type: "GET",
		url: `/airport/search?name=${searchName}`,

	}).done((res) => {
		$("#departureList").empty();

		if (res.length == 0) {
			$("#departureList").append(noneResult);
		} else {
			for (let i = 0; i < res.length; i++) {
				var el = $(`<li onclick="insertAutoComplete(${i}, 'departure');" class="departure--li">${res[i].name}</li>`);
				$("#departureList").append(el);
			}
		}
	}).fail((error) => {
		console.log(error);
	});
});

// 키가 입력될 때마다 자동완성 불러오기
$("#destination").on("keyup focus", function() {
	// 만약 창이 숨겨진 상태라면
	if ($("#destinationAirport").is(":hidden")) {
		$("#destinationAirport").show();
		$(".datepicker--div--type1, .datepicker--div--type2").hide();
	}

	// 공백 입력 금지	
	let searchName = $("#destination").val().replaceAll(" ", "");
	$("#destination").val(searchName);

	// 공백일 때는 자동 완성 미작동
	if (searchName == "") {
		$("#destinationList").empty();
		return;
		// 주소에 \가 들어가면 오류나서 막음
	} else if (searchName.indexOf("\\") != -1) {
		$("#destinationList").html(noneResult);
		return;
	}

	$.ajax({
		type: "GET",
		url: `/airport/search?name=${searchName}`,

	}).done((res) => {
		$("#destinationList").empty();

		if (res.length == 0) {
			$("#destinationList").append(noneResult);
		} else {
			for (var i = 0; i < res.length; i++) {
				var el = $(`<li onclick="insertAutoComplete(${i}, 'destination');" class="destination--li">${res[i].name}</li>`);
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

	}).done((res) => {
		$(".airport--ul").empty();

		if ($(".all--airport--modal").is(".depa")) {
			for (var i = 0; i < res.length; i++) {
				var el = $(`<li onclick="insertAirport(${i}, 'departure');" class="departure--airport--li">${res[i].name}</li>`);
				$(".airport--ul").append(el);
			}
		} else if ($(".all--airport--modal").is(".dest")) {
			for (var i = 0; i < res.length; i++) {
				var el = $(`<li onclick="insertAirport(${i}, 'destination');" class="destination--airport--li">${res[i].name}</li>`);
				$(".airport--ul").append(el);
			}
		}

	}).fail((error) => {
		console.log(error);
	});
});

// input에 포커스를 두면 해당하는 팝업 보이게
$("#departure").on("focus", function() {
	$("#departureAirport").show();
	$(".datepicker--div--type1, .datepicker--div--type2").hide();
});

$("#destination").on("focus", function() {
	$("#destinationAirport").show();
	$(".datepicker--div--type1, .datepicker--div--type2").hide();
});

$("#passenger").on("click", function() {
	$("#ageTypeDiv").css("display", "flex");
	$(".datepicker--div--type1, .datepicker--div--type2").hide();
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

// 전체 공항 조회 버튼
$(".all--airport").on("click", function() {
	$(".airport--ul").empty();
	$(".region--li").removeClass("region--li--selected");

	$(".all--airport--modal").modal();
	if ($(this).is(".destination--button")) {
		$(".all--airport--modal").addClass("dest");
		$(".all--airport--modal").removeClass("depa");
		$(".all--airport--modal .modal--title").text("도착지 선택");
		$("#destinationAirport").hide();
	} else if ($(this).is(".departure--button")) {
		$(".all--airport--modal").addClass("depa");
		$(".all--airport--modal").removeClass("dest");
		$(".all--airport--modal .modal--title").text("출발지 선택");
		$("#departureAirport").hide();
	}
});

$(".flight--date2").on("change", function() {

	// 가는 날을 선택하지 않았다면 오는 날 선택 불가능
	if ($(".flight--date1").val() == "") {
		alert("가는 날을 먼저 선택해주세요.");
		$(".flight--date1").focus();
		$(".flight--date2").val("");
		insertDatepicker(1);
		return;
		
	} else {

		// 가는 날 이전 날짜를 선택했다면
		if ($(".flight--date1").val() > $(".flight--date2").val()) {
			alert("가는 날 이후 날짜를 선택해주세요.");
			$(".flight--date2").focus();
			$(".flight--date2").val("");
			insertDatepicker(1);
			return;
		}
		insertDatepicker(1);
		$(".datepicker--div--type1").hide();
		$("#flightDate").addClass("flight--date--inserted");
	}
});

$(".flight--date1").on("change", function() {

	// 오는 날 이후 날짜를 선택했다면
	if ($(".flight--date2").val() != "" && $(".flight--date1").val() > $(".flight--date2").val()) {
		$(".flight--date2").val("");
		insertDatepicker(1);
		return;
	}
	insertDatepicker(1);
	$("#flightDate").addClass("flight--date--inserted");
});

// 편도
$(".flight--date").on("change", function() {

	insertDatepicker(2);
	$(".datepicker--div--type2").hide();
	$("#flightDate").addClass("flight--date--inserted");
});

// 나이 계산기 버튼
$(".age--calculater").on("click", function() {
	$("#calculaterResult").text("생년월일과 탑승일을 입력해주세요.");
	$('.age--calculater--modal').modal();
	$(".datepicker--div--type1, .datepicker--div--type2").hide();
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
		let result = calculateAgeType(birthDate, thisDate);

		let thisDateStr = $("#thisDate").val();
		$("#calculaterResult").html(`탑승일 <span>(${thisDateStr})</span> 기준으로 <span>${result}</span>입니다.`);

	}
});

$("#selectSeatBtn").on("click", function() {
	
	// 성인이 아니면 예매 불가능
	if (memberAgeType != '성인') {
		alert("만 12세 이상의 성인만 항공권 예매가 가능합니다.");
		location.href="/";
		return false;
	}
	
	let list = $(`.schedule--list--div input[type="radio"]`);
	// 왕복 편도 여부 확인 (2 : 왕복, 1 : 편도)
	let type = 0;
	for (let j = 0; j < 2; j++) {
		if ($(".schedule--list--div").eq(j).is(":visible")) {
			type++;
		}
	}
	
	// 라디오버튼 체크 개수 확인
	let checkCount = 0;
	for (let i = 0; i < list.length; i++) {
		if (list.eq(i).is(":checked")) {
			checkCount++;
		}	
	}		

	// 선택되지 않은 일정이 있다면 submit하지 않음
	if (type != checkCount) {
		alert("선택되지 않은 일정이 존재합니다.");
		return false;
	}
	
	// 왕복일 때, 첫 번째 여정과 두 번째 여정의 운항시간이 겹치지 않는지 확인
	if (type == 2) {
		
		let sch1Id = $("input[name=\"schedule1\"]:checked").val().split("_")[1];
		console.log(sch1Id);
		let sch2Id = $("input[name=\"schedule2\"]:checked").val().split("_")[1];
		console.log(sch2Id);
		
		let data = {
			scheduleId1: sch1Id,
			scheduleId2: sch2Id
		};
		
		let result = true;
		
		$.ajax({
			type: 'POST',
			url: '/ticket/checkDate',
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(data),
			dataType: 'json',
			async: false   // 이거 해주니까 ajax 기다렸다가 아래에 return result 실행
		})
		.done((res) => {
			// 일정 선택에 문제가 있다면
			if (res.code == -1) {
				alert(res.message);
				result = false;
			}
		})
		.fail((error) => {
			console.log(error);
		});
		
		return result;			
	}
	
});

// 인원 수 감소 버튼
$(".minus--button").on("click", function() {
	var currentNumber = $(this).next().val();
	$(".datepicker--div--type1, .datepicker--div--type2").hide();

	if (currentNumber > 0) {

		// 성인 수 감소 버튼일 때
		if ($(this).next().is("#ageType1")) {
			// 성인 수가 1이라면 감소 불가능
			if ($("#ageType1").val() == 1) {
				alert("최소 1명의 성인이 필요합니다.");
				return;
				// 성인 수가 유아 수와 같다면 감소 불가능
			} else if ($("#ageType3").val() == $("#ageType1").val()) {
				alert('유아의 수는 동반 성인의 수보다 많을 수 없습니다.');
				return;
			}
		}
		$(this).next().val(currentNumber - 1);
	}
});

// 인원 수 증가 버튼
$(".plus--button").on("click", function() {
	var currentNumber = $(this).prev().val();
	$(".datepicker--div--type1, .datepicker--div--type2").hide();
	// 유아 수 증가 버튼일 때 유아 수가 성인 수와 같다면 증가 불가능
	if ($(this).prev().is("#ageType3") && $("#ageType3").val() == $("#ageType1").val()) {
		alert('유아의 수는 동반 성인의 수보다 많을 수 없습니다.');
		return;
	}
	$(this).prev().val(parseInt(currentNumber) + 1);
});

// 스케줄 조회
$("#selectScheduleBtn").on("click", function() {
	$(".error--prevent").remove();
	$(".none--result").remove();
	// 1 : 왕복, 2 : 편도
	let ticketType = $(".selected--type").index() + 1;
	// 취항지 1
	let airport1 = $("#departure").val();
	if (airport1 == "") {
		alert("출발지가 선택되지 않았습니다.");
		return;
	}

	// 취항지 2
	let airport2 = $("#destination").val();
	if (airport2 == "") {
		alert("도착지가 선택되지 않았습니다.");
		return;
	}

	// 성인
	let ageType1 = parseInt($("#ageType1").val());
	if (ageType1 == 0) {
		alert("최소 1명의 성인이 필요합니다.");
		return;
	}
	// 소아
	let ageType2 = parseInt($("#ageType2").val());
	let passengerCount = ageType1 + ageType2;

	// 유아
	let ageType3 = parseInt($("#ageType3").val());
	if (ageType3 > ageType1) {
		alert('유아의 수는 동반 성인의 수보다 많을 수 없습니다.');
		return;
	}

	// 왕복
	if (ticketType == 1) {
		// 왕복 - 탑승일 1 (가는 날)
		let flightDate1 = $("#flightDate1").val();
		// 왕복 - 탑승일 2 (오는 날)
		let flightDate2 = $("#flightDate2").val();

		// 선택하지 않은 날짜가 있다면
		if (flightDate1 == "" || flightDate2 == "") {
			alert("선택되지 않은 날짜가 존재합니다.");
			return;
		}

		let data = {
			airport1: airport1,
			airport2: airport2,
			flightDate1: stringToDate(flightDate1),
			flightDate2: stringToDate(flightDate2)
		};

		$.ajax({
			type: "POST",
			url: `/ticket/flightSchedule/1`,
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(data),
			dataType: 'json'

		}).done((res) => {
			
			$("#scheduleList1 h6 span").eq(1).text("첫 번째 여정");
			$("#scheduleList2 h6 span").eq(1).text("두 번째 여정");
			$("#scheduleList1 h3 span").eq(0).text(airport1);
			$("#scheduleList1 h3 span").eq(2).text(airport2);
			$("#scheduleList2 h3 span").eq(0).text(airport2);
			$("#scheduleList2 h3 span").eq(2).text(airport1);
			
			if (res.length == 0) {
				$("main .size--limit--div").append(noneResultP);
				$("#scheduleList1, #scheduleList2").hide();
				$("#selectSeatBtnDiv").hide();
				return;
			}
			
			$("#scheduleList1, #scheduleList2").css("display", "flex");
			$("#selectSeatBtnDiv").show();
			$("#scheduleList1 tbody, #scheduleList2 tbody").empty();

			for (let i = 0; i < res.length; i++) {
				let tr = $("<tr>");
				let td1 = $("<td class=\"td--flight--time\">");
				let td1Ul = $("<ul class=\"ul--flight--time\">");
				let td1Li2 = $("<li>");
				let td1Div = $("<div class=\"d-flex flex-column align-item-center\">");
				let td1DivDiv = $("<div>");
				let td1DivDivUl = $("<ul>");
				td1DivDivUl.append(`<li><span class="material-symbols-outlined">schedule</span>`);
				let td2 = $("<td class=\"td--airplane--name\">");
				let td3 = $("<td class=\"td--economy td--seat\">");
				let td4 = $("<td class=\"td--business td--seat\">");
				let td5 = $("<td class=\"td--first td--seat\">");
				
				// 첫 번째 여정
				if (res[i].departureAirport == airport1) {
					td1Ul.append(`<li>${res[i].strDepartureDate}</li>`);
					td1DivDivUl.append(`<li>${res[i].flightTime}</li>`);
					td1DivDiv.append(td1DivDivUl);
					td1Div.append(td1DivDiv);
					td1Div.append(`<img src="/images/ticket/arrow.png">`);
					td1Li2.append(td1Div);
					td1Ul.append(td1Li2);
					td1Ul.append(`<li>${res[i].strArrivalDate}</li>`);
					td1.append(td1Ul);
					td2.text(res[i].airplaneName);
					
					// 좌석이 존재하지 않는다면 '미운영'으로 표시
					if (res[i].ecTotalCount == 0) {
						td3.text("미운영");
						td3.addClass("td--none--seat");
					} else {
						// 잔여 좌석 수가 없다면 '매진'으로 표시
						if (res[i].ecCurCount == 0) {
							td3.text("매진");
							td3.addClass("td--none--seat");
						} else {
							td3.append(seatNode1(1, "이코노미", i, res, ageType1, ageType2, ageType3));
							td3.append(seatNode2(1, "이코노미", i, new Intl.NumberFormat('en-US').format(res[i].ecPrice), res[i].ecCurCount));
						}
					}
					
					// 좌석이 존재하지 않는다면 '미운영'으로 표시
					if (res[i].buTotalCount == 0) {
						td4.text("미운영");
						td4.addClass("td--none--seat");
						
					} else {
						// 잔여 좌석 수가 없다면 '매진'으로 표시
						if (res[i].buCurCount == 0) {
							td4.text("매진");
							td4.addClass("td--none--seat");
						} else {
							td4.append(seatNode1(1, "비즈니스", i, res, ageType1, ageType2, ageType3));
							td4.append(seatNode2(1, "비즈니스", i, new Intl.NumberFormat('en-US').format(res[i].buPrice), res[i].buCurCount));
						}
					}
					
					// 좌석이 존재하지 않는다면 '미운영'으로 표시
					if (res[i].fiTotalCount == 0) {
						td5.text("미운영");
						td5.addClass("td--none--seat");
					} else {
						// 잔여 좌석 수가 없다면 '매진'으로 표시
						if (res[i].fiCurCount == 0) {
							td5.text("매진");
							td5.addClass("td--none--seat");
						} else {
							td5.append(seatNode1(1, "퍼스트", i, res, ageType1, ageType2, ageType3));
							td5.append(seatNode2(1, "퍼스트", i, new Intl.NumberFormat('en-US').format(res[i].fiPrice), res[i].fiCurCount));
						}
					}
					tr.append(td1).append(td2).append(td3).append(td4).append(td5);
					$("#scheduleList1 tbody").append(tr);

					for (let i = 0; i < res.length; i++) {
						// 좌석 수 확인해서 5석 이하라면 빨간색으로 표시
						if (res[i].ecCurCount <= 5) {
							$(`#scheduleList1Ec${i}`).next().next().children().eq(3).css("color", "#ce2424");
						}
						if (res[i].buCurCount <= 5) {
							$(`#scheduleList1Bu${i}`).next().next().children().eq(3).css("color", "#ce2424");
						}
						if (res[i].fiCurCount <= 5) {
							$(`#scheduleList1Fi${i}`).next().next().children().eq(3).css("color", "#ce2424");
						}
						// 신청 인원 수보다 좌석 수가 적다면 라디오 버튼을 비활성화함 (유아는 좌석을 차지하지 않음)
						if (res[i].ecCurCount < passengerCount) {
							$(`#scheduleList1Ec${i}`).prop("disabled", true);
							$(`#scheduleList1Ec${i}`).parent().children().addClass("td--disabled--seat");
						}
						if (res[i].buCurCount < passengerCount) {
							$(`#scheduleList1Bu${i}`).prop("disabled", true);
							$(`#scheduleList1Bu${i}`).parent().children().addClass("td--disabled--seat");
						}
						if (res[i].fiCurCount < passengerCount) {
							$(`#scheduleList1Fi${i}`).prop("disabled", true);
							$(`#scheduleList1Fi${i}`).parent().children().addClass("td--disabled--seat");
						}
					}

					// 두 번째 여정
				} else {
					td1Ul.append(`<li>${res[i].strDepartureDate}</li>`);
					td1DivDivUl.append(`<li>${res[i].flightTime}</li>`);
					td1DivDiv.append(td1DivDivUl);
					td1Div.append(td1DivDiv);
					td1Div.append(`<img src="/images/ticket/arrow.png">`);
					td1Li2.append(td1Div);
					td1Ul.append(td1Li2);
					td1Ul.append(`<li>${res[i].strArrivalDate}</li>`);
					td1.append(td1Ul);
					td2.text(res[i].airplaneName);

					// 좌석이 존재하지 않는다면 '미운영'으로 표시
					if (res[i].ecTotalCount == 0) {
						td3.text("미운영");
						td3.addClass("td--none--seat");
					} else {
						// 잔여 좌석 수가 없다면 '매진'으로 표시
						if (res[i].ecCurCount == 0) {
							td3.text("매진");
							td3.addClass("td--none--seat");
						} else {
							td3.append(seatNode1(2, "이코노미", i, res, ageType1, ageType2, ageType3));
							td3.append(seatNode2(2, "이코노미", i, new Intl.NumberFormat('en-US').format(res[i].ecPrice), res[i].ecCurCount));
						}
					}
					// 좌석이 존재하지 않는다면 '미운영'으로 표시
					if (res[i].buTotalCount == 0) {
						td4.text("미운영");
						td4.addClass("td--none--seat");
					} else {
						// 잔여 좌석 수가 없다면 '매진'으로 표시
						if (res[i].buCurCount == 0) {
							td4.text("매진");
							td4.addClass("td--none--seat");
						} else {
							td4.append(seatNode1(2, "비즈니스", i, res, ageType1, ageType2, ageType3));
							td4.append(seatNode2(2, "비즈니스", i, new Intl.NumberFormat('en-US').format(res[i].buPrice), res[i].buCurCount));
						}
					}
					// 좌석이 존재하지 않는다면 '미운영'으로 표시
					if (res[i].fiTotalCount == 0) {
						td5.text("미운영");
						td5.addClass("td--none--seat");
					} else {
						// 잔여 좌석 수가 없다면 '매진'으로 표시
						if (res[i].fiCurCount == 0) {
							td5.text("매진");
							td5.addClass("td--none--seat");
						} else {
							td5.append(seatNode1(2, "퍼스트", i, res, ageType1, ageType2, ageType3));
							td5.append(seatNode2(2, "퍼스트", i, new Intl.NumberFormat('en-US').format(res[i].fiPrice), res[i].fiCurCount));
						}
					}
					tr.append(td1).append(td2).append(td3).append(td4).append(td5);
					$("#scheduleList2 tbody").append(tr);

					for (let i = 0; i < res.length; i++) {
						// 좌석 수 확인해서 5석 이하라면 빨간색으로 표시
						if (res[i].ecCurCount <= 5) {
							$(`#scheduleList2Ec${i}`).next().next().children().eq(3).css("color", "#ce2424");
						}
						if (res[i].buCurCount <= 5) {
							$(`#scheduleList2Bu${i}`).next().next().children().eq(3).css("color", "#ce2424");
						}
						if (res[i].fiCurCount <= 5) {
							$(`#scheduleList2Fi${i}`).next().next().children().eq(3).css("color", "#ce2424");
						}
						// 신청 인원 수보다 좌석 수가 적다면 라디오 버튼을 비활성화함 (유아는 좌석을 차지하지 않음)
						if (res[i].ecCurCount < passengerCount) {
							$(`#scheduleList2Ec${i}`).prop("disabled", true);
							$(`#scheduleList2Ec${i}`).parent().children().addClass("td--disabled--seat");
						}
						if (res[i].buCurCount < passengerCount) {
							$(`#scheduleList2Bu${i}`).prop("disabled", true);
							$(`#scheduleList2Bu${i}`).parent().children().addClass("td--disabled--seat");
						}
						if (res[i].fiCurCount < passengerCount) {
							$(`#scheduleList2Fi${i}`).prop("disabled", true);
							$(`#scheduleList2Fi${i}`).parent().children().addClass("td--disabled--seat");
						}
					}
				}
			}
			// 선택된 셀의 배경 색 변경
			$(".schedule--list--div input[type='radio']").on("change", function() {
				let divId = "scheduleList" + $(this).val().charAt(0);
				$(`#${divId} .td--seat`).css("background-color", "white");
				$(this).parent().css("background-color", "#F8FCFD");
			});
			
			if (manager == 0) {
				window.scrollTo(0, 880);				
			}

		}).fail((error) => {
			console.log(error);
		});

		// 편도
	} else {
		// 탑승일
		let flightDate = $("#flightDate0").val();
		// 선택하지 않은 날짜가 있다면
		if (flightDate == "") {
			alert("선택되지 않은 날짜가 존재합니다.");
			return;
		}

		let data = {
			airport1: airport1,
			airport2: airport2,
			flightDate1: stringToDate(flightDate)
		};

		$.ajax({
			type: "POST",
			url: `/ticket/flightSchedule/2`,
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(data),
			dataType: 'json'

		}).done((res) => {
			
			$("#scheduleList1 h6 span").eq(1).text("편도");
			$("#scheduleList1 h3 span").eq(0).text(airport1);
			$("#scheduleList1 h3 span").eq(2).text(airport2);
			
			if (res.length == 0) {
				$("main .size--limit--div").append(noneResultP);
				$("#scheduleList1, #scheduleList2").hide();
				$("#selectSeatBtnDiv").hide();
				return;
			}
			
			$("#scheduleList1").css("display", "flex");
			$("#scheduleList2").hide();
			$("#selectSeatBtnDiv").show();
			$("#scheduleList1 tbody").empty();
			$("#scheduleList2 tbody").empty();

			for (let i = 0; i < res.length; i++) {
				let tr = $("<tr>");
				let td1 = $("<td class=\"td--flight--time\">");
				let td1Ul = $("<ul class=\"ul--flight--time\">");
				let td1Li2 = $("<li>");
				let td1Div = $("<div class=\"d-flex flex-column align-item-center\">");
				let td1DivDiv = $("<div>");
				let td1DivDivUl = $("<ul>");
				td1DivDivUl.append(`<li><span class="material-symbols-outlined">schedule</span>`);
				let td2 = $("<td class=\"td--airplane--name\">");
				let td3 = $("<td class=\"td--economy td--seat\">");
				let td4 = $("<td class=\"td--business td--seat\">");
				let td5 = $("<td class=\"td--first td--seat\">");

				td1Ul.append(`<li>${res[i].strDepartureDate}</li>`);
				td1DivDivUl.append(`<li>${res[i].flightTime}</li>`);
				td1DivDiv.append(td1DivDivUl);
				td1Div.append(td1DivDiv);
				td1Div.append(`<img src="/images/ticket/arrow.png">`);
				td1Li2.append(td1Div);
				td1Ul.append(td1Li2);
				td1Ul.append(`<li>${res[i].strArrivalDate}</li>`);
				td1.append(td1Ul);
				td2.text(res[i].airplaneName);
				
				// 좌석이 존재하지 않는다면 '미운영'으로 표시
				if (res[i].ecTotalCount == 0) {
					td3.text("미운영");
					td3.addClass("td--none--seat");
				} else {
					// 잔여 좌석 수가 없다면 '매진'으로 표시
					if (res[i].ecCurCount == 0) {
						td3.text("매진");
						td3.addClass("td--none--seat");
					} else {
						td3.append(seatNode1(1, "이코노미", i, res, ageType1, ageType2, ageType3));
						td3.append(seatNode2(1, "이코노미", i, new Intl.NumberFormat('en-US').format(res[i].ecPrice), res[i].ecCurCount));
					}
				}
				// 좌석이 존재하지 않는다면 '미운영'으로 표시
				if (res[i].buTotalCount == 0) {
					td4.text("미운영");
					td4.addClass("td--none--seat");
				} else {
					// 잔여 좌석 수가 없다면 '매진'으로 표시
					if (res[i].buCurCount == 0) {
						td4.text("매진");
						td4.addClass("td--none--seat");
					} else {
						td4.append(seatNode1(1, "비즈니스", i, res, ageType1, ageType2, ageType3));
						td4.append(seatNode2(1, "비즈니스", i, new Intl.NumberFormat('en-US').format(res[i].buPrice), res[i].buCurCount));
					}
				}
				// 좌석이 존재하지 않는다면 '미운영'으로 표시
				if (res[i].fiTotalCount == 0) {
					td5.text("미운영");
					td5.addClass("td--none--seat");
				} else {
					// 잔여 좌석 수가 없다면 '매진'으로 표시
					if (res[i].fiCurCount == 0) {
						td5.text("매진");
						td5.addClass("td--none--seat");
					} else {
						td5.append(seatNode1(1, "퍼스트", i, res, ageType1, ageType2, ageType3));
						td5.append(seatNode2(1, "퍼스트", i, new Intl.NumberFormat('en-US').format(res[i].fiPrice), res[i].fiCurCount));
					}
				}
				tr.append(td1).append(td2).append(td3).append(td4).append(td5);
				$("#scheduleList1 tbody").append(tr);

				for (let i = 0; i < res.length; i++) {
					// 좌석 수 확인해서 5석 이하라면 빨간색으로 표시
					if (res[i].ecCurCount <= 5) {
						$(`#scheduleList1Ec${i}`).next().next().children().eq(3).css("color", "#ce2424");
					}
					if (res[i].buCurCount <= 5) {
						$(`#scheduleList1Bu${i}`).next().next().children().eq(3).css("color", "#ce2424");
					}
					if (res[i].fiCurCount <= 5) {
						$(`#scheduleList1Fi${i}`).next().next().children().eq(3).css("color", "#ce2424");
					}
					// 신청 인원 수보다 좌석 수가 적다면 라디오 버튼을 비활성화함 (유아는 좌석을 차지하지 않음)
					if (res[i].ecCurCount < passengerCount) {
						$(`#scheduleList1Ec${i}`).prop("disabled", true);
						$(`#scheduleList1Ec${i}`).parent().children().addClass("td--disabled--seat");
					}
					if (res[i].buCurCount < passengerCount) {
						$(`#scheduleList1Bu${i}`).prop("disabled", true);
						$(`#scheduleList1Bu${i}`).parent().children().addClass("td--disabled--seat");
					}
					if (res[i].fiCurCount < passengerCount) {
						$(`#scheduleList1Fi${i}`).prop("disabled", true);
						$(`#scheduleList1Fi${i}`).parent().children().addClass("td--disabled--seat");
					}
				}
			}
			// 선택된 셀의 배경 색 변경
			$(".schedule--list--div input[type='radio']").on("change", function() {
				let divId = "scheduleList" + $(this).val().charAt(0);
				$(`#${divId} .td--seat`).css("background-color", "white");
				$(this).parent().css("background-color", "#F8FCFD");
			});
			// 에러 방지용
			$("#scheduleList1").append(`<input type="hidden" name="schedule2" value="0" class="error--prevent">`);
			
			if (manager == 0) {
				window.scrollTo(0, 880);				
			}
	
		}).fail((error) => {
			console.log(error);
		});
	}
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
	}

});

function selectedType(i) {
	// 이미 선택되어 있다면
	if ($(`#ticketType${i}`).hasClass("selected--type")) {
		return;
		// 선택되어 있지 않다면
	} else if ($(`#ticket--type${i}`).hasClass("selected--type") == false) {
		$(`#ticketType${i}`).addClass("selected--type");
		$(`#ticketType${i}`).siblings().removeClass("selected--type");
		// 첫 탑승일은 넘김

		// 왕복이라면
		if (i == 1) {
			let dateVal = $(".flight--date").val();
			$(".flight--date1").val(dateVal);
			$(".flight--date").val("");
			$("#flightDate").attr("placeholder", "가는 날 ~ 오는 날");
			if (dateVal == "") {
				$("#flightDate").val("");			
			} else {
				$("#flightDate").val(dateVal + " ~ ");			
			}
		} else {
			let dateVal = $(".flight--date1").val();
			$(".flight--date").val(dateVal);
			$(".flight--date1").val("");
			$("#flightDate").val(dateVal);
			$("#flightDate").attr("placeholder", "가는 날");
		}
		$(".flight--date2").val("");
		$(".datepicker--div--type1, .datepicker--div--type2").hide();
	}
}

// 출발지 도착지 스왑
function airportSwap() {
	let departureName = $("#departure").val();
	let destinationName = $("#destination").val();
	$("#destination").val(departureName);
	$("#departure").val(destinationName);
}

// 자동 완성 항목 클릭하면 input에 value 들어감
function insertAutoComplete(i, target) {
	let liValue = $(`.${target}--li`).eq(i).text();

	// 반대 취항지에 존재하는 값이면 들어가지 못하게 함
	if (target == "departure") {
		if ($("#destination").val() == liValue) {
			alert("도착지와 동일한 취항지입니다.");
			return;
		}
	} else {
		if ($("#departure").val() == liValue) {
			alert("출발지와 동일한 취항지입니다.");
			return;
		}
	}

	$(`#${target}`).val(liValue);
	$(`#${target}Airport`).hide();
}


// 취항지 클릭하면 input에 value 들어감
function insertAirport(i, target) {
	let liValue = $(`.${target}--airport--li`).eq(i).text();

	// 반대 취항지에 존재하는 값이면 들어가지 못하게 함
	if (target == "departure") {
		if ($("#destination").val() == liValue) {
			alert("도착지와 동일한 취항지입니다.");
			return;
		}
	} else {
		if ($("#departure").val() == liValue) {
			alert("출발지와 동일한 취항지입니다.");
			return;
		}
	}

	$(`#${target}`).val(liValue);
	$('.all--airport--modal').modal('hide');
}

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

function insertPassenger() {
	let passenger = "성인" + $("input[id=\"ageType1\"]").val();
	
	let type2 = $("input[id=\"ageType2\"]").val();
	let type3 = $("input[id=\"ageType3\"]").val();
	
	if (type2 != 0) {
		passenger = passenger + "  소아" + type2;
	}
	
	if (type3 != 0) {
		passenger = passenger + "  유아" + type3;
	} 
	$("input[id=\"passenger\"]").val(passenger);
}

// 날짜 차이 계산해서 연 단위로 환산해서 성인/소아/유아 구분
function calculateAgeType (date1, date2) {
	let bTime = date1.getTime();
	let tTime = date2.getTime();
	let timeDiff = tTime - bTime;

	if (timeDiff < 0) {
		$("#calculaterResult").text("입력된 생년월일이 탑승일 이후입니다.");
		return;
	}

	let age = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 365));
	let result;

	if (age < 2) {
		result = "유아";
	} else if (age < 12) {
		result = "소아";
	} else {
		result = "성인";
	}
	return result;
}

// 하드코딩을 줄이기 위한 코드
function seatNode1(number, grade, i, res, ageType1, ageType2, ageType3) {
	let node;
	if (grade == "이코노미") {
		node = `<input type="radio" name="schedule${number}" id="scheduleList${number}Ec${i}" value="${number}_${res[i].id}_이코노미_${ageType1}_${ageType2}_${ageType3}"><br>`;
	} else if (grade == "비즈니스") {
		node = `<input type="radio" name="schedule${number}" id="scheduleList${number}Bu${i}" value="${number}_${res[i].id}_비즈니스_${ageType1}_${ageType2}_${ageType3}"><br>`;
	} else {
		node = `<input type="radio" name="schedule${number}" id="scheduleList${number}Fi${i}" value="${number}_${res[i].id}_퍼스트_${ageType1}_${ageType2}_${ageType3}"><br>`;
	}
	return node;
}

// 하드코딩을 줄이기 위한 코드
function seatNode2(number, grade, i, strPrice, curCount) {
	let node;
	if (grade == "이코노미") {
		node = `<label for="scheduleList${number}Ec${i}" id="scheduleList${number}EcLabel${i}"><span>KRW </span><span>${strPrice}</span><br><span>잔여 ${curCount}석</span></label>`;	
	} else if (grade == "비즈니스") {
		node = `<label for="scheduleList${number}Bu${i}" id="scheduleList${number}BuLabel${i}"><span>KRW </span><span>${strPrice}</span><br><span>잔여 ${curCount}석</span></label>`;	
	} else {
		node = `<label for="scheduleList${number}Fi${i}" id="scheduleList${number}FiLabel${i}"><span>KRW </span><span>${strPrice}</span><br><span>잔여 ${curCount}석</span></label>`;	
	}
	return node;
}

$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	minDate: '0',
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
});