$(function() {
    $("#datepicker").datepicker({
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:2023',
        onSelect: function() {
            let date = $.datepicker.formatDate("yy-mm-dd", $("#datepicker").datepicker("getDate"));
            // 필요한 경우 이 date 값을 사용하세요.
            console.log(date);
        }
    });
});

// 다음 우편주소 api
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옵니다.
            if (data.userSelectedType === 'R') { // 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣습니다.
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동합니다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

$(document).ready(function() {

    let isCheck = 0;

    // 아이디 중복 확인 기능
    $("#exists--id").on("click", function() {
        let id = $("#member--id").val().trim(); // 공백 제거
        console.log("Checking ID:", id);
        console.log("Initial isCheck value:", isCheck);

        if (id.length >= 7 && id.length <= 20) {
            if (id === '') {
                alert("잘못된 입력값입니다.");
            } else {
                $.ajax({
                    type: "get",
                    url: "/existsById?id=" + encodeURIComponent(id),
                    contentType: "application/json; charset=utf-8"
                }).done(function(data) {
                    console.log("isCheck value after request:", isCheck);
                    if (data) {
                        alert("사용 가능한 아이디입니다.");
                        isCheck = 1;
                    } else {
                        alert("중복된 아이디입니다.");
                        $("#member--id").focus();
                        isCheck = 0;
                    }
                }).fail(function(error) {
                    console.log("AJAX error:", error);
                });
            }
        } else {
            alert("아이디는 7자 이상 20자 이하로 입력해주세요.");
        }
    });

    $("#join--btn").on("click", function() {
        if (isCheck === 1) {
            // 폼 제출이 가능할 때의 동작
        } else {
            console.log("11112321312312321312");
            alert("아이디 중복 확인을 해주세요.");
            location.reload(); // 페이지 새로고침
            return false;
        }
    });

    $("#member--id").on("keyup", function() {
        isCheck = 0;
    });

    // 비밀번호 확인 기능
    $("#password--check").on("keyup focus change", function() {
        let password = $("#password").val().trim(); // 공백 제거
        let passwordCheck = $("#password--check").val().trim(); // 공백 제거
        let passwordWrap = $(".password--wrap");

        $(".validation--check").remove();
        $(".password--validation").remove();

        if (password !== passwordCheck) {
            $("<div>")
                .addClass("validation--check")
                .text("비밀번호가 일치하지 않습니다.")
                .appendTo(passwordWrap);
        } else if (password.length > 0 && passwordCheck.length > 0) {
            $("<div>")
                .addClass("password--validation")
                .text("비밀번호가 일치합니다.")
                .appendTo(passwordWrap);
        }
    });

    // 성별 갖고오기
    if (typeof gender !== 'undefined') {
        if (gender === "M") {
            $(".gender--input").eq(0).prop("checked", true);
        } else if (gender === "F") {
            $(".gender--input").eq(1).prop("checked", true);
        }
    }
});
