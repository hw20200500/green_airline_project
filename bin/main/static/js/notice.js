$(document).ready(function() {

	$(".search--btn").on("click", function() {
		let keyword = $("#keyword").val().replaceAll(" ", "");

		if (keyword == "") {
			return false;
		}
	});

	/* 엔터키 누르면 공백 검색 안되도록 막기*/
	$("#keyword").on("keyup", function(e) {
		let keyword = $("#keyword").val().replaceAll(" ", "");

		if (e.keyCode == '13') {

			if (keyword == "") {
				e.preventDefault();
			}
		}

	});
});

