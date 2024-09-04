	
$(document).ready(function() {

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

	let subMenu = $("#menuName").val();
	
	if (subMenu == '항공권 예약') {
		subMenu = '운항 스케줄 조회';
	}
	
	if (subMenu != "") {
		
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
	}
});

// 현재 날짜 반환
function getCurrentDate() {
    var date = new Date();
    var year = date.getFullYear().toString();

    var month = date.getMonth() + 1;
    month = month < 10 ? '0' + month.toString() : month.toString();

    var day = date.getDate();
    day = day < 10 ? '0' + day.toString() : day.toString();

    return year + "-" + month + "-" + day ;
}
	
// 날짜 차이를 '일'로 계산
function calculateDayDiff (date1, date2) {
	let time1 = date1.getTime();
	let time2 = date2.getTime();
	let timeDiff = time1 - time2;

	let dayCount = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
	return dayCount;
}

// 문자열을 날짜로 변환
function stringToDate(str) {
	let year;
	let month;
	let day;
	if (str.length > 8) {
		let arr = str.split("-");
		if (arr.length != 3) {
			return "error";
		}
		year = arr[0];
		month = arr[1];
		day = arr[2];
	} else if (str.length == 8) {
		
		try {
			let test = parseInt(str);
		} catch (e) {
			// 숫자가 아니면
			return "error";
		}
		
		year = str.substr(0, 4);
		month = str.substr(4, 2);
		day = str.substr(6, 2);		
	} else {
		return "error";	
	}

	if (month == 2) {
		if (day == 29) {
			if (year % 4 != 0 || year % 100 == 0 && year % 400 != 0) {
				return "error";
			}
		}
		else if (day > 28) {
			return "error";
		}
	} else if (month == 4 || month == 6 || month == 9 || month == 11) {
		if (day > 30) {
			return "error";
		}
	} else if (month > 12) {
		return "error";
	} else {
		if (day > 31) {
			return "error";
		}
	}
	return new Date(year, month - 1, day);
}
