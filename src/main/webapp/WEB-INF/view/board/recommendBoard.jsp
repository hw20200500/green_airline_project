<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
.tr--boardList, tr--boardList--title {
	text-align: center;
}
.modal-dialog.modal-fullsize {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}
.modal-content.modal-fullsize {
  height: auto;
  min-height: 100%;
  border-radius: 0; 
}
</style>
<script src="http://code.jquery.com/jquery-1.12.4.js"></script>
<!-- <script type="text/javascript">
// 이미지를 업로드 할 준비를 시작한다.
function temporaryFileUpload(num) {

    // 이미지파일의 정보를 받을 배열을 선언한다.
    var tmpFile = new Object();
    tmpFile['file'] = new Array();     // tmpFile['file'] 파일의 정보를 담을 변수
    tmpFile['img'] = new Array();    // tmpFile['file'] 이미지의 경로를 담을 변수
    var tmpNum = 0;
    var addPlus = 0;

    // 먼저 업로드 된 파일의 존재 유무를 확인한다.
    if(jQuery(".temporaryFile").eq(num).val()) {

        // 파일이 존재하면 우선 기존 파일을 삭제한 이후에 작업을 진행한다.
        if(confirm("해당 이미지를 삭제 하시겠습니까?") == true) {

            // 먼저 업로드 하지 않을 파일을 제거한다.
            jQuery(".temporaryFile").eq(num).val("");

            // 파일이 제거되면 <input type="file"/>의 수만큼 반복문을 돌린다.
            jQuery(".temporaryFile").each(function(idx) {

                // 반복문을 돌리는 중에 <input type="file"/>의 값이 존재한는 순서로 배열에 담는다.
                if(jQuery(".temporaryFile").eq(idx).val()) {
                    tmpFile['file'][tmpNum] = [jQuery(".temporaryFile").eq(idx).clone()];
                    tmpFile['img'][tmpNum] = jQuery(".thumbnailImg").eq(idx).attr("src");
                    tmpNum++;
                }
            });
           
            // 모든 썸네일 이미지 정보를 초기화 한다.
            jQuery(".temporaryFile").val("");
            jQuery(".thumbnailImg").attr("src", "./plusimg.png");
            jQuery(".thumbnailImg").css("display", "none");
           
            // 배열로 받은 파일의 정보를 바탕으로 순서를 재정렬한다.
            for(var key in tmpFile['file']) {
                jQuery(".temporaryFile").eq(key).replaceWith(tmpFile['file'][key][0].clone(true));
                jQuery(".thumbnailImg").eq(key).css("display", "inline");
                jQuery(".thumbnailImg").eq(key).attr("src", tmpFile['img'][key]);
                addPlus++;
            }

            if(addPlus < 5) {
                jQuery(".thumbnailImg").eq(addPlus).css("display", "inline");
            }

        } else {
            return false;
        }
    }
   
    // 파일이 존재하지 않다면 업로드를 시작한다.
    else {

        jQuery(".temporaryFile").eq(num).click();
    }
}

// 임시폴더에 파일을 업로드하고 그 경로를 받아온다.
function temporaryFileTransmit(num) {
    var form = jQuery("#uploadFrom")[0];
    var formData = new FormData(form);
    formData.append("mode", "temporaryImageUpload");
    formData.append("tmpFile", jQuery(".temporaryFile").eq(num)[0].files[0]);
   
    // ajax로 파일을 업로드 한다.
    jQuery.ajax({
          url : "./upload_class.php"
        , type : "POST"
        , processData : false
        , contentType : false
        , data : formData
        , success:function(json) {
            var obj = JSON.parse(json);
            if(obj.ret == "succ") {

                // 업로드된 버튼을 임시폴더에 업로드된 경로의 이미지 파일로 교체한다.
                jQuery(".thumbnailImg").eq(num).attr("src", obj.img);

                // 업로드 버튼이 4개 이하인경우 업로드 버튼을 하나 생성한다.
                if(num < 5) {
                    jQuery(".thumbnailImg").eq(++num).css("display", "inline");
                }

            } else {
                alert(obj.message);
                return false;
            }
        }
    });
}

</script> -->
<main>
	<h1>게시판 화면</h1>
	<div class="container">
		<table class="table table-bordered">
			<c:choose>
				<c:when test="${boardList!=null}">
					<%-- 게시글이 있는 경우 --%>
					<table>
						<tr class="tr--boardList--title">
							<th>번호</th>
							<th>제목</th>
							<th>작성자id</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
						<c:forEach var="board" items="${boardList}">
							<tr class="tr--boardList" data-toggle="modal"
								data-target="#modalDetail" id="boardDetail${board.id}"
								style="cursor: pointer;">
								<td>${board.id}</td>
								<td>${board.title}</td>
								<td>${board.userId}</td>
								<td>${board.viewCount}</td>
								<td>${board.formatDate()}</td>
							</tr>
						</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
					<%-- 게시글이 없는 경우 --%>
					<p>게시물이 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</table>
		<button type="button" class="btn btn-primary"
			onclick="location.href='/board/insert'">글 쓰기</button>
	</div>
</main>

<%-- Modal --%>
<div class="modal fade" id="modalDetail"
	data-backdrop="static" data-keyboard="false" tabindex="-1"
	aria-labelledby="myFullsizeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
		<div class="modal-content modal-fullsize">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">그린에어 여행일지</h5>
				<button type="button" class="close" aria-label="Close"
					data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<%-- 모달 내용 입력 --%>
				<div class="board--title"></div>
				<div class="board--content"></div>
				<div class="board--userId"></div>
				<div class="board--viewCount"></div>
				<!-- 게시물id 가져와서 경로에 넣어주기 -->
				<%
				String boardId = request.getParameter("boardId");
				%>
				<img src="/images/like/like.png" class="board--heartCount"
					id="boardDetail<%=boardId%>"
					style="cursor: pointer; width: 30px; height: 30px;"></img>
				<div class="board--heartCount" id="boardDetail<%=boardId%>"></div>
			</div>
		</div>
	</div>
</div>

<script src="/js/board.js"></script>

<!-- 
=== TODO ===
1. 페이징처리

2-1. 찜 + 조회수 / 게시물 = 높은 숫자 게시물 5개만
상위에 보여주기

2-2 회원만 찜 누를 수 있게하기
// principal이 null이 아닐때만 img태그가 보이게하기
// 비회원은 찜 누르면 로그인창으로

4. 추천순, 조회수 많은순 필터링 기능
-->

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
