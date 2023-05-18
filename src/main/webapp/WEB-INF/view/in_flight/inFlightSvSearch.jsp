<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
	integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
#departure, #arrival--id {
	margin-top: 10px;
	font-size: 25px;
	border: none;
	border-bottom: 2px solid black;
	padding-bottom: 5px;
}

/* input::placeholder{
	text-align: center;
} */
.pop--rel--keyword li {
	margin-top: 10px;
	font-size: 25px;
}

.search--airport--li {
	margin-top: 10px;
	font-size: 25px;
}

.modal-body {
	display: flex;
	flex-direction: column;
	height: 500px;
}

.modal-footer {
	display: flex;
	justify-content: space-between;
}

.search--airport--li:hover {
	cursor: pointer;
}

.datepicker {
	border: none;
}

.all--btn--class {
	background-color: white;
	color: black;
	border: 1px solid white;
	width: 200px;
	height: 100px;
	justify-content: space-between;
}

.search--btn--class {
	justify-content: space-between;
}

.modal--all--btn--div {
	display: flex;
	border: 1px solid #ebebeb;
	justify-content: space-between;
	align-items: center;
}

.inFlightSvSearch--header--wrap {
	border-bottom: 1px solid #ebebeb;
	padding-bottom: 10px;
}

.inFlightSvSearch--img--wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 30px;
}

.inFlightSvSearch--description--wrap {
	margin-top: 30px;
	margin-bottom: 5px;
	font-size: 18px;
}

.ui-datepicker {
	font-size: 12px;
	width: 460px;
	height: 420px;
}

.ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year
	{
	font-size: 20px;
}

.ui-datepicker td span, .ui-datepicker td a {
	font-size: 20px;
}

#datepicker {
	display: flex;
	flex-direction: column;
	border: none;
	font-size: 20px;
	z-index: 9999 !important;
}

.hasDatepicker {
	position: relative;
	z-index: 9999;
}

.ui-datepicker {
	z-index: 9999 !important;
}
</style>
<div>
	<main>
		<div class="inFlightSvSearch--header--wrap">
			<h2>기내 서비스 조회</h2>
		</div>
		<div class="inFlightSvSearch--img--wrap">
			<img alt="" src="/images/in_flight/inFlightServiceImage1.jpg" width="1000" height="500">
		</div>

		<form action="#" method="post">
			<div class="inFlightSvSearch--description--wrap">출/도착지를 입력하여 상세 정보를 확인해 보세요.</div>

			<div class="modal--all--btn--div">
				<button type="button" id="modal--all--btn--id" class="all--btn--class" data-toggle="modal" data-target="#start">출발지</button>
				<button type="button" id="modal--all--btn--id" class="all--btn--class" data-toggle="modal" data-target="#arrival">도착지</button>
				<button type="button" id="modal--all--btn--id" class="all--btn--class" data-toggle="modal" data-target="#calendar">날짜 선택</button>
				<button type="submit" id="modal--all--btn--id" class="search--btn--class">조회</button>
			</div>
			<!-- The Modal -->
			<div class="modal fade" id="start">
				<div class="modal-dialog">
					<div class="modal-content">

						<div class="modal-header">
							<h4 class="modal-title">출발지 검색</h4>
							<button type="button" class="close" data-dismiss="modal">×</button>
						</div>

						<div class="modal-body">
							<input type="text" autocomplete="off" id="departure" name="departure" placeholder="도시, 공항 검색">
							<div class="rel--search">
								<ul class="pop--rel--keyword">
								</ul>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<div class="modal--all--region">
								<button type="button" class="btn btn-primary">모든 지역 보기</button>
							</div>
							<div class="modal--cancel--btn">
								<button type="button" id="start--modal--btn" class="btn btn-primary" data-dismiss="modal">Submit</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="arrival">
				<div class="modal-dialog">
					<div class="modal-content">

						<div class="modal-header">
							<h4 class="modal-title">도착지 검색</h4>
							<button type="button" class="close" data-dismiss="modal">×</button>
						</div>

						<div class="modal-body">
							<input type="text" autocomplete="off" name="departure" id="arrival--id" placeholder="도시, 공항 검색">
							<div class="rel--search">
								<ul class="pop--rel--keyword">
								</ul>
							</div>
						</div>

						<div class="modal-footer">
							<div class="modal--all--region">
								<button type="button" class="btn btn-primary">모든 지역 보기</button>
							</div>
							<div class="modal--cancel--btn">
								<button type="button" id="start--modal--btn" class="btn btn-primary" data-dismiss="modal">Submit</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" id="calendar">
				<div class="modal-dialog">
					<div class="modal-content">

						<div class="modal-header">
							<h4 class="modal-title">날짜 선택</h4>
							<button type="button" class="close" data-dismiss="modal">×</button>
						</div>

						<div class="modal-body">
							<%-- 여기 --%>
							<input type="text" id="datepicker">
							<div id="datepicker2"></div>

						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<div class="modal--all--region">
								<button type="button" class="btn btn-primary">모든 지역 보기</button>
							</div>
							<div class="modal--cancel--btn">
								<button type="button" id="start--modal--btn" class="btn btn-primary" data-dismiss="modal">Submit</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>


		<script src="/js/inFlightSvSearch.js"></script>
	</main>

</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
