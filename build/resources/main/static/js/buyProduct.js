$(document).ready(function() {
   $('#liPeriod1').trigger('click');
   $(function() {
       $("#sCalendar01").datepicker({
         dateFormat: "yy-mm-dd",
         changeMonth: true,
         changeYear: true
         // 추가적인 옵션 설정
       });

       $("#sCalendar02").datepicker({
         dateFormat: "yy-mm-dd",
         changeMonth: true,
         changeYear: true
         // 추가적인 옵션 설정
       });
   });
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
$("#gifticon--search")
	.on(
		"click",
		function() {
			let form = $("form").serialize();
			let startTime = $("#sCalendar01").val();
			let endTime = $("#sCalendar02").val();
			let radio = $("input[name=chk]:checked").val();
			let memberId = $('#searchMemberId').val();
			if (radio == 'buy') {
				$("#gifticonList--tr--tbody").empty();
				$("#gifticonList--tr--thead").empty();
				let body = '';
				 body += '<tr>';
				    body += '<th>' + "브랜드" + '</th>';
				    body += '<th>' + "이름" + '</th>';
				    body += '<th>' + "발급날짜" + '</th>';
				    body += '<th>' + "유효기간" + '</th>';
				    body += '<th>' + "가격" + '</th>';
				    body += '</tr>';
				$("#gifticonList--tr--thead").append(body);
			} else {
				$("#gifticonList--tr--tbody").empty();
				$("#gifticonList--tr--thead").empty();
				$('.deleteBtn').hide();
				let body = '';
				body += '<tr>';
				body += '<th>' + "브랜드" + '</th>';
				body += '<th>' + "이름" + '</th>';
				body += '<th>' + "취소날짜" + '</th>';
				body += '<th>' + "가격" + '</th>';
				body += '</tr>';
				$("#gifticonList--tr--thead").append(body);
			}
			$
				.ajax(
					{
						url: "/api/managerGifticonList",
						type: "get",
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						data: {
							startTime: startTime,
							endTime: endTime,
							radio: radio,
							memberId: memberId
						}
					})
				.done(
					function(response) {
						console.log(response)
						for (i = 0; i < response.length; i++) {
							console.log(response[i]);
							if (radio == 'buy') {

								let body = '';

								body += '<tr>';
								

								body += '<td>'
									+ response[i].brand
									+ '</td>';
								body += '<td>'
									+ response[i].name
									+ '</td>';
								body += '<td>'
									+ response[i].startDate
									+ '</td>';
								body += '<td>'
									+ response[i].endDate.toString().substr(0, 10)
									+ '</td>';
								body += '<td>'
									+ (response[i].price * response[i].amount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
									+ '</td>';
								body += '</tr>';
								$("#gifticonList--tr--tbody")
									.append(body);
							} else {
								let body = '';

								body += '<tr>';
								body += '<td>'
									+ response[i].brand
									+ '</td>';
								body += '<td>'
									+ response[i].name
									+ '</td>';
								body += '<td>'
									+ response[i].revokeDate.toString().substr(0, 10)
									+ '</td>';
								body += '<td>'
									+ (response[i].price * response[i].amount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
									+ '</td>';
								body += '</tr>';
								$("#gifticonList--tr--tbody")
									.append(body);
							}

						}
					}).fail(function(error) {
						alert("실패");
					});
		});
function refundGifticon() {
	// 체크된 체크박스 값을 가져옴
	var checkedBoxes = $("input[name='checkbox']:checked");
	var gifticonIdArray = [];
	var gifticonAmountArray = [];
	var gifticonNameArray = [];
	var gifticonBrandArray = [];
	var productIdArray = [];

	// 체크된 체크박스의 값들을 배열에 저장
	checkedBoxes.each(function() {
		gifticonIdArray.push($(this).val());
		productIdArray.push($(this).val());
		gifticonAmountArray.push($(this).closest('tr').find('td:eq(5)').text());
		gifticonNameArray.push($(this).closest('tr').find('td:eq(1)').text());
		gifticonBrandArray.push($(this).closest('tr').find('td:eq(2)').text());
	});

	// 배열을 콤마로 구분된 문자열로 변환하여 hidden input 요소에 할당
	$("#gifticonId").val(gifticonIdArray.join(","));
	$("#productId").val(productIdArray.join(","));
	$("#gifticonAmount").val(gifticonAmountArray.join(","));
	$("#gifticonName").val(gifticonNameArray.join(","));
	$("#gifticonBrand").val(gifticonBrandArray.join(","));
	console.log(gifticonIdArray)
	console.log(gifticonAmountArray)
	// 폼을 제출하여 컨트롤러로 데이터 전송
	$("form").submit();
}
