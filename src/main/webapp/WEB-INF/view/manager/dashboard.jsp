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

<!-- 차트 -->

<style>
</style>

<main class="d-flex flex-column">
	<br>
	<div class="d-flex flex-column align-items-center" style="width: 100%;">
		<h5 class="small--title" style="margin-bottom: 35px;">
			<span class="material-symbols-outlined">airplane_ticket</span>
			<span>월간 매출액 추이</span>
		</h5>
		<!--차트가 그려질 부분-->
		<div style="width: 900px;">
			<canvas id="salesChart"></canvas>
		</div>
	
	</div>

</main>

<script type="text/javascript">

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
	
	let context = document.getElementById('salesChart').getContext('2d');
	new Chart(context, {
		type: 'line', 
		data: data,
		options: {
			tooltips: {
				callbacks: { // 콤마 처리
					label: function(tooltipItem, data) {
						var value = " " + data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toLocaleString() + '원';
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
							if (parseInt(value) >= 1000) {
						    	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ '원';
						    } else {
						    	return value + '원';
						    }
						}                            
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
	
	

</script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
