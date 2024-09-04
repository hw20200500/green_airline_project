
$(document).ready(function() {
	
	// 항공기별 좌석 여백 세팅
	if (airplaneId1 == 1) {
		$("#sch1Airplane .f--blank--div").css("height", "258px");
		$("#sch1Airplane .b--blank--div").css("height", "263px");
		$("#sch1Airplane .b--seat").css("margin-left", "89px");
		$("#sch1Airplane .e--seat").css("margin-left", "80px");
	} else if (airplaneId1 == 2) {
		$("#sch1Airplane .top--blank--div").css("height", "580px");
		$("#sch1Airplane .b--blank--div").css("height", "230px");
	} else if (airplaneId1 == 3) {
		$("#sch1Airplane .top--blank--div").css("height", "580px");
		$("#sch1Airplane .b--blank--div").css("height", "247px");
	} else {
		$("#sch1Airplane .top--blank--div").css("height", "577px");
	}
	
	if (airplaneId2 == 1) {
		$("#sch2Airplane .f--blank--div").css("height", "258px");
		$("#sch2Airplane .b--blank--div").css("height", "263px");
		$("#sch2Airplane .b--seat").css("margin-left", "89px");
		$("#sch2Airplane .e--seat").css("margin-left", "80px");
	} else if (airplaneId2 == 2) {
		$("#sch2Airplane .top--blank--div").css("height", "580px");
		$("#sch2Airplane .b--blank--div").css("height", "230px");
	} else if (airplaneId2 == 3) {
		$("#sch2Airplane .top--blank--div").css("height", "580px");
		$("#sch2Airplane .b--blank--div").css("height", "247px");
	} else {
		$("#sch2Airplane .top--blank--div").css("height", "577px");
	}
	
	// (왕복 시에만 활성화) 다음 스케줄 좌석 선택으로
	$("#nextSeatBtn").on("click", function() {
		scheduleNumber = 2;
		$("#sch1Airplane, #nextSeatBtn, #scheduleInfo1, #seatInfo1").hide();
		$("#sch2Airplane, #choiceCompleteBtn, #scheduleInfo2, #seatInfo2, #prevSeatBtn").show();
	});
	
	// (왕복 시에만 활성화) 이전 스케줄 좌석 선택으로
	$("#prevSeatBtn").on("click", function() {
		scheduleNumber = 1;
		$("#sch1Airplane, #nextSeatBtn, #scheduleInfo1, #seatInfo1").show();
		$("#sch2Airplane, #choiceCompleteBtn, #scheduleInfo2, #seatInfo2, #prevSeatBtn").hide();
	});
	
	// 좌석 선택 완료 버튼
	$("#choiceCompleteBtn").on("click", function() {
		if (scheduleCount == 2) {
			if (seatCount1 != totalSeatCount || seatCount2 != totalSeatCount) {
				alert("선택되지 않은 좌석이 존재합니다.");
				return false;
			}
		} else {
			if (seatCount1 != totalSeatCount) {
				alert("선택되지 않은 좌석이 존재합니다.");
				return false;
			}
		}
		
		// 좌석 정보 정렬
		seatNames1.sort();
		
		// 데이터 넘기기
		$(`input[name="adultCount"]`).val(adultCount);
		$(`input[name="childCount"]`).val(childCount);
		$(`input[name="infantCount"]`).val(infantCount);
		
		$(`input[name="scheduleId"]`).val(scheduleId1);
		$(`input[name="seatNames"]`).val(seatNames1);
		$(`input[name="seatGrade"]`).val(seatGrade1);
		
		// 왕복일 때에만
		if (scheduleCount == 2) {
			// 좌석 정보 정렬
			seatNames2.sort();
			$(`input[name="scheduleId2"]`).val(scheduleId2);
			$(`input[name="seatNames2"]`).val(seatNames2);
			$(`input[name="seatGrade2"]`).val(seatGrade2);
		}
		
	});
});

// 좌석 선택
function selectSeat(sch, type, seatName) {
	
	if (type == 'e') {
		// 선택
		if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/economy_not.png") {
			if (sch == 1 && seatCount1 < totalSeatCount) {
				seatNames1.push(seatName);
				seatCount1 ++;
			} else if (sch == 2 && seatCount2 < totalSeatCount) {
				seatNames2.push(seatName);
				seatCount2 ++;
			} else {
				return;
			}
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/economy_sel.png");
			showSeatInfo(seatName, "이코노미");
		
		// 선택 취소
		} else if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/economy_sel.png") {
			if (sch == 1) {
				seatNames1 = seatNames1.filter((n) => n != (seatName));
				seatCount1 --;
			} else {
				seatNames2 = seatNames2.filter((n) => n != (seatName));
				seatCount2 --;
			} 
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/economy_not.png");
			$(`#${sch}ul${seatName}`).remove();
			
		}
		
	// 비즈니스 좌석이라면
	} else if (type == 'b') {
		
		// 선택
		if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/business_not.png") {
			if (sch == 1 && seatCount1 < totalSeatCount) {
				seatNames1.push(seatName);
				seatCount1 ++;
			} else if (sch == 2 && seatCount2 < totalSeatCount) {
				seatNames2.push(seatName);
				seatCount2 ++;
			} else {
				return;
			}
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/business_sel.png");
			showSeatInfo(seatName, "비즈니스");
			
		// 선택 취소
		} else if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/business_sel.png") {
			if (sch == 1) {
				seatNames1 = seatNames1.filter((n) => n != (seatName));
				seatCount1 --;
			} else {
				seatNames2 = seatNames2.filter((n) => n != (seatName));
				seatCount2 --;
			}
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/business_not.png");
			$(`#${sch}ul${seatName}`).remove();
			
		}
		
	// 퍼스트 좌석이라면
	} else if (type == 'f') {
		
		// 선택 (r)
		if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/first_r_not.png") {
			if (sch == 1 && seatCount1 < totalSeatCount) {
				seatNames1.push(seatName);
				seatCount1 ++;
			} else if (sch == 2 && seatCount2 < totalSeatCount) {
				seatNames2.push(seatName);
				seatCount2 ++;
			} else {
				return;
			}
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/first_r_sel.png");
			showSeatInfo(seatName, "퍼스트");
			
		// 선택 취소 (r)
		} else if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/first_r_sel.png") {
			if (sch == 1) {
				seatNames1 = seatNames1.filter((n) => n != (seatName));
				seatCount1 --;	
			} else {
				seatNames2 = seatNames2.filter((n) => n != (seatName));
				seatCount2 --;	
			}
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/first_r_not.png");
			$(`#${sch}ul${seatName}`).remove();
			
		// 선택 (l)
		} else if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/first_l_not.png") {
			if (sch == 1 && seatCount1 < totalSeatCount) {
				seatNames1.push(seatName);
				seatCount1 ++;
			} else if (sch == 2 && seatCount2 < totalSeatCount) {
				seatNames2.push(seatName);
				seatCount2 ++;
			} else {
				return;
			}
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/first_l_sel.png");
			showSeatInfo(seatName, "퍼스트");
			
		// 선택 취소 (l)
		} else if ($(`.seat--${sch}--${seatName}`).attr("src") == "/images/ticket/first_l_sel.png") {
			if (sch == 1) {
				seatNames1 = seatNames1.filter((n) => n != (seatName));
				seatCount1 --;
			} else {
				seatNames2 = seatNames2.filter((n) => n != (seatName));
				seatCount2 --;
			}
			$(`.seat--${sch}--${seatName}`).attr("src", "/images/ticket/first_l_not.png");
			$(`#${sch}ul${seatName}`).remove();
			
		}
	}
	$("#seatCount1").text(seatCount1);
	$("#seatCount2").text(seatCount2);
}

// 선택된 좌석 정보 보이게
function showSeatInfo(seatName, seatGrade) {
	let newUl = $(`<ul class="seat--ul">`);
	newUl.attr("id", `${scheduleNumber}ul${seatName}`);
	newUl.append(`<li><div>좌석번호 : ${seatName}</div><button class="close--button" id="close--${scheduleNumber}--${seatName}">
					<span class="material-symbols-outlined">close</span></button></li>`);
	
	newUl.append(`<li>좌석등급 : ${seatGrade}</li>`);
	$(`#seatInfo${scheduleNumber} .seat--name--list`).append(newUl);
	
	$(`#close--${scheduleNumber}--${seatName}`).on("click", function() {
		$(`.seat--${scheduleNumber}--${seatName}`).click();
	});
}

