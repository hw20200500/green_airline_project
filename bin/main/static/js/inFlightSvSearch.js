
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
});


$("#arrival--modal--btn").on("click", function() {
	let destinationVal = $("#destination").val();
	$("#modal--destination--btn--id").text(destinationVal);
});

/* 기내 서비스 조회 버튼 클릭 시 ajax */
/* 노선 정보를 갖고 와서 해야 함. */
$("#modal--select--btn--id").on("click", function() {
	let destination = $("input[name=destination]").val();
	let departure = $("input[name=departure]").val();
	$("#destination--res--id").empty();
	console.log(destination);
	console.log(departure);
	$.ajax({
		type: "GET",
		url: `/searchRoute?destination=${destination}&departure=${departure}`,
		contentType: 'application/json; charset=utf-8'
	}).done(function(data) {
		/* 노선 테이블에 입력한대로 조회하면 잘 나옴 */
		let destinationResId = $("#destination--res--id");

		for (let i = 0; i < data.length; i++) {
			let imgNode = $("<img>");
			imgNode.attr("src", "/images/in_flight/" + data[i].detailImage);
			destinationResId.append(data[i].name);
			destinationResId.append(imgNode);
			destinationResId.append(data[i].description);

		}

	}).fail(function(error) {
		console.log(error);
	});
})

// 전체 공항 조회 버튼
$(".all--departure--airport--modal").on("click", function() {
	$(".all--departure--airport--modal").addClass("depa");
});

$(".all--destination--airport--modal").on("click", function() {
	$(".all--destination--airport--modal").addClass("dest");
});



// 지역 선택하면 해당하는 취항지 출력
$(".departure--region--li").on("click", function() {
	$(this).addClass("region--li--selected");
	$(this).siblings().removeClass("region--li--selected");

	let region = $(this).text();
	$.ajax({
		type: "GET",
		url: `/airport/list?region=${region}`,
		contentType: "application/json; charset=UTF-8"

	}).done((res) => {
		$(".departure--airport--ul").empty();

		if ($(".all--departure--airport--modal").is(".depa")) {
			for (var i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertDepartureAirport(" + i + ");\">");
				el.addClass("departure--airport--li");
				el.append(res[i].name);
				$(".departure--airport--ul").append(el);
			}
		}
	}).fail((error) => {
		console.log(error);
	});

});


$(".destination--region--li").on("click", function() {
	$(this).addClass("region--li--selected");
	$(this).siblings().removeClass("region--li--selected");

	let region = $(this).text();
	$.ajax({
		type: "GET",
		url: `/airport/list?region=${region}`,
		contentType: "application/json; charset=UTF-8"

	}).done((res) => {
		$(".destination--airport--ul").empty();

		if ($(".all--destination--airport--modal").is(".dest")) {
			for (var i = 0; i < res.length; i++) {
				var el = $("<li onclick=\"insertDestinationAirport(" + i + ");\">");
				el.addClass("destination--airport--li");
				el.append(res[i].name);
				$(".destination--airport--ul").append(el);
			}
		}

	}).fail((error) => {
		console.log(error);
	});

});


function insertDepartureAirport(i) {
	let liValue = $(`.departure--airport--li`).eq(i).text();
	$(`.departure--airport--li`).eq(i).addClass("departure--region--li--selected");
	$(`.departure--airport--li`).eq(i).siblings().removeClass("departure--region--li--selected");
	$(`#departure`).val(liValue);
}

function insertDestinationAirport(i) {
	let liValue = $(`.destination--airport--li`).eq(i).text();
	console.log($(`.destination--airport--li`).eq(i));
	$(`.destination--airport--li`).eq(i).addClass("destination--region--li--selected");
	$(`.destination--airport--li`).eq(i).siblings().removeClass("destination--region--li--selected");
	$(`#destination`).val(liValue);
}


