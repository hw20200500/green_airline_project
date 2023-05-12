

function selectSeat(i) {
	// 선택
	if ($(`.economy--seat--${i}`).attr("src") == "/images/economy_not.png" && seatCount > 0) {
		$(`.economy--seat--${i}`).attr("src", "/images/economy_sel.png");
		$(`.economy--seat--${i}`).toggleClass("selected--seat");
		seatCount --;
		
		let seatNumber = $(`.economy--seat--${i}`).attr("class").split("seat--")[1].split(" ")[0];
		
		if (seatNumber < 10) {
			seatName = "E00" + seatNumber;
		} else if (seatNumber < 100) {
			seatName = "E0" + seatNumber;
		} else {
			seatName = "E" + seatNumber;
		}
			
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
	} else if ($(`.economy--seat--${i}`).attr("src") == "/images/economy_sel.png" && seatCount >= 0) {
		$(`.economy--seat--${i}`).attr("src", "/images/economy_not.png");
		$(`.economy--seat--${i}`).toggleClass("selected--seat");
		seatCount ++;
		
		let seatNumber = $(`.economy--seat--${i}`).attr("class").split("seat--")[1].split(" ")[0];
		
		if (seatNumber < 10) {
			seatName = "E00" + seatNumber;
		} else if (seatNumber < 100) {
			seatName = "E0" + seatNumber;
		} else {
			seatName = "E" + seatNumber;
		}
		
		$(`#div${seatName}`).remove();
		
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

