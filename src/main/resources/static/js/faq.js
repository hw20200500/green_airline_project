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


	$(".faq--name--wrap").on("click", function() {
		let isChecked = $(".delete--checkbox--class").is(":checked");
		let isOn = $(".btn").val();
		console.log(isOn);
		if(isChecked == false){
			if ($(this).siblings().hasClass("faq--toggle")) {
				$(this).siblings().removeClass("faq--toggle");
			} else {
				$(".faq--content--wrap").removeClass("faq--toggle");
				$(this).siblings().addClass("faq--toggle");
				$(".modal").removeClass("faq--toggle");
			}
		}
	});

	$("#remove--check--btn").on("click", function() {
		let idArr = [];
		$("input:checkbox[name='id']:checked").each(function() {
			idArr.push($(this).val()); // 체크된 것만 값을 뽑아서 배열에 push
			console.log(idArr);
		});

		$.ajax({
			type: "GET",
			url: `/faqDelete?id=${idArr}`,
			contentType: 'application/json; charset=utf-8'
		}).done(function(data) {
			console.log(data);
			for (let i = 0; i < data.length; i++) {
				let faqNode = $("#faq--title--content--wrap" + data[i].id);
				faqNode.remove(faqNode);
			}
		}).fail(function(error) {
			console.log(error);
		});
		location.reload();

	});

});

function updateFaq(id) {
	let faqId = id;
	// 클릭했을 때 titile value, selectbox value, textarea value 갖고오기
	/*let title = $("#faq--modal--title").val();
	let category = $("#faq--modal--category").val();
	let content = $("#faq--modal--content").val();*/

	let data = {
		id: faqId,
		title: $("#faq--modal--title" + faqId).val(),
		categoryId: $("#faq--modal--category" + faqId).val(),
		content: $("#faq--modal--content" + faqId).val()
	};

	$.ajax({
		type: "POST",
		url: `/faqUpdate`,
		contentType: 'application/json; charset=utf-8',
		data: JSON.stringify(data),
		dataType: "json"
	}).done(function(data) {
		console.log("수정 성공")
	}).fail(function(error) {
		console.log(error);
	});
	location.reload();
};



