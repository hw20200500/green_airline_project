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
.modal-footer {
	display: flex;
	justify-content: space-between;
}
</style>
<div>
	<main>

		<script>
			$(function() { //화면 로딩후 시작

				let List = [ "종로2가사거리", "창경궁.서울대학교병원", "명륜3가.성대입구", "종로2가.삼일교",
						"혜화동로터리.여운형활동터" ];

				$("#start--search").autocomplete({ //오토 컴플릿트 시작
					source : List, // source는 data.js파일 내부의 List 배열
					focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
						return false;
					},
					minLength : 1,// 최소 글자수
					delay : 100, //autocomplete 딜레이 시간(ms)
				//disabled: true, //자동완성 기능 끄기
				});
				console.log(List);
			});
		</script>
		
		<h1>기내 서비스 조회 페이지</h1>
		<div>
			<form action="/inFlightService/inFlightServiceSearch" method="post">
				<div>출/도착지를 입력하여 상세 정보를 확인해 보세요.</div>
				<div>
					<%-- input value 오늘 날짜 default로 셋팅 --%>
					<label for="select--datepicker"> 날짜 선택 </label><input class="datepicker" id="select--datepicker" value="">
					
					<script>
						$(function() {
							$('.datepicker').datepicker();
						})

						$.datepicker
								.setDefaults({
									dateFormat : 'yy-mm-dd',
									prevText : '이전 달',
									nextText : '다음 달',
									monthNames : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									monthNamesShort : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									dayNames : [ '일', '월', '화', '수', '목', '금',
											'토' ],
									dayNamesShort : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									showMonthAfterYear : true,
									yearSuffix : '년'
								});

						$(function() {
							$('.datepicker').datepicker();
						});
					</script>
				</div>
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
								<div class="modal--all--region">모든 지역 보기</div>
								<div class="modal--cancel--btn">
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
