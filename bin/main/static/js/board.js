// 게시물 목록 상세보기
$(document).ready(function() {
	$(".tr--boardList").on("click", function() {
		let boardId = parseInt($(this).attr("id").split("boardDetail")[1]);
		let date = ($(this).children().eq(4));

		// boardId 값 경로에 넣어서 controller 타게하기
		$.ajax({
			type: "GET",
			url: `/board/detail/${boardId}`,
			contentType: 'application/json; charset=utf-8'
		}).done((board) => {
			// 모달창
			$(".board--title").text(board.title); // 문자열로 값 렌더링 처리 
			$(".board--content").html(board.content); // 태그들 태그로 인식 처리
			$(".board--userId").text(board.userId);
			$(".board--viewCount").text(board.viewCount);
			if (board.statement) {
				$(".board--heartCount").attr("src", '/images/like/like.png');
			} else {
				$(".board--heartCount").attr("src", '/images/like/unLike.png');
			}
			$(".board--heartCount").text(board.heartCount);
			$(".board--date").text(date.text());

			// boardId 값 보내기
			$(".board--heartCount").attr("boardId", boardId);

			// update시 수정할 게시물 번호 설정
			$("input[name=\"boardId\"]").val(board.id);

		}).fail((error) => {
			console.log(error);
		});
	});
});

// 좋아요 클릭
$(document).on("click", ".board--heartCount", function() {
	let boardId = parseInt($(this).attr("boardId"));

	$.ajax({
		type: "POST",
		url: `/board/detail/${boardId}`,
		contentType: 'application/json; charset=utf-8'
	}).done((heartCount) => {
		$(".board--heartCount").text(heartCount);

		if ($(".board--heartCount").attr("src") == "/images/like/unLike.png") {
			$(".board--heartCount").attr("src", '/images/like/like.png');
		} else {
			$(".board--heartCount").attr("src", '/images/like/unLike.png');
		}

	}).fail((error) => {
		console.log(error);
	});
});

// 게시글 수정
$(document).ready(function() {
	$("#updateButton").on("click", function() {
		let boardId = $("input[name=\"boardId\"]").val();

		location.href = `/board/update/${boardId}`;

	});
});

// 게시글 삭제
$(document).ready(function() {
	$("#deleteButton").on("click", function() {
		let boardId = $("input[name=\"boardId\"]").val();

		location.href = `/board/delete/${boardId}`;

	});
});