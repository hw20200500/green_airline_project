
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
					let el = $("<li>검색 결과가 존재하지 않습니다.</li>");

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
						let el = $("<li class='search--airport--li'>검색 결과가 존재하지 않습니다.</li>");
						$(".pop--rel--keyword").append(el);
					} else {
						for (let i = 0; i < res.length; i++) {
							let el = $("<li onclick=\"insertAutoComplete(" + i + ", 'departure');\">");
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
					let el = $("<li>검색 결과가 존재하지 않습니다.</li>");
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
						let el = $("<li>검색 결과가 존재하지 않습니다.</li>");
						$(".pop--rel--keyword").append(el);
					} else {
						for (let i = 0; i < res.length; i++) {
							let el = $("<li onclick=\"insertAutoComplete(" + i + ", 'destination');\">");
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

	$.ajax({
		type: "GET",
		url: `/searchRoute?destination=${destination}&departure=${departure}`,
		contentType: 'application/json; charset=utf-8'
	}).done(function(data) {
		// json 형식 받고 --> js object 
		console.log(data);

		if (data.statusCode == 400) {
			alert("노선 정보가 없습니다.");
			window.location.reload();
		} else {
			/*let destinationTitle = $("#destination--res--title");
			let destinationImg = $("#destination--res--img");
			let destinationContent = $("#destination--res--content");*/
			let destinationWrap = $("#destination--res--wrap");
			for (let i = 0; i < data.length; i++) {
				let destinationDivTag = $("<div>");
				destinationDivTag.attr("class", "destination--div--wrap")
				let destinationImg = $("<div>");
				let destinationContent = $("<div>");
				let titleDataTag = $("<div>");
				titleDataTag.attr("class", "title--data--tag");
				
				let titleImageTag = $("<img>");
				titleImageTag.attr("src", "/images/in_flight/"+data[i].iconImage);
				titleImageTag.attr("style", "width: 30px; height: 30px;");
				/*titleImageTag.attr("class", "titleImageTag--class");*/
				titleDataTag.append(titleImageTag);
				
				let contnetDataTag = $("<div>");
				contnetDataTag.attr("class", "content--data--tag");
				
				
				destinationImg.attr("class", "destination--res--img");
				destinationContent.attr("class", "destination--res--content");

				let imgNode = $("<img>");
				imgNode.attr("src", "/images/in_flight/" + data[i].detailImage);
				imgNode.attr("style", "width: 500px; height: 300px;");

				destinationImg.append(imgNode);
				titleDataTag.append(data[i].name);
				contnetDataTag.append(data[i].description);
				destinationContent.append(titleDataTag);
				destinationContent.append(contnetDataTag);
				
				destinationDivTag.append(destinationImg);
				destinationDivTag.append(destinationContent);
				destinationWrap.append(destinationDivTag);
			}
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
			for (let i = 0; i < res.length; i++) {
				let el = $("<li onclick=\"insertDepartureAirportClass(" + i + ");\">");
				el.addClass("departure--airport--li--class");
				el.append(res[i].name);
				$(".departure--airport--ul").append(el);
				console.log(res[i].name);
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
			for (let i = 0; i < res.length; i++) {
				let el = $("<li onclick=\"insertDestinationAirportClass(" + i + ");\">");
				el.addClass("destination--airport--li--class");
				el.append(res[i].name);
				$(".destination--airport--ul").append(el);
			}
		}

	}).fail((error) => {
		console.log(error);
	});

});


function insertDepartureAirportClass(i) {
	let liValue = $(`.departure--airport--li--class`).eq(i).text();
	$(`.departure--airport--li--class`).eq(i).addClass("departure--region--li--selected");
	$(`.departure--airport--li--class`).eq(i).siblings().removeClass("departure--region--li--selected");
	$(`#departure`).val(liValue);
}

function insertDepartureAirport(i) {
	let liValue = $(`.departure--airport--li`).eq(i).text();
	$(`.departure--airport--li`).eq(i).addClass("departure--region--li--selected");
	$(`.departure--airport--li`).eq(i).siblings().removeClass("departure--region--li--selected");
	$(`#departure`).val(liValue);
}

function insertDestinationAirport(i) {
	let liValue = $(`.destination--airport--li`).eq(i).text();
	$(`.destination--airport--li`).eq(i).addClass("destination--region--li--selected");
	$(`.destination--airport--li`).eq(i).siblings().removeClass("destination--region--li--selected");
	$(`#destination`).val(liValue);
}
function insertDestinationAirportClass(i) {
	let liValue = $(`.destination--airport--li--class`).eq(i).text();
	$(`.destination--airport--li--class`).eq(i).addClass("destination--region--li--selected");
	$(`.destination--airport--li--class`).eq(i).siblings().removeClass("destination--region--li--selected");
	$(`#destination`).val(liValue);
}

function changeValue() {
	let departure = $("#modal--departure--btn--id");
	let destination = $("#modal--destination--btn--id");
	let departureValue = $("#modal--departure--btn--id").text();
	let destinationValue = $("#modal--destination--btn--id").text();
	let destinationInputTag = $("#destination");
	let departureInputTag = $("#departure");
	let tempValue;
	tempValue = departureValue;
	departureInputTag.val(destinationValue);
	destinationInputTag.val(tempValue);
	departure.text(destinationValue);
	destination.text(tempValue);
};

