$(document).ready(function() {

	$(".search--btn").on("click", function() {
		let keyword = $("#keyword").val();
		console.log(keyword);

		if (keyword == null) {
			alert("키워드를 입력하세요.");
		} else {
			location.href="/notice/noticeSearch?keyword=" + keyword;
		}

	});
});

$(document).ready(function() {
	
	$(".search--btn").on("click", function() {
		let noticeList = $(".notice--noticeList--wrap").val();
		if(noticeList == ' ' || noticeList == ''){
			$(".search--btn").attr("type", "button");
		} else {
			$(".search--btn").attr("type", "submit");
		}
	});
});

