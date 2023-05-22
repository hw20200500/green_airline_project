// 게시물 목록 상세보기
$(document).ready(function() {
	// 테이블 내 행이 클릭되면 이벤트 발생
	$(".tr--boardList").on("click", function() {
		// 클릭된 행의 id 이름을 가져옴
		// $(this)는 이벤트가 발생한 대상 자체를 가리킴
		// id 이름에서 board.id만 가져옴
		let boardId = parseInt($(this).attr("id").split("boardDetail")[1]);
		let date = ($(this).children().eq(4));
		// boardId 값 들고와서 경로에 넣어서 controller 타게하기

		$.ajax({
			type: "GET",
			url: `/board/detail/${boardId}`,
			contentType: 'application/json; charset=utf-8'
		}).done((board) => {
			$(".board--title").text(board.title);
			$(".board--content").text(board.content);
			$(".board--userId").text(board.userId);
			$(".board--viewCount").text(board.viewCount);
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
	console.log(boardId);

	$.ajax({
		type: "POST",
		url: `/board/detail/${boardId}`,
		contentType: 'application/json; charset=utf-8'
	}).done((board) => {
		// 하트, 빈하트
	}).fail((error) => {
		console.log(error);
	});
});

