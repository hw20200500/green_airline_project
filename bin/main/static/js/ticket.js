function selectedType(i) {
	// 이미 선택되어 있다면
	if ($(`#ticket--type${i}`).hasClass("selected--type")) {
		return;
	// 선택되어 있지 않다면
	} else if ($(`#ticket--type${i}`).hasClass("selected--type") == false) {
		$(`#ticket--type${i}`).addClass("selected--type");
		$(`#ticket--type${i}`).siblings().removeClass("selected--type");
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
$("#departure").on("keyup", function() {
	// 양옆 공백은 무시하고 검색
	let searchName = $("#departure").val().trim();
	
	// 공백 제거 (공백만 입력했을 때는 자동 완성 미작동)
	if (searchName == "") {
		$("#departure--list").empty();
		return;
	// 주소에 \가 들어가면 오류나서 막음
	} else if (searchName.indexOf("\\") != -1) {
		$("#departure--list").empty();
		return;
	}
	
	$.ajax({
		type: "GET",
		url: `/airport/search?name=${searchName}`,
		contentType: 'application/json; charset=utf-8'
	}).done((res) => {
		console.log(res);
		$("#departure--list").empty();
		
		if (res.length == 0) {
			let el = $("<li>검색 결과가 존재하지 않습니다.</li>");
			$("#departure--list").append(el);
		} else {
			for (let i = 0; i < res.length; i++){
				let el = $("<li>");
				el.append(res[i].name);
				$("#departure--list").append(el);
			}
		}
		
	}).fail((error) => {
		console.log(error);
	});
});

// 키가 입력될 때마다 자동완성 불러오기
$("#destination").on("keyup", function() {
	// 양옆 공백은 무시하고 검색
	let searchName = $("#destination").val().trim();
	
	// 공백 제거 (공백만 입력했을 때는 자동 완성 미작동)
	if (searchName == "") {
		$("#destination--list").empty();
		return;
	// 주소에 \가 들어가면 오류나서 막음
	} else if (searchName.indexOf("\\") != -1) {
		$("#destination--list").empty();
		return;
	}
	
	$.ajax({
		type: "GET",
		url: `/airport/search?name=${searchName}`,
		contentType: 'application/json; charset=utf-8'
	}).done((res) => {
		$("#destination--list").empty();
		
		if (res.length == 0) {
			let el = $("<li>검색 결과가 존재하지 않습니다.</li>");
			$("#destination--list").append(el);
		} else {
			for (let i = 0; i < res.length; i++){
				let el = $("<li>");
				el.append(res[i].name);
				$("#destination--list").append(el);
			}
		}
		
	}).fail((error) => {
		console.log(error);
	});
});

$("#departure").on("focus", function() {
	$("#departure--airport").show();
});
$("#departure--div").on("blur", function() {
	$("#departure--airport").hide();
});

$("#destination").on("focus", function() {
	$("#destination--airport").show();
});

$("#destination--div").on("blur", function() {
	$("#destination--airport").hide();
});

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

