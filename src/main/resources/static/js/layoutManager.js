	
// 현재 날짜
function getCurrentDate() {
    var date = new Date();
    var year = date.getFullYear().toString();

    var month = date.getMonth() + 1;
    month = month < 10 ? '0' + month.toString() : month.toString();

    var day = date.getDate();
    day = day < 10 ? '0' + day.toString() : day.toString();

    return year + "-" + month + "-" + day ;
}

$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
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
	
// 날짜 차이를 '일'로 계산
function calculateDayDiff (date1, date2) {
	let time1 = date1.getTime();
	let time2 = date2.getTime();
	let timeDiff = time1 - time2;

	let dayCount = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
	return dayCount;
}

$("#subMenu1").on("click", function() {
	$("#dropMenu1").slideDown("fast");
	$(this).addClass("selected--sub--menu");
});

$("#subMenu1").parent().on("mouseleave", function() {
	$("#dropMenu1").hide();
	$("#subMenu1").removeClass("selected--sub--menu");
});

$("#subMenu2").on("click", function() {
	$("#dropMenu2").slideDown("fast");
	$(this).addClass("selected--sub--menu");
});

$("#subMenu2").parent().on("mouseleave", function() {
	$("#dropMenu2").hide();
	$("#subMenu2").removeClass("selected--sub--menu");
});

$(document).ready(function() {
	let subMenu = $("#menuName").val();
	
	// 서브메뉴 목록 가져오기
	$.ajax({
		type: 'GET',
		url: `/subMenuList/${subMenu}`
	})
	.done((res) => {
		
		for (let i = 0; i < res.data.length; i++) {
			var li = $("<li>");
			var btn = $(`<button class="menu--button" onclick="location.href='${res.data[i].mapping}'">`);
			if (res.data[i].subMenu == res.data[i].mainMenu) {
				btn.text("메인");
				$("#currentSubMenu").text("메인");
			} else {	
				btn.text(res.data[i].subMenu);
				$("#currentSubMenu").text(res.data[i].subMenu);
			}
			li.append(btn);
			$("#dropMenu2").append(li);
		}
		
		$("#currentMainMenu").text(res.data[0].mainMenu);	
		
		if ($("#currentMainMenu").text() == subMenu) {
			$("#currentSubMenu").text("메인");		
		} else {
			$("#currentSubMenu").text(subMenu);
		}
		
	})
	.fail((error) => {
		console.log(error);
	});
	
});

