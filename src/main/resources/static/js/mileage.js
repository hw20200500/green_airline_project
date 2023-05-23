$(document).ready(function() {



	$("#checkboxList #mileageType0").on("click", function() {
		let chk = $("input[type=checkbox]")
		if ($(this).is(":checked")) {
			chk.prop("checked", true);
		} else {
			chk.prop("checked", false);
		}
	});

	$("#searchType2").on("click", function() {

		if ($('#dd_period_detail').is(':visible') == true) {
			$('#dd_period_detail').hide();
		}
	});
	$("#searchType1").on("click", function() {

		if ($('#dd_period_detail').is(':visible') == false) {
			$('#dd_period_detail').show()
		}
	});

	$('#liPeriod1').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 1)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);

	});
	$('#liPeriod3').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 3)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);
	});
	$('#liPeriod6').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 6)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);
	});
	$('#liPeriod12').on("click", function() {

		let today = new Date();
		let todayStart = new Date();
		todayStart.setMonth(todayStart.getMonth() - 12)
		let year = today.getFullYear();
		let year2 = todayStart.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let month2 = ('0' + (todayStart.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		let dateString = year + '-' + month + '-' + day;
		let dateString2 = year2 + '-' + month2 + '-' + day;
		$("#sCalendar02").val(dateString);
		$("#sCalendar01").val(dateString2);
	});
	$("#liPeriods").on("click", function() {
	
		$("#sCalendar01").val("");
		$("#sCalendar02").val("");
	});

	$('#mileage--search').on("click", function() {
		let form = $("form").serialize();
		console.log(form);
		$.ajax({
			url: "/api/selectMileageListProc?"+form,
			type: "get",
			
		}).done(function(response) {
			console.log(response);
			console.log(response[0].saveDate)
		    
			for(i = 0; i < response.length; i++){
			let a = response[i].saveMileage;
			let b =+ a;
			console.log(b)	
			}
		}).fail(function(error) {
			alert("서버오류");
		});
	});


});



