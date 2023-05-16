<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<div>
	<main>
		<h1>특별 기내식</h1>

		<div>
			<div>항목 선택</div>
			<select id="inFlightMeals--option">
				<c:forEach var="flightMeals" items="${flightMeals}">
					<option value="${flightMeals.name}">${flightMeals.name}</option>
				</c:forEach>
			</select>
		</div>

		<div id="inFlightMeals--image">
			<img id="meals--image">
		</div>
		<div id="inFlightMeals--description"></div>
		<div id="inFlightMeals--detail"></div>


		<div>
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#special--meal--req">특별 기내식 신청</button>
		</div>

		<!-- The Modal -->
		<div class="modal" id="special--meal--req">
				<div class="modal-dialog">
					<div class="modal-content">
					<form action="/inFlightService/specialMealReq" method="post">
						<!-- Modal Header -->
						<div class="modal-header">
							<div>
								<h4 class="modal-title">특별 기내식 신청</h4>
								<div>*특별 기내식을 신청하지 않으시면 기본 기내식이 제공됩니다.</div>
							</div>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div>종류</div>
							<div class="modal--ifmdName">
								<div id="inFlightMeals--detail"></div>
							</div>
							<div>
								<%-- 수량 인원 수에 맞게 조절할 수 있도록 하기 --%>
								수량<input type="number" name="amount" min="1">
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" id="inflightmeal--request" class="btn btn-primary" data-dismiss="modal">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>

	<script src="/js/inFlightServiceSpecial.js">
		
	</script>

</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>