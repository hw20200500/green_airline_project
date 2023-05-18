$(document).ready(function() {
	$(function() {
		
		
		//input을 datepicker로 선언
		$("#datepicker, #datepicker2").datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
			, showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			, showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
			, changeYear: true //option값 년 선택 가능
			, changeMonth: true //option값  월 선택 가능                
			, buttonText: "선택" //버튼 호버 텍스트              
			, yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
			, monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
			, monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
			, dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
			, dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
		});
		
		/*$('#datepicker, #datepicker2').css('z-index', 99999999999999);*/

		//초기값을 오늘 날짜로 설정해줘야 합니다.
		
		$("#datepicker, #datepicker2").datepicker();
		$('#datepicker, #datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	});

/*	$(function() {
		$("#datepicker--form, #datepicker--to").datepicker();
	});*/

	$("#start").on("click", function() {
		$("#departure")
			.on(
				"keyup focus change",
				function() {
					let searchName = $("#departure").val().replaceAll(" ", "");
					$("#departure").val(searchName);

					console.log(searchName);

					if (searchName == "") {
						$(".pop--rel--keyword").empty();
						return;
					} else if (searchName.indexOf("\\") != -1) {
						$(".pop--rel--keyword").empty();
						var el = $("<li>검색 결과가 존재하지 않습니다.</li>");
						$(".pop--rel--keyword").append(el);
						return;
					}

					$.ajax({
						type: "GET",
						url: `/search?name=${searchName}`,
						contentType: 'application/json; charset=utf-8'
					}).done(function(res) {
						$(".pop--rel--keyword").empty();

						if (res.length == 0) {
							var el = $("<li class='search--airport--li'>검색 결과가 존재하지 않습니다.</li>");
							$(".pop--rel--keyword").append(el);
						} else {
							for (var i = 0; i < res.length; i++) {
								var el = $("<li onclick=\"insertAutoComplete(" + i + ", 'destination');\">");
								el.addClass("search--airport--li");
								el.append(res[i].name);
								$(".pop--rel--keyword").append(el);
							}
						}
					}).fail(function(error) {
						console.log(error);
					});
				});

	});

	$("#arrival").on("click", function() {
		$("#arrival--id")
			.on(
				"keyup focus change",
				function() {
					let searchName = $("#arrival--id").val().replaceAll(" ", "");
					$("#arrival--id").val(searchName);

					console.log(searchName);

					if (searchName == "") {
						$(".pop--rel--keyword").empty();
						return;
					} else if (searchName.indexOf("\\") != -1) {
						$(".pop--rel--keyword").empty();
						var el = $("<li>검색 결과가 존재하지 않습니다.</li>");
						$(".pop--rel--keyword").append(el);
						return;
					}

					$.ajax({
						type: "GET",
						url: `/search?name=${searchName}`,
						contentType: 'application/json; charset=utf-8'
					}).done(function(res) {
						$(".pop--rel--keyword").empty();

						if (res.length == 0) {
							var el = $("<li>검색 결과가 존재하지 않습니다.</li>");
							$(".pop--rel--keyword").append(el);
						} else {
							for (var i = 0; i < res.length; i++) {
								var el = $("<li onclick=\"insertAutoComplete(" + i + ", 'destination');\">");
								el.addClass("search--airport--li");
								el.append(res[i].name);
								$(".pop--rel--keyword").append(el);
							}
						}
					}).fail(function(error) {
						console.log(error);
					});
				});

	});

	function insertAutoComplete(i) {
		let liValue = $(`.search--airport--li`).eq(i).text();
		$(`.search--airport--li`).val(liValue);
		$(`.search--airport--li`).hide();
	}

	$("#start--modal--btn").on("click", function() {
		insertAutoComplete();
	});

	$("#arrival--modal--btn").on("click", function() {
		insertAutoComplete();
	});

})

