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
	// 성별 갖고오기
	if (gender == "M") {
		$(".gender--input").eq(0).prop("checked", "true");
	} else {
		$(".gender--input").eq(1).prop("checked", "true");
	}
})


