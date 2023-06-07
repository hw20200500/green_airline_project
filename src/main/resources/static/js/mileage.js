$(document).ready(function() {
	$('#liPeriod1').trigger('click');
	$(function() {
	    $("#sCalendar01").datepicker({
	      dateFormat: "yy.mm.dd",
	      changeMonth: true,
	      changeYear: true
	      // 추가적인 옵션 설정
	    });

	    $("#sCalendar02").datepicker({
	      dateFormat: "yy.mm.dd",
	      changeMonth: true,
	      changeYear: true
	      // 추가적인 옵션 설정
	    });
	  });

	/* 체크박스 전체 선택시 전체 선택 */
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

	/* 기간/가입일 조회 기능 */
	$("#searchType2").on("click", function() {

		if ($('#dd_period_detail').is(':visible') == true) {
			$('#dd_period_detail').hide();
		}
	});
	/* 기간/가입일 조회 기능 */
	$("#searchType1").on("click", function() {

		if ($('#dd_period_detail').is(':visible') == false) {
			$('#dd_period_detail').show()
		}
	});
	/* 기간별 조회 기능 1개뤟 */
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
	/* 기간별 조회 기능 3개뤟 */
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
	/* 기간별 조회 기능 6개뤟 */
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
	/* 기간별 조회 기능 1년 */
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






	/* 마일리지 조회 form으로 ajax 보내기 */
	$('#mileage--search').on("click", function() {
		
		let chkArr = [];
		$("input[type=checkbox]:checked").each(function() {
			let chk = $(this).val()
			chkArr.push(chk);
		});


		let form = $("form").serialize();
		console.log("form : " + form);
		// ? (@requ Stirn , sTr s, f )
		// json -- body --> @requestBody
		let startTime = $("#sCalendar01").val()
		let endTime = $("#sCalendar02").val()
		$.ajax({
			url: "/api/selectMileageList",
			type: "get",
			contentType: "application/json; charset=utf-8",
			dataType: "json",

			traditional: true,

		}).done(function(response) {
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
			let savebody = '';
			savebody += '<tr>';
			savebody += '<td colspan="3">' +'조회할 데이터가 없습니다.'+ '</td>';
			savebody += '</tr>';
			$("#savemileageList--tr--tbody").append(savebody);

			var usehead = '';
			usehead += '<tr>';
			usehead += '<th>' + '사용 금액' + '</td>';
			usehead += '<th>' + '사용 일자' + '</td>';
			usehead += '<th>' + '사용처' + '</td>';
			usehead += '</tr>';
			$("#usemileageList--tr--thead").append(usehead);
			let usebody = '';
			usebody += '<tr>';
			usebody += '<td colspan="3">' +'조회할 데이터가 없습니다.'+ '</td>';
			usebody += '</tr>';
			$("#usemileageList--tr--tbody").append(usebody);

			var expirationDatehead = '';
			expirationDatehead += '<tr>';
			expirationDatehead += '<th>' + '소멸 마일리지' + '</td>';
			expirationDatehead += '<th>' + '소멸 일자' + '</td>';
			expirationDatehead += '</tr>';
			$("#expirationDatemileageList--tr--thead").append(expirationDatehead);
			let expirationDatebody = '';
			expirationDatebody += '<tr>';
			expirationDatebody += '<td colspan="3">' +'조회할 데이터가 없습니다.'+ '</td>';
			expirationDatebody += '</tr>';
			$("#expirationDatemileageList--tr--tbody").append(expirationDatebody);
			
			let chk_arr = [];
			$("input[type=checkbox]:checked").each(function() {
				let chk = $(this).val()
				chk_arr.push(chk);
			});
			
				
				if ($.inArray('isUpSearch', chk_arr) === -1) {
    $("#savemileageList--tr--thead").empty();
    console.log('savemileageList');
}
if ($.inArray('isUseSearch', chk_arr) === -1) {
    $("#usemileageList--tr--thead").empty();
}
if ($.inArray('isExpireSearch', chk_arr) === -1) {
    $("#expirationDatemileageList--tr--thead").empty();
}
			
				

			for (i = 0; i < response.length; i++) {
				function addComma(value) {
					if (value === null) {
					    return ""; // null인 경우 빈 문자열("") 반환
					  }
					  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				  }
				let startDate1 = new Date($("#sCalendar01").val());
				let endDate1 = new Date($("#sCalendar02").val());
				let saveDate = new Date(response[i].mileageDate);
				/* 적립 마일리지 조회 */
				if (response[i].saveMileage !== null && response[i].saveMileage !== 0) {
					if (chk_arr[0] == 'isUpSearch' || chk_arr[0] == 'isAllSearch') {
						if (startDate1 < saveDate && saveDate < endDate1) {
							    $("#savemileageList--tr--tbody").empty();
   
  
							let body = '';
							body += '<tr>';
							body += '<td>' + addComma(response[i].saveMileage) + '</td>';
							body += '<td>' + (response[i].mileageDate).split('T')[0] + '</td>';
							body += '<td>' + (response[i].expirationDate).split('T')[0] + '</td>';
							body += '</tr>';
							$("#savemileageList--tr--tbody").append(body);
						}
					}
				}
				/* 사용 마일리지 조회 */

				let useDate1 = new Date(response[i].mileageDate);
				if (response[i].useMileage !== null && response[i].useMileage !== 'null') {
					console.log(response[i])
					if (chk_arr[0] == 'isUseSearch' || chk_arr[0] == 'isAllSearch' || chk_arr[1] == 'isUseSearch') {
						let body = '';
						if (startDate1 < useDate1 && useDate1 < endDate1) {
							 $("#usemileageList--tr--tbody").empty();
							body += '<tr>';
							body += '<td>' + addComma(response[i].useMileage) + '</td>';
							body += '<td>' + (response[i].mileageDate).split('T')[0] + '</td>';
							body += '<td>' + response[i].description + '</td>';
							body += '</tr>';
							$("#usemileageList--tr--tbody").append(body);
						}
					}
				}
				/* 소멸 마일리지 조회 */
				let endDate = new Date($("#sCalendar02").val());
				let expirationDate = new Date(response[i].expirationDate);
				if (response[i].expirationDate != null) {
					if (chk_arr[0] == 'isExpireSearch' || chk_arr[0] == 'isAllSearch' || chk_arr[1] == 'isExpireSearch' || chk_arr[2] == 'isExpireSearch') {
						if (endDate >= expirationDate) {
							  $("#expirationDatemileageList--tr--tbody").empty();
							let body = '';
							body += '<tr>';
							body += '<td>' + addComma(response[i].saveMileage) + '</td>';
							body += '<td>' + (response[i].expirationDate).split('T')[0] + '</td>';
							body += '</tr>';
							$("#expirationDatemileageList--tr--tbody").append(body);
						}

					}

				}
			}
		}).fail(function(error) {
			alert("서버오류");
		});
	});


});


