function deleteBtn(id) {
	
	let baggageReqRequest = {
		"id": id,
		"amount": 0
	}

	$.ajax({
		method: "post",
		url: "/baggageDelete",
		contType: "application/json; charset=utf-8",
		data: baggageReqRequest,
		dataType: 'json'
	}).done(function(data) {
		if (data.statusCode == 400) {
			alert(data.message);
			location.reload();
		} else {
			alert(data.message);
			location.reload();
		}
	}).fail(function(error) {
		console.log(error);
	});
}