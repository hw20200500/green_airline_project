
$("#start").on("click", function() {
	$("#departure")
		.on(
			"keyup focus change",
			function() {
				let searchName = $("#departure").val().replaceAll(" ", "");
				$("#departure").val(searchName);

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
							var el = $("<li onclick=\"insertAutoComplete(" + i + ", 'departure');\">");
							el.addClass("departure--airport--li");
							el.append(res[i].name);
							$(".pop--rel--keyword").append(el);
						}
					}
				}).fail(function(error) {
					console.log(error);
				});
			});

});



$("#destination").on("click", function() {
	$("#destination")
		.on(
			"keyup focus change",
			function() {
				let searchName = $("#destination").val().replaceAll(" ", "");
				$("#destination").val(searchName);

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
							el.addClass("destination--airport--li");
							el.append(res[i].name);
							$(".pop--rel--keyword").append(el);
						}
					}
				}).fail(function(error) {
					console.log(error);
				});
			});

});


function insertAutoComplete(i, target) {
	let liValue = $(`.${target}--airport--li`).eq(i).text();
	$(`#${target}`).val(liValue);
	$(`.${target}--airport--li`).hide();
}

$("#start--modal--btn").on("click", function() {
	let departureVal = $("#departure").val();
	$("#modal--departure--btn--id").text(departureVal);

	/* .departure--airport--li를 클릭했을 때 상태 값을 주고
	input에 글자가 없으면 경고창 띄우기 */

	/*if($(".departure--airport--li").text() == null && $("#departure").text() == null){
		alert("ㅁㄴㅇㄹ");
	}*/
});


$("#arrival--modal--btn").on("click", function() {
	let destinationVal = $("#destination").val();
	$("#modal--destination--btn--id").text(destinationVal);
});

/*$('.modal').on('hidden.bs.modal', function(e) {
	console.log('modal close');
	$(this).find('form')[0].reset();
});
*/

/* 기내 서비스 조회 버튼 클릭 시 ajax */
/* 노선 정보를 갖고 와서 해야 함. */
$("#modal--select--btn--id").on("click", function() {
	let destination = $("input[name=destination]").val();
	let departure = $("input[name=departure]").val();
	$("#destination--res--id").empty();

	$.ajax({
		type: "GET",
		url: `/searchRoute?destination=${destination}&departure=${departure}`,
		contentType: 'application/json; charset=utf-8'
	}).done(function(data) {
		/* 노선 테이블에 입력한대로 조회하면 잘 나옴 */
		let departureResId = $("#departure--res--id");
		let destinationResId= $("#destination--res--id");

		for (let i = 0; i < data.length; i++) {
			let imgNode = $("<img>");
			imgNode.attr("src", "/images/in_flight/"+data[i].detailImage);
			destinationResId.append(data[i].name);
			destinationResId.append(imgNode);
			destinationResId.append(data[i].description);
			
			/*console.log(data[i]);
			destinationResId.append(data[i].name);
			destinationResId.append(data[i].detailImage);
			destinationResId.append(data[i].description);*/
		}
		
	}).fail(function(error) {
		console.log(error);
	});
})

// 전체 공항 조회 버튼
$(".all--airport").on("click", function() {
	/*$(".all--airport--modal").modal();*/
	if ($(this).is(".destination--button")) {
		$(".all--airport--modal").addClass("dest");
		$(".all--airport--modal").removeClass("depa");
		$(".modal--title").text("도착지 선택");
	} else if ($(this).is(".departure--button")) {
		$(".all--airport--modal").addClass("depa");
		$(".all--airport--modal").removeClass("dest");
		$(".modal--title").text("출발지 선택");
	}
});

// 지역 선택하면 해당하는 취항지 출력
$(".region--li").on("click", function() {
	$(this).addClass("region--li--selected");
	$(this).siblings().removeClass("region--li--selected");

	let region = $(this).text();
	$.ajax({
		type: "GET",
		url: `/airport/list?region=${region}`,
		contentType: "application/json; charset=UTF-8"

	}).done((res) => {
		$(".airport--ul").empty();

		if ($(".all--airport--modal").is(".depa")) {
			for (var i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertAirport(" + i + ", 'departure');\">");
				el.addClass("departure--airport--li");
				el.append(res[i].name);
				$(".airport--ul").append(el);
			}
		} else if ($(".all--airport--modal").is(".dest")) {
			for (var i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertAirport(" + i + ", 'destination');\">");
				el.addClass("destination--airport--li");
				el.append(res[i].name);
				$(".airport--ul").append(el);
			}
		}

	}).fail((error) => {
		console.log(error);
	});


});
