<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<!-- 항공권 선택 페이지 -->

<style>
	.ticket--type {
		display: flex;
		border: 1px solid #ccc;
		align-items: center;
		width: 200px;
	}
	
	.ticket--type li {
		cursor: pointer;
		background-color: white;
		flex: 1;
		text-align: center;
		padding: 10px 0;
	}
	
	.selected--type {
		background-color: #8abbe1 !important;
	}
	
	#departure, #destination {
		text-align: center;
		padding: 20px 5px;
		font-size: 30px;
		width: 300px;
		font-weight: 600;
	}
	
	#airport--swap {
		/*border: 1px solid rgba(0, 0, 0, 0.2);*/
		border: none;
		background-color: white;
		height: 25px;
		border-radius: 20px;
		margin: 30px 15px;
	} 
	
	.airport--div {
		border: 1px solid #ccc;
		width: 400px;
		position: absolute;
		padding: 15px 20px 20px;
		display: none;
	}
	
	.airport--div h5 {
		margin-top: 10px;
		font-size: 18px;
		margin-bottom: 0;
	}
	
	.autocomplete--list {
		width: 100%;
		background-color: rgba(0, 0, 0, 0.1);
		height: auto;
		max-height: 200px;
		margin: 15px 0;
		padding: 0 10px;
		overflow: auto; /* max-height 넘으면 스크롤 생김 */
	}
	
	.autocomplete--list li {
		margin: 10px 0;
	}
	
	.all--airport {
		color: rgba(0, 0, 0, 0.7);
		border: 1px solid #ccc;
		border-radius: 5px;
		background-color: white;
		padding: 5px 7px 1px 3px;
	}
	
	.close--button {
		height: 24px;
		border: none;
		background: none;
		color: rgba(0, 0, 0, 0.7)
	}
	
	
	
</style>


	<main>
		<!-- 왕복/편도, 출발지/도착지, 탑승일, 탑승객 수/연령 -->
		<!-- 출발지 도착지 서로 바꾸는 버튼도 만들기 -->
		
		<!-- 왕복/편도 -->
		<!-- 우선 편도부터 -->
		<ul class="ticket--type">
			<li id="ticket--type1" onclick="selectedType(1);" class="selected--type">편도
			<li id="ticket--type2" onclick="selectedType(2);">왕복
		</ul>
		
		<div class="d-flex">
			<!-- 출발지 -->
			<div id="departure--div">
				<input type="text" name="departure" placeholder="출발지" id="departure" autocomplete="off">
				<!-- 자동완성 및 공항 선택 -->
				<div class="airport--div" id="departure--airport">
					<div class="d-flex justify-content-between">
						<h5>자동 완성</h5>
						<button class="close--button">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<ul class="autocomplete--list" id="departure--list">
					</ul>
					<div class="d-flex justify-content-center" style="width: 100%">
						<button class="all--airport">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">location_on</span>
								<li style="font-size: 15px;">전체 공항 조회
							</ul>
						</button>
					</div>
				</div>
			</div>
		
			<!-- 출발지 도착지 서로 바꾸는 버튼 -->
			<button id="airport--swap" onclick="airportSwap();">
				<span class="material-symbols-outlined" style="color: #4c4c4c; font-size: 28px;">swap_horiz</span>
			</button>
			
			
			<!-- 도착지 -->
			<div id="destination--div">
				<input type="text" name="destination" placeholder="도착지" id="destination" autocomplete="off">
				<!-- 자동완성 및 공항 선택 -->
				<div class="airport--div" id="destination--airport">
					<div class="d-flex justify-content-between">
						<h5>자동 완성</h5>
						<button class="close--button">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<ul class="autocomplete--list" id="destination--list">
					
					</ul>
					<div class="d-flex justify-content-center" style="width: 100%">
						<button class="all--airport">
							<ul class="d-flex justify-content-center" style="margin: 0;">
								<li><span class="material-symbols-outlined material--li" style="font-size: 22px;">location_on</span>
								<li style="font-size: 15px;">전체 공항 조회
							</ul>
						</button>
					</div>
				</div>
			</div>
		</div>
		
		<script>
		
		
			$("#departure").on("focus", function() {
				$(this).attr("placeholder", "");
			});
			
			$("#departure").on("blur", function() {
				$(this).attr("placeholder", "출발지");
			});
			
			$("#destination").on("focus", function() {
				$(this).attr("placeholder", "");
			});
			
			$("#destination").on("blur", function() {
				$(this).attr("placeholder", "도착지");
			})
			
			
		</script>
		
		
	</main>


<script src="/js/ticket.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
