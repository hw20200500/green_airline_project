$(document).ready(function() {


	/* 체크박스 전체 선택시 전체 선택*/
	$("#checkboxList #mileageType0").on("click", function() {
		let chk = $("input[type=checkbox]")
		if ($(this).is(":checked")) {
			chk.prop("checked", true);
		} else {
			chk.prop("checked", false);
		}
	});

	$(".searchKind").change(function() {
		if ($(".searchKind:checked").length == $(".searchKind").length) {
			$("#mileageType0").prop("checked", true);
		} else {
			$("#mileageType0").prop("checked", false);
		}
	});

	/*기간/가입일 조회 기능*/
	$("#searchType2").on("click", function() {

		if ($('#dd_period_detail').is(':visible') == true) {
			$('#dd_period_detail').hide();
		}
	});
	/*기간/가입일 조회 기능*/
	$("#searchType1").on("click", function() {

		if ($('#dd_period_detail').is(':visible') == false) {
			$('#dd_period_detail').show()
		}
	});
	/*기간별 조회 기능 1개뤟*/
	$('#liPeriod1').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 1)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);

	});
	/*기간별 조회 기능 3개뤟*/
	$('#liPeriod3').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 3)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);
	});
	/*기간별 조회 기능 6개뤟*/
	$('#liPeriod6').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 6)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);
	});
	/*기간별 조회 기능 1년*/
	$('#liPeriod12').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 12)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);
	});
	$("#liPeriods").on("click", function() {

		$("#sCalendar01").val("");
		$("#sCalendar02").val("");
	});

	/*마일리지 조회 form으로 ajax 보내기*/
	$('#mileage--search').on("click", function() {
		let form = $("form").serialize();
		$.ajax({
			url: "/api/selectMileageListProc?" + form,
			type: "get",

		}).done(function(response) {
			console.log(response);
			var checkbox = $("input[name='mileageType0']:checked");//체크된거 가져오기
			console.log(checkbox);
			$("#savemileageList--tr--thead").empty();
			$("#savemileageList--tr--tbody").empty();
			$("#usemileageList--tr--thead").empty();
			$("#usemileageList--tr--tbody").empty();
			$("#expirationDatemileageList--tr--thead").empty();
			$("#expirationDatemileageList--tr--tbody").empty();
			var savehead = '';
			savehead += '<tr>';
			savehead += '<th>' + '적립 금액' + '</td>';
			savehead += '<th>' + '적립 일자' + '</td>';
			savehead += '<th>' + '유효기간' + '</td>';
			savehead += '</tr>';
			$("#savemileageList--tr--thead").append(savehead);

			var usehead = '';
			usehead += '<tr>';
			usehead += '<th>' + '사용 금액' + '</td>';
			usehead += '<th>' + '사용 일자' + '</td>';
			usehead += '<th>' + '사용처' + '</td>';
			usehead += '</tr>';
			$("#usemileageList--tr--thead").append(usehead);

			var expirationDatehead = '';
			expirationDatehead += '<tr>';
			expirationDatehead += '<th>' + '소멸 마일리지' + '</td>';
			expirationDatehead += '<th>' + '소멸 일자' + '</td>';
			expirationDatehead += '</tr>';
			$("#expirationDatemileageList--tr--thead").append(expirationDatehead);

			let chk_arr = [];
			$("input[type=checkbox]:checked").each(function() {
				let chk = $(this).val()
				chk_arr.push(chk);
			});
			console.log(chk_arr);
			let nowDate = new Date();
			for (i = 0; i < response.length; i++) {
				/*적립 마일리지 조회*/
				if (response[i].saveDate != null) {
					if (chk_arr[0] == 'isUpSearch' || chk_arr[0] == 'isAllSearch') {
						let body = '';
						body += '<tr>';
						body += '<td>' + response[i].saveDate + '</td>';
						body += '<td>' + response[i].saveMileage + '</td>';
						body += '<td>' + response[i].expirationDate + '</td>';
						body += '</tr>';
						$("#savemileageList--tr--tbody").append(body);
					}

				}
				/* 사용 마일리지 조회 */
				if (response[i].useDate != null) {
					if (chk_arr[0] == 'isUseSearch' || chk_arr[0] == 'isAllSearch' || chk_arr[1] == 'isUseSearch') {
						let body = '';
						body += '<tr>';
						body += '<td>' + response[i].useDate + '</td>';
						body += '<td>' + response[i].useMileage + '</td>';
						body += '<td>' + response[i].description + '</td>';
						body += '</tr>';
						$("#usemileageList--tr--tbody").append(body);
					}

				}
				/* 소멸 마일리지 조회 */
				if (response[i].expirationDate != null) {
					if (chk_arr[0] == 'isExpireSearch' || chk_arr[0] == 'isAllSearch'||chk_arr[1] == 'isExpireSearch'||chk_arr[2] == 'isExpireSearch') {
						let body = '';
						body += '<tr>';
						body += '<td>' + response[i].saveMileage + '</td>';
						body += '<td>' + response[i].expirationDate + '</td>';
						body += '</tr>';
						$("#expirationDatemileageList--tr--tbody").append(body);
					}

				}
			}
		}).fail(function(error) {
			alert("서버오류");
		});
	});


});



