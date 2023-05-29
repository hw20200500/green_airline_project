$(document).ready(function() {

	$(".search--btn").on("click", function() {
		let keyword = $("#keyword").val();
		console.log(keyword);

		if (keyword == null) {
			alert("키워드를 입력하세요.");
		} else {
			location.href = "/faq/faqSearch?keyword=" + keyword;
		}

	});
});

$(document).ready(function() {

	$(".search--btn").on("click", function() {
		let faqList = $(".faq--faqList--wrap").val();
		if (faqList == ' ' || faqList == '') {
			$(".search--btn").attr("type", "button");
		} else {
			$(".search--btn").attr("type", "submit");
		}
	});
});

$(document).ready(function() {
	$(".faq--name--wrap").on("click", function() {
		if($(this).siblings().hasClass("faq--toggle")){
			$(this).siblings().removeClass("faq--toggle");
		} else {
			$(".faq--content--wrap").removeClass("faq--toggle");
			$(this).siblings().addClass("faq--toggle");
		}
	});
});

