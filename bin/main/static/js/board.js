let boardList = []; // boardList 변수 정의 및 초기화

// 게시물 목록 상세보기
$(document).ready(function() {
	$(".tr--boardList").on("click", function() {
		let boardId = parseInt($(this).attr("id").split("boardDetail")[1]);

		// boardId 값 경로에 넣어서 controller 타게하기
		$.ajax({
			type: "GET",
			url: `/board/detail/${boardId}`,
			contentType: "application/json; charset=utf-8"
		})
			.done(function(board){
				if ($("#userRole").val() == $("#managerRole").val()) {
					$("#deleteButton").show();
				} else if (board.userId == $("#loginUserId").val()) {
					$("#updateButton").show();
					$("#deleteButton").show();
				}

				// 모달창
				$(".board--title--modal").text(board.title); // 문자열로 값 렌더링 처리
				$(".board--date").text(board.createdAt.substr(0, 10) + " " + board.createdAt.substr(11, 0));
                var textArea = document.createElement('textarea');
                textArea.innerHTML = board.content;
				$(".board--content").html(textArea.value); // 태그들 태그로 인식 처리
				$(".board--userId").text(board.userId);
				$(".board--viewCount").text(board.viewCount); //dto 받아오기?
				$(".board--fileName").text(board.fileName);

				if (board.statement) {
					$(".board--heartCount").attr("src", "/images/like/like.png");
				} else {
					$(".board--heartCount").attr("src", "/images/like/unLike.png");
				}
				$(".board--heartCount").text(board.heartCount);

				// boardId 값 보내기
				$(".board--heartCount").attr("boardId", boardId);

				// update시 수정할 게시물 번호 설정
				$("input[name='boardId']").val(board.id);
			})
			.fail(function(error) {
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
		contentType: "application/json; charset=utf-8"
	})
		.done(function(heartCount) {
			$(".board--heartCount").text(heartCount);

			if ($(".board--heartCount").attr("src") == "/images/like/unLike.png") {
				$(".board--heartCount").attr("src", "/images/like/like.png");
			} else {
				$(".board--heartCount").attr("src", "/images/like/unLike.png");
			}
		})
		.fail(function(error) {
			console.log(error);
		});
});

// 파일 다운로드
const button = document.getElementById('fileDown');

button.addEventListener('click', () => {
    let boardId = $("input[name='boardId']").val();
    let fileName = document.querySelector('.board--fileName').innerText.trim(); //240905 수정

    // URL에 쿼리 파라미터를 추가합니다.
    const url = new URL('/board/download', window.location.origin);
    url.searchParams.append('id', boardId);
    url.searchParams.append('fileName', fileName);

    fetch(url, { // 수정된 URL 사용
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('네트워크 응답에 문제가 있습니다: ' + response.statusText);
        }

        // 서버에서 파일 이름을 포함한 Content-Disposition 헤더를 읽어옵니다.
        const disposition = response.headers.get('Content-Disposition');
        let fileName = 'downloaded-file'; // 기본 파일 이름
        if (disposition && disposition.indexOf('attachment') !== -1) {
            const fileNameMatch = disposition.match(/filename="(.+?)"/);
            if (fileNameMatch != null && fileNameMatch[1]) {
                fileName = fileNameMatch[1];
            }
        }

        return response.blob().then(blob => ({ fileName, blob }));
    })
    .then(({ fileName, blob }) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = fileName; // 서버에서 제공한 파일 이름을 설정
        document.body.appendChild(a);
        a.click();
        a.remove();
        window.URL.revokeObjectURL(url); // 메모리 해제
    })
    .catch(error => {
        console.error('API 호출 중 오류 발생:', error); // 오류 처리
    });
});


// 게시글 수정
$(document).ready(function() {
	$("#updateButton").on("click", function() {
		let boardId = $("input[name='boardId']").val();
		location.href = `/board/update/${boardId}`;
	});
});

// 게시글 삭제
$(document).ready(function() {
	$("#deleteButton").on("click", function() {
		let boardId = $("input[name='boardId']").val();
		let deleteConfirm = confirm("정말 삭제하시겠습니까?");
		if (deleteConfirm) {
			location.href = `/board/delete/${boardId}`;
		} else {
			return false;
		}
	});
});

