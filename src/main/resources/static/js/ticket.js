

function selectSeat(type, seatName) {
	
	if (type == 'e') {
		// 선택
		if ($(`.economy--seat--${seatName}`).attr("src") == "/images/ticket/economy_not.png" && seatCount > 0) {
			$(`.economy--seat--${seatName}`).attr("src", "/images/ticket/economy_sel.png");
			seatCount --;
			
			console.log("df");
				
			$.ajax({
				type: 'GET',
				url: `/ticket/selectedSeatData?seatName=${seatName}&scheduleId=${scheduleId}`,
				contentType: 'application/json; charset=utf-8'
				
			}).done((res) => {
				console.log(res);
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
				console.log(res);
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
				console.log(res);
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

