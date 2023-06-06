<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
main {
	text-align: center;
	border: 1px solid #ccc;
}

.title {
	text-align: center;
	margin-top: 10px;
}

.form-control {
	margin-left: 320px;
	text-align: center;
	width: 550px;
	background-color: rgb(243, 243, 243);
	border: none;
}

.btn {
	width: 550px;
	margin-left: 10px;
	margin-top: 30px;
}

.findId {
	margin-top: 50px;
	margin-left: 320px;
	background-color: rgb(243, 243, 243);
	width: 550px;
	height: 100px;
	padding: 30px;
}

</style>

<!-- 여기 안에 쓰기 -->
<main>
	<div>
		<h2 class="title">
			<a href="/userIdSearch">아이디 찾기</a>
			&nbsp;ㅣ&nbsp;
			<a href="/userPwSearch">비밀번호 찾기</a>
		</h2>

		<form action="">
			<div class="form-group">
				<label for="id">id:</label> <input type="text" class="form-control" id="id" value="abc" name="id"> <label for="email">email:</label> <input type="text" class="form-control" id="email"
					value="ekdns8276@naver.com" name="email">
			</div>
		</form>
		<button id="findPassword" class="btn btn-light">전송</button>
		<div class="form-group" id="checkCode" style="display: none;">
			<label for="code">인증 확인:</label> <input type="text" class="form-control" id="code" value="" name="code">
			<button id="codeCheck" class="btn btn-light">인증</button>
		</div>
		<div id="passwordInput" style="display: none;">
			<form action="updatePassword" method="post" id="updateForm">
				<label>변경 할 비밀번호:</label> <input type="password" class="form-control" id="password" value="wjdekdns" name="password"> <label for="checkPassword">비밀번호 확인:</label> <input type="password"
					class="form-control" id="checkPassword" value="wjdekdns" name="checkPassword"> <input type="hidden" id="userId" name="userId">
				<button id="updatePwBtn" class="btn btn-light">변경하기</button>
			</form>
		</div>
	</div>
</main>
<script type="text/javascript">
	$("#findPassword").on("click", function() {
		let form = $("form").serialize();

		$.ajax({
			url : "/searchId?" + form,
			type : "get",
			dataType : "text"
		}).done(function(response1) {
			console.log("response1: " + response1);
			$("#password").attr('type', 'text');
			$("#id").attr('readonly', 'readonly');
			$("#email").attr('readonly', 'readonly');
			$("#findPassword").attr("disabled", true);
			if (response1 == 0) {
				$.ajax({
					url : "/sendNewPw?" + form,
					type : "get",
					dataType : 'text'

				}).done(function(response) {
					$("#checkCode").show();
					$("#codeCheck").on("click", function() {
						let writeCode = $("#code").val();
						if (response == writeCode) {
							$("#passwordInput").show();
							$("#code").attr('readonly', 'readonly');
							$("#codeCheck").attr("disabled", true);
							let id = $("#id").val();
							$("#userId").val(id);
						} else {
							alert("인증 코드를 확인하세요");
						}
					});
				}).fail(function(error) {
					alert("서버오류");
				});
			} else {
				alert("아이디를 확인하세요");
				location.reload();
			}
		}).fail(function(error) {
			alert("서버 오류");
		});
	});

	$("#updateForm").on("submit", function(e) {
		let checkPassword = $("#checkPassword").val();
		let password = $("#password").val();
		if (password != checkPassword) {
			e.preventDefault();
			alert("비밀번호가 다릅니다");
		}
	});
</script>
<input type="hidden" name="menuName" id="menuName" value="">
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
