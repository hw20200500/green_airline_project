
$(document).ready(function() {

	$(".search--btn").on("click", function() {
		let keyword = $(".search--btn input[name='keyword']").val();

		if (keyword == null) {
			alert("키워드를 입력하세요.");
			return false;
		}

	});
});

