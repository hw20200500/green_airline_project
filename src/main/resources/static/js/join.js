$(function() {
	/* console.log(dateString2); */

	$("#datepicker").datepicker(
		{
			dateFormat: "yy-mm-dd",
			changeMonth: true,
			changeYear: true,
			yearRange: '1900:2023',
			onSelect: function() {
				let date = $.datepicker.formatDate("yy-mm-dd", $(
					"#datepicker").datepicker("getDate"));
			}
		});

});

// 다음 우편주소 api
function execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("detailAddress").focus();
		}
	}).open();
}


$(document).ready(function() {

	let isCheck = 0;


	// 아이디 중복 확인 기능
	$("#exists--id").on("click", function() {
		let id = $("#member--id").val();
		console.log(isCheck);

		console.log(id.length)
		if (id.length <= 20 && id.length >= 7) {
			if (id == ' ' || id == '') {
				alert("잘못된 입력값입니다.");
			} else {
				$.ajax({
					type: "get",
					url: "/existsById?id=" + id,
					contentType: "application/json; charset=utf-8"
				}).done(function(data) {
					console.log(isCheck);
					if (data) {
						alert("사용 가능한 아이디입니다.");
						isCheck = 1;
					} else {
						alert("중복된 아이디입니다.");
						$("#member--id").focus();
						isCheck = 0;
					}
				}).fail(function(error) {
					console.log(error);
				});
			}
		} else {
			alert("아이디는 7자 이상 20자 이하로 입력해주세요.");
		}

		// 컨트롤러를 찍지 않고 공백 검사

	});

	$("#join--btn").on("click", function() {
		if (isCheck == 1) {
		} else {
			console.log("11112321312312321312");
			alert("아이디 중복 확인을 해주세요.");
			location.reload();
			return false;
		}
		
		
	});

	$("#member--id").on("keyup", function() {
		isCheck = 0;
	});

	// 비밀번호 확인 기능
	$("#password--check").on("keyup focus change", function() {
		let password = $("#password").val();
		let passwordCheck = $("#password--check").val();
		let passwordWrap = $(".password--wrap");
		let divNode = $("<div>");
		let divNode2 = $("<div>");
		divNode.attr("class", "validation--check");
		divNode2.attr("class", "password--validation");

		if (password != passwordCheck) {
			$(".validation--check").empty();
			$(".password--validation").empty();
			divNode.text("비밀번호가 일치하지 않습니다.");
			passwordWrap.append(divNode);
		} else {
			if (password == ' ' || password == '') {
				$(".validation--check").empty();
				$(".password--validation").empty();
			} else {
				$(".validation--check").empty();
				$(".password--validation").empty();
				divNode2.text("비밀번호가 일치합니다.");
				passwordWrap.append(divNode2);
				console.log(password);
			}
		}
	});

	// 성별 갖고오기
	if (gender == "M") {
		$(".gender--input").eq(0).prop("checked", "true");
	} else {
		$(".gender--input").eq(1).prop("checked", "true");
	}


});
