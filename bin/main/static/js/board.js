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
			$(".board--title").text(board.title);
			$(".board--content").text(board.content);
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
		}).fail((error) => {
			console.log(error);
		});
	});
});

// 찜 클릭
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

		// 하트, 빈하트
		// src 이름 꽉찬하트 -> 빈하트
		// 빈하트 -> 꽉찬하트


	}).fail((error) => {
		console.log(error);
	});
});

