	let footerBottom;
	let menuIndex;
	
	$(window).resize(function() {
		$(".nav--depth2--background").css("width", $(".nav--depth2--div").width());	
		footerBottom = $("footer").position().top + $("footer").height() + 60;
	});
	
	
	$(document).ready(function() {
		footerBottom = $("footer").position().top + $("footer").height() + 60;
		
		// 상단 메뉴에서 nav--bar 움직이게
		$(".nav--depth1").contents().on("mouseenter", function() {
			// 이미 해당 메뉴로 이동 중이면 밑의 코드 실행 X
			if (menuIndex == $(this).index()) {
				return;
			}
			
			// 선택된 요소 인덱스
			menuIndex = $(this).index();
			let navBarLeft = menuIndex * $(this).width();
			
			$(".nav--bar").stop();
			
			// 이미 메뉴가 내려와있는 상태라면
			if ($(".nav--bar").css("display") == "block") {
				if (menuIndex == 1) {
					$(".nav--bar").animate({left : navBarLeft + 1}, 700);	
				} else if (menuIndex > 2) {
					$(".nav--bar").animate({left : navBarLeft + 3}, 700);			
				} else {
					$(".nav--bar").animate({left : navBarLeft}, 700);
				}
				$(this).children().css("color", "#314f79");
				$(this).siblings().children().css("color", "#3e3e3e");
				// 세부 메뉴 밑으로는 어둡게 처리
				let headerHeight = 412;
				let backgroundHeight;
				if (footerBottom < window.innerHeight) {
					backgroundHeight = window.innerHeight - headerHeight;	
				} else {
					backgroundHeight = footerBottom - headerHeight;
				}
				$(".nav--depth2--background").css("height", backgroundHeight);	
				$(".nav--depth2--background").css("width", $(".nav--depth2--div").width());	
			} else {
				$(".nav--bar").css("display", "block");
				if (menuIndex > 0) {
					$(".nav--bar").css("left", navBarLeft + 1);
	 			} else {
					$(".nav--bar").css("left", navBarLeft); 				
	 			}
				$(".nav--depth1").css("margin-bottom", "10px");
				//$(".nav--depth2").css("width", $(".page--container").width());	
				//$(".header--menu--split").css("width", $(".page--container").width());
				
				// 세부 메뉴 밑으로는 어둡게 처리
				let headerHeight = 412;
				let backgroundHeight;
				if (footerBottom < window.innerHeight) {
					backgroundHeight = window.innerHeight - headerHeight;	
				} else {
					backgroundHeight = footerBottom - headerHeight;
				}
				$(".nav--depth2--background").css("height", backgroundHeight);	
				$(this).children().css("color", "#314f79");
				$(this).siblings().children().css("color", "#3e3e3e");
				
				$(".nav--depth2").slideDown(function() {
					$(".nav--depth2--background").css("width", $(".nav--depth2--div").width());	
				});
			}
		});
	
		// 내려온 메뉴 내에서 nav--bar 움직이게
		$(".nav--depth2--div").contents().on("mouseover", function() {
			let thisIndex = $(this).index();
			if (thisIndex <= 4) {
				// 이미 해당 메뉴로 이동 중이면 밑의 코드 실행 X
				if (menuIndex == 0) {
					return;
				}
				menuIndex = 0;
			} else if (thisIndex == 6) {
				if (menuIndex == 1) {
					return;
				}
				menuIndex = 1;
			} else if (thisIndex == 8) {
				if (menuIndex == 2) {
					return;
				}
				menuIndex = 2;
			} else if (thisIndex == 10) {
				if (menuIndex == 3) {
					return;
				}
				menuIndex = 3;
			}
			
			$(".nav--bar").stop();
			
			let navBarLeft = menuIndex * 230;
			if (menuIndex == 1) {
				$(".nav--bar").animate({left : navBarLeft + 1}, 700);	
			} else if (menuIndex == 2) {
				$(".nav--bar").animate({left : navBarLeft + 2}, 700);			
			} else if (menuIndex == 3) {
				$(".nav--bar").animate({left : navBarLeft + 3}, 700);	
			} else {
				$(".nav--bar").animate({left : navBarLeft}, 700);
			}
			
			$(".nav--depth1 li").eq(menuIndex).children().css("color", "#314f79");
			$(".nav--depth1 li").eq(menuIndex).siblings().children().css("color", "#3e3e3e");
			// 세부 메뉴 밑으로는 어둡게 처리
			let headerHeight = 412;
			let backgroundHeight;
			if (footerBottom < window.innerHeight) {
				backgroundHeight = window.innerHeight - headerHeight;	
			} else {
				backgroundHeight = footerBottom - headerHeight;
			}
			$(".nav--depth2--background").css("height", backgroundHeight);	
			$(".nav--depth2--background").css("width", $(".nav--depth2--div").width());	
		
		});
		
		$(".main--menu").on("mouseleave", function() {
			menuIndex = null;
			$(".nav--bar").css("display", "none");
			$(".nav--depth1").css("margin-bottom", "17px");
			$(".nav--depth2").css("display", "none");
			$(".nav--depth1 li").children().css("color", "#3e3e3e");
		});
		
		$(".nav--depth2--background").on("mouseover", function() {
			menuIndex = null;
			$(".nav--bar").css("display", "none");
			$(".nav--depth1").css("margin-bottom", "17px");
			$(".nav--depth2").css("display", "none");
		});
		
		// 서브 메뉴 관련
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
		if (subMenu != "") {
			// 서브메뉴 목록 가져오기
			$.ajax({
				type: 'GET',
				url: `/subMenuList/${subMenu}`
			})
			.done((res) => {
				console.log(res);
				
				for (let i = 0; i < res.data.length; i++) {
					var li = $("<li>");
					var btn = $(`<button class="menu--button" onclick="location.href='${res.data[i].mapping}'">`);
					if (res.data[i].subMenu == res.data[i].mainMenu) {
						btn.text("메인");
						$("#currentSubMenu").text("메인");
					} else {
						// 소셜회원은 회원정보 변경, 비밀번호 변경 메뉴 뜨지 않게 설정
						if (userRole == '소셜회원' && (res.data[i].subMenu == '회원정보 변경' || res.data[i].subMenu == '비밀번호 변경')) {
							continue;
						} else {					
							btn.text(res.data[i].subMenu);
							$("#currentSubMenu").text(res.data[i].subMenu);
						}
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
		
		$(".reg--input").on("keyup", function(e) {
			if (e.keyCode == '13') {
				e.preventDefault();
			}	
		});
		
		$(".customer--service--li").on("mouseenter", function() {
			$(".ul--dropdown--menu").css("display", "block");
		});
	
		$(".customer--service--li").on("mouseleave", function() {
			$(".ul--dropdown--menu").css("display", "none");
		});
		
	}); // end of document_ready_function
	

	
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

