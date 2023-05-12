/*
$(document).ready(function() {

	$(".search--btn").on("click", function() {
		let keyword = $("#keyword").val();
		let data = {
			keyword: $("#keyword").val()
		};

		if (keyword == null) {
			alert("키워드를 입력하세요.");
		} else {
			$.ajax({
				type: "GET",
				contentType: "application/json; charset=utf-8",
				url: "/notice/noticeSearch",
				data: JSON.stringify(data),
				dataType: "JSON"
			}).done(function(res) {
				console.log(res);
			}).fail(function(error) {
				console.log(error);
			});
		}

	});
});*/

