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


	$(".search--btn").on("click", function() {
		let faqList = $(".faq--faqList--wrap").val();
		if (faqList == ' ' || faqList == '') {
			$(".search--btn").attr("type", "button");
		} else {
			$(".search--btn").attr("type", "submit");
		}
	});


	$(".faq--name--wrap").on("click", function() {
		if ($(this).siblings().hasClass("faq--toggle")) {
			$(this).siblings().removeClass("faq--toggle");
		} else {
			$(".faq--content--wrap").removeClass("faq--toggle");
			$(this).siblings().addClass("faq--toggle");
		}
	});

	/*$("#faq--update--btn").on("click", function() {
		let id = $("#id").val();
		let titleNode = $(".faq--title--content--wrap");
		let toggleNode = $(".faq--toggle");

		let divNode = $("<div>");
		let inputNode = $("<input>");
		inputNode.remove();

		titleNode.append(divNode);
		divNode.append(inputNode);

		inputNode.attr("type", "text");
		inputNode.attr("name", "title");

		let inputNode2 = $("<input>");
		inputNode2.attr("type", "text");
		inputNode2.attr("name", "content");

		toggleNode.append(divNode);
		$.ajax({
			type: "get",
			url: "/faqUpdate?id=" + id,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {


			console.log(data);
		}).fail(function(error) {
			console.log(error);
		});

	});*/



	/*$("#remove--check--btn").on("click", function() {
		$("")
				
		$.ajax({
			type: "GET",
			url: `/faqDelete?id=${id}`,
			contentType: 'application/json; charset=utf-8'
		}).done(function(data) {
			console.log(data);
		}).fail(function(error) {
			console.log(error);
		});

		if (!confirm("정말로 삭제하시겠습니까?")) {
			return false;
		} else {

		}
	});*/

});

