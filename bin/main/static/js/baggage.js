$(document).ready(function() {
	$("#carryOnLiquids--select--box").on("change", function() {
		let nameVal = $("#carryOnLiquids--select--box").val();
		console.log(nameVal);
		$.ajax({
			type: "get",
			url: "/limitLiquids?name=" + nameVal,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {
			$("#carryOnLiquids--name--id").text(data.name +"의 조회 결과입니다.");
			$("#carryOnLiquids--target--id").html(data.target);
			$("#carryOnLiquids--limitGuide--id").html(data.limitGuide);
			$("#carryOnLiquids--taxFreeGuide--id").html(data.taxFreeGuide);
		}).fail(function(error) {
			console.log(error);
		});
	});

});

