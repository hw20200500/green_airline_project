$(document).ready(function() {

	$("#free--baggage--id").on("change", function() {
		let section = $("#free--baggage--id").val();
		$(".checkedBaggages--empty--class").empty();

		$.ajax({
			type: "get",
			contentType: "application/json; charset=utf-8",
			url: `/freeBaggage?section=${section}`
		}).done(function(data) {

			for (let i = 0; i < data.length; i++) {
				let tdNode = $("<td>");
				let tdNode2 = $("<td>");
				$(".checkedBaggages--all--class" + i).append(tdNode);
				$(".checkedBaggages--all--class" + i).append(tdNode2);
				tdNode.append(data[i].gradeId);
				tdNode2.append(data[i].freeAllowance);
			}

		}).fail(function() {

		});
	});

});

