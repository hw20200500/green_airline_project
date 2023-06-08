$(document).ready(function() {
$('#liPeriod1').trigger('click');
})

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
			if(startTime == ''){
				alert("시작 날짜를 선택 해주세요");
			}
			if(endTime == ''){
				alert("종료 날짜를 선택 해주세요");
			}
			if(radio == ''){
				alert("내역을 선택 해주세요");
			}
			
			let body = '';
			
			if (radio == 'buy') {
				$("#gifticonList--tr--tbody").empty();
				$("#gifticonList--tr--thead").empty();
				body = '';
				body += '<tr>';
				    body += '<th>' + "체크" + '</th>';
				    body += '<th>' + "브랜드" + '</th>';
				    body += '<th>' + "이름" + '</th>';
				    body += '<th>' + "발급날짜" + '</th>';
				    body += '<th>' + "유효기간" + '</th>';
				    body += '<th>' + "가격" + '</th>';
				    body += '</tr>';
			} else {
				$("#gifticonList--tr--tbody").empty();
				$("#gifticonList--tr--thead").empty();
				$('.deleteBtn').hide();
				body = '';
				body += '<tr>';
				body += '<th>' + "브랜드" + '</th>';
				body += '<th>' + "이름" + '</th>';
				body += '<th>' + "취소날짜" + '</th>';
				body += '<th>' + "가격" + '</th>';
				body += '</tr>';
			}
			$.ajax(
					{
						url: "/api/gifticonList",
						type: "get",
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						data: {
							startTime: startTime,
							endTime: endTime,
							radio: radio
						}
					})
				.done(
					function(response) {
					
						if (response.length == 0) {
							$(".no--list--p").show();
							$("#gifticonList").hide();
						} else {
							$(".no--list--p").hide();
							$("#gifticonList").show();
							$("#gifticonList--tr--thead").append(body);
						}
						
						for (i = 0; i < response.length; i++) {
							if (radio == 'buy') {

								let body = '';

								body += '<tr>';
								body += '<td>'
									+ '<input type="checkbox" name="checkbox" value="'
									+ response[i].id + '">'
									+ '</td>';

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
						location.reload();
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
	
	if (gifticonIdArray.length != 0) {
		let delConfirm = confirm('환불을 원하시면 확인을 눌러주세요.');		
		if (delConfirm) {			
		  	alert('환불되었습니다.');
		}
		else {
		   alert('취소되었습니다.');
		   return false;
		}
	} else {
		return false;
	}
}

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
  
