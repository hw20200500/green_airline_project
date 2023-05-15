<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- Modal --%>
<form action="/board/detail/{i}" method="post">
	<div class="modal fade" id="modalDetailSelect" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">디테일한 여행 일지</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<%-- 모달 내용 입력 --%>
					<table class="table">
						<thead>
							<tr>
								<th>제목</th>
							</tr>
							<tr>
								<th>내용</th>
							</tr>
							<tr>
								<th>작성자 id</th>
								<th>조회수</th>
								<th>작성 날짜</th>
							</tr>
						</thead>
						<tbody>
							<%-- <c:choose>
								<c:when test="${boardList}">
									<tr>
										<th>${board.title}</th>
									</tr>
									<tr>
										<th>${board.content}</th>
									</tr>
									<tr>
										<th>${board.userId}</th>
										<th>${board.viewCount}</th>
										<th>${board.formatDate()}</th>
									</tr>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose> --%>

							<c:forEach var="board" items="${boardList}">
								<tr>
									<th>${board.title}</th>
								</tr>
								<tr>
									<th>${board.content}</th>
								</tr>
								<tr>
									<th>${board.userId}</th>
									<th>${board.viewCount}</th>
									<th>${board.formatDate()}</th>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</form>

