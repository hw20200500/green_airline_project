$(document).ready(function() {
	// 탑승객 입력 완료 버튼
	$("#passengerInfoBtn").on("click", function() {
		
		passengerInfos = [];
		
		// 탑승객 수	
		let passengerCount = $(".passenger--tr").length;
		
		for (let i = 1; i <= passengerCount; i++) {
			let targetTr = $(`#passenger${i}`);
			// 성인, 소아, 유아
			let ageType = targetTr.children().eq(0).text().trim().substr(0, 2);
			let target = targetTr.children().eq(0).text().trim().substr(0, 4);
			// M, F
			let gender = targetTr.children().eq(1).children(`input[name="gender${i}"]:checked`).val();
			
			// 성별이 선택되지 않은 경우
			if (typeof gender == "undefined") {
				alert(`${target}의 성별이 선택되지 않았습니다.`);
				$("#paymentDiv").hide();
				return false;
			}
			
			// 이름
			let nameInput = targetTr.children().eq(2).children(`input[name="name${i}"]`);
			let name = nameInput.val().replaceAll(" ", "");
			
			// 이름이 입력되지 않은 경우
			if (name == "") {
				alert(`${target}의 이름이 입력되지 않았습니다.`);
				nameInput.focus();
				$("#paymentDiv").hide();
				return false;
			}
			
			// 생년월일
			let birthInput = targetTr.children().eq(3).children(`input[name="birth${i}"]`);
			let birth = birthInput.val().replaceAll(" ", "");
			
			// 생년월일이 입력되지 않은 경우
			if (birth == "") {
				alert(`${target}의 생년월일이 입력되지 않았습니다.`);
				birthInput.focus();
				$("#paymentDiv").hide();
				return false;
			}
			
			birthDate = stringToDate(birth);
			// 날짜 형식이 잘못되었거나(yyyy-mm-dd), 존재하지 않는 날짜인 경우 
			if (birthDate == "error") {
				alert(`${target}의 생년월일이 유효하지 않습니다.\n형식을 확인해주시길 바랍니다.`);
				birthInput.focus();
				$("#paymentDiv").hide();
				return false;
			} 
			
			// 생년월일이 현재 날짜 이후인 경우
			if (birth > getCurrentDate()) {
				alert(`${target}의 생년월일이 유효하지 않습니다.\n입력된 생년월일이 현재 날짜 이후입니다.`);
				birthInput.focus();
				$("#paymentDiv").hide();
				return false;
			}
			
			// 선택된 탑승객의 타입과 생년월일 범위가 일치하는지 확인
			
			// 스케줄1 출발 날짜에 따른 연령 타입 확인
			let calculatedAgeType1 = calculateAgeType(birthDate, stringToDate(testSch1DepartureDate));
			
			// 입력한 생년월일이 연령 타입에 부합하는지 확인
			if (ageType != calculatedAgeType1) {
				alert(`${target}의 생년월일이 유효하지 않습니다.\n입력된 생년월일은 ${calculatedAgeType1}에 해당합니다.`);
				birthInput.focus();
				$("#paymentDiv").hide();
				return false;
			}
		
			// 왕복인 경우
			// 스케줄2 출발 날짜에 따른 연령 타입 확인
			let calculatedAgeType2;
			if (scheduleCount == 2) {
				calculatedAgeType2 = calculateAgeType(birthDate, stringToDate(testSch2DepartureDate));
				// 스케줄1과 스케줄2의 출발 날짜에 따른 연령 타입이 서로 다른 경우
				if (calculatedAgeType1 != calculatedAgeType2) {
					alert(`여정 2의 출발 날짜에는 ${target}의 유형이 ${calculatedAgeType2}(이)가 됩니다.\n항공권을 따로 예매해주시길 바랍니다.`);
					birthInput.focus();
					$("#paymentDiv").hide();
					return false;
				}
			}
			
			// 해당 탑승객 정보		
			passengerInfos.push(`${ageType}_${gender}_${name}_${birth}`);
		}
		
		$("#paymentDiv").show();
		window.scrollTo(0, document.body.scrollHeight);
	});
	
	// 현재 예약자를 탑승객에 포함할 건지 선택하는 체크박스
	// 선택 시 현재 로그인된 user의 회원 정보에서 받아옴
	$("#checkCurrentUser").on("change", function() {
	
		let targetTr = $("#passenger1");
		let genderM = targetTr.children().eq(1).children("input").eq(0);
		let genderF = targetTr.children().eq(1).children("input").eq(1);
		let name = targetTr.children().eq(2).children("input");
		let birth = targetTr.children().eq(3).children("input");
		
		// 체크
		if ($(this).is(":checked")) {
			
			$.ajax({
				type: 'GET',
				url: '/loginMemberInfo'
			})
			.done((res) => {
				// 회원 정보 불러와서 데이터 넣기
				if (res.gender == 'M') {
					genderM.prop("checked", true);
				} else {
					genderF.prop("checked", true);
				}
				name.val(res.korName);
				birth.val(res.birthDate);
			})
			.fail((error) => {
				console.log(error);
			});
			
		// 체크 해제
		} else {
			targetTr.children().eq(1).children("input").prop("checked", false);
			name.val("");
			birth.val("");
		}
		
	});
	
	$("#kakaoPayImg").on("click", function() {
		let ticket;
		// 편도면
		if (scheduleCount == 1) {
			ticket = {
				adultCount: adultCount,
				childCount: childCount,
				infantCount: infantCount,
				scheduleId: scheduleId1,
				seatGrade: seatGrade1,
				seatNames: seatNames1,
				price: price,
				passengerInfos: passengerInfos,
				totalAmount: price,
				quantity: scheduleCount
			}
		// 왕복이면
		} else {
			ticket = {
				adultCount: adultCount,
				childCount: childCount,
				infantCount: infantCount,
				scheduleId: scheduleId1,
				seatGrade: seatGrade1,
				seatNames: seatNames1,
				price: price,
				scheduleId2: scheduleId2,
				seatGrade2: seatGrade2,
				seatNames2: seatNames2,
				passengerInfos: passengerInfos,
				price2: price2,
				totalAmount: price + price2,
				quantity: scheduleCount
			}
		}
		console.log(ticket);
		
		$.ajax({
			type: "POST",
			url: "/payment/request",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(ticket),
			dataType: "text" // 이거 하니까 "parsererror" 해결
		})
		.done((res) => {
			location.href=`${res}`;
		})
		.fail((error) => {
			console.log(error);
		});
	});
	
	$("#milesPayBtn").on("click", function() {
		let ticket;
		// 편도면
		if (scheduleCount == 1) {
			ticket = {
				adultCount: adultCount,
				childCount: childCount,
				infantCount: infantCount,
				scheduleId: scheduleId1,
				seatGrade: seatGrade1,
				seatNames: seatNames1,
				milesPrice: milesPrice,
				passengerInfos: passengerInfos
			}
		// 왕복이면
		} else {
			ticket = {
				adultCount: adultCount,
				childCount: childCount,
				infantCount: infantCount,
				scheduleId: scheduleId1,
				seatGrade: seatGrade1,
				seatNames: seatNames1,
				milesPrice: milesPrice,
				scheduleId2: scheduleId2,
				seatGrade2: seatGrade2,
				seatNames2: seatNames2,
				passengerInfos: passengerInfos,
				milesPrice2: milesPrice2
			}
		}
		
		$.ajax({
			type: "POST",
			url: "/payment/miles",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(ticket)
		})
		.done((res) => {
			// 결제 실패
			if (res.code == -1) {
				alert(res.message);
			// 결제 성공
			} else {
				alert(res.message);
				location.href="/ticket/detail/" + res.data;
			}
		})
		.fail((error) => {
			console.log(error);
		});
	});
	
	$("input[name=\"paymentType\"]").on("change", function() {
		if ($(this).is(":checked")) {
			if ($(this).val() == 0) {
				$("#kakaoPayDiv").show();
				$("#milesPayDiv").hide();
				
			} else {
				$("#kakaoPayDiv").hide();
				$("#milesPayDiv").show();
				
			}
		}
	});
});