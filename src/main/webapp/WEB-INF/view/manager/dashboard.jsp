<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<link rel="stylesheet" href="/css/ticket.css">

<!-- 대시보드 (관리자 페이지 메인) -->

<style>
	body {
		background-color: #eee;
	}
	
	main {
		width: 1320px;
		margin: 20px 0;
		height: 750px;
		padding: 0;
	}
	
	#salesChart {
		width: 640px;
		height: 243px;
		margin-left: -17px;
	}
	
	.small--board {
		background-color: white;
		height: 80px;
		width: 315px;
		box-shadow: 0 0 3px 3px #e5e5e5;
		padding: 15px;
	}
	
	.middle--board {
		background-color: white;
		height: 290px;
		width: 315px;
		box-shadow: 0 0 3px 3px #e5e5e5;
		padding: 12px;
	}
	
	.long--board {
		background-color: white;
		height: 290px;
		width: 650px;
		box-shadow: 0 0 3px 3px #e5e5e5;
		padding: 12px;
	}
	
	#dashboardTitle {
		font-weight: 600;
		margin-bottom: 20px;
	}
	
	.board--title {
		font-size: 17px;
		font-weight: 600;
		color: #404040;
		margin-bottom: 10px;
	}
	
	.small--board--title {
		font-size: 16px;
		color: gray;
	}
	
	#memoArea {
		resize: none;
		height: 225px;
		width: 280px;
		margin-left: 5px;
		margin-top: 5px;
		outline: none;
		border: 1px solid #ccc;
		padding: 10px 13px;
	}
	
</style>

<main class="d-flex flex-column">
	<h4 id="dashboardTitle">Dashboard</h4>
	<div class="d-flex justify-content-between" style="width: 100%; margin-bottom: 20px;">
		<div class="small--board">
			<h5 class="small--board--title"><%=LocalDateTime.now().getMonth().getValue() %>월 매출액</h5>
		
		</div>	
		<div class="small--board">
			<h5 class="small--board--title"><%=LocalDateTime.now().getMonth().getValue() %>월 신규 회원 수</h5>
		
		</div>	
		<div class="small--board">
			<h5 class="small--board--title"><%=LocalDateTime.now().getMonth().getValue() %>월 탈퇴 회원 수</h5>
		
		</div>	
		<div class="small--board">
			<h5 class="small--board--title">오늘 도착한 고객의 말씀</h5>
		
		</div>	
	</div>
	<div class="d-flex justify-content-between" style="width: 100%; margin-bottom: 20px;">
		<div class="middle--board">
			<h5 class="board--title">운항 노선 이용 순위</h5>
		</div>	
		<div class="long--board">
			<h5 class="board--title">월별 매출액 그래프</h5>
			<canvas id="salesChart"></canvas>
		</div>	
		<div class="middle--board">	
			<h5 class="board--title">메모</h5>
			<textarea id="memoArea">${memo.content}</textarea>
		</div>	
	</div>
	<div class="d-flex justify-content-between" style="width: 100%;">
		<div class="middle--board" style="height: 260px;">
			<h5 class="board--title">마일리지샵 인기 상품</h5>
		</div>	
		<div class="middle--board" style="height: 260px;">
			<h5 class="board--title">고객의 말씀 비율</h5>
		</div>	
		<div class="long--board" style="height: 260px;">
			<h5 class="board--title">처리되지 않은 문의 내역</h5>
		</div>	
	</div>

</main>

<script type="text/javascript">

	// 월별 매출액 그래프 
	let rawData = ${salesData};
	let jObject = JSON.stringify(rawData);
	let salesData = JSON.parse(jObject);

	let labelList = new Array();
	let valueList = new Array();
	
	for (let i = 0; i < salesData.length; i++) {
		let target = salesData[i];
		labelList.push(target.period);
		valueList.push(target.sales);
	}
	
	let data = {
			labels: labelList,
			datasets: [{
				// label: 범례 이름
				data: valueList,
				fill: false, // 아래 색 채우기 false
				borderColor: '#8abbe1',
				backgroundColor: '#8abbe1',
				tension: 0 // 꺾은선 그래프 각지게
			}]
	};
	
	let salesContext = document.getElementById('salesChart').getContext('2d');
	new Chart(salesContext, {
		type: 'line', 
		data: data,
		options: {
			responsive: false, // canvas에 너비/높이 주면 차트를 원하는 크기로 조정 가능
			tooltips: {
				callbacks: { // 콤마 처리
					label: function(tooltipItem, data) {
						var value = " " + data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toLocaleString();
					    return value;
					}
				},
				mode: "index",
				intersect: false // 가까이 가면 툴팁 보이게
			},
			scales: {
				yAxes: [{
					ticks: { // 콤마 처리
					 	beginAtZero: true,
						callback: function(value, index, values) {
							return (parseInt(value) / 1000000) + "M";
						}                            
					},
					gridLines: {
						color: "#bbb", 
						display: false // 그리드 선 제거
					}
				}],
				xAxes: [{
					gridLines: {
						color: "#bbb",
						display: false // 그리드 선 제거
					}
				}]
			},
			title: { // 차트 대제목 숨김
				display: false
			},
			legend: { // 범례 숨김
				display: false
			},
			layout: {
				padding: {
					left: 10,
					right: 10,
					top: 10,
					bottom: 10
				}
			},
			elements: {
				point: { 
					hoverRadius: 7, // hover 시 포인트 크기
					radius: 4 // 평소 포인트 크기
				}
			}
		}
	});
	
	// 메모 갱신
	$("#memoArea").on("blur", function() {
		let data = {
			content: $(this).val()
		};
		
		$.ajax({
			type: 'POST',
			url: '/manager/updateMemo',
			contentType: 'application/json; charset=UTF-8',
			data: JSON.stringify(data),
			dataType: 'json'
		})
		.done((res) => {
			console.log("통신 성공");
		})
		.fail((error) => {
			console.log(error);
		});
	});

</script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
