<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<style>
</style>
<div>
	<main>
		<h1>기내 서비스 조회 페이지</h1>
		<div>
			<form action="/inFlightService/inFlightServiceSearch" method="post">
				<div>
					기내 서비스 조회 <input type="text" name="keyword" id="start--search">
					<button type="submit">검색</button>
				</div>
				<div>출/도착지를 입력하여 상세 정보를 확인해 보세요.</div>
				<div>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#start">출발지</button>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#arrival">도착지</button>
				</div>
				<!-- The Modal -->
				<div class="modal fade" id="start">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">출발지 검색</h4>
								<button type="button" class="close" data-dismiss="modal">×</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">
								<input type="text" autocomplete="on" id="start--search" name="" placeholder="도시, 공항">
								<div class="rel--search">
									<ul class="pop--rel--keyword"></ul>
								</div>
							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>

						</div>
					</div>
				</div>

				<!-- The Modal -->
				<div class="modal fade" id="arrival">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">도착지 검색</h4>
								<button type="button" class="close" data-dismiss="modal">×</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">
								<input type="text" name="" placeholder="도시, 공항">
							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>

						</div>
					</div>
				</div>

			</form>
		</div>
	</main>

</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
