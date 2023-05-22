$(document).ready(function() {

	let name = $("#baggageMiss--name").val();

	$(".baggageMiss--guide--class").empty();
	$(".baggageMiss--note--class").empty();
	
	$.ajax({
		type: "get",
		contentType: "application/json; charset=utf-8",
		url: `/baggageMiss?name=${name}`
	}).done(function(data) {
		for (let i = 0; i < data.length; i++) {
			let guideNode = $(".baggageMiss--guide--class");
			let noteNode = $(".baggageMiss--note--class");

			guideNode.append(data[i].guide);
			noteNode.append(data[i].note);
		}
	}).fail(function(error) {
		console.log(error);
	});
	

	const buttonArray = $(".buttonArray");

	$.each(buttonArray, function(index, button) {

		$(button).on("click", function() {
			$(".baggageMiss--guide--class").empty();
			$(".baggageMiss--note--class").empty();
			
			let name = $(button).val();
			
			$.ajax({
				type: "get",
				contentType: "application/json; charset=utf-8",
				url: `/baggageMiss?name=${name}`
			}).done(function(data) {
				for (let i = 0; i < data.length; i++) {
					let guideNode = $(".baggageMiss--guide--class");
					let noteNode = $(".baggageMiss--note--class");

					guideNode.append(data[i].guide);
					noteNode.append(data[i].note);
				}
			}).fail(function(error) {
				console.log(error);
			});
		});
	});

});
